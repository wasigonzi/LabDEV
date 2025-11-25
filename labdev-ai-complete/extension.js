const vscode = require('vscode');
const fs = require('fs').promises;
const path = require('path');
const https = require('https');

class LabDevAIProvider {
    constructor(context) {
        this._context = context;
        this._view = null;
        this._conversationHistory = [];
        this._approvalMode = 'agent'; // 'chat', 'agent', 'agent-full'
        this._pendingEdits = [];
    }

    resolveWebviewView(webviewView) {
        this._view = webviewView;
        
        webviewView.webview.options = {
            enableScripts: true,
            localResourceRoots: [this._context.extensionUri]
        };

        webviewView.webview.html = this._getHtmlContent();
        
        webviewView.webview.onDidReceiveMessage(async (message) => {
            await this._handleMessage(message);
        });
    }

    async _handleMessage(message) {
        switch (message.type) {
            case 'sendMessage':
                await this._processUserMessage(message.text);
                break;
            case 'getConfig':
                this._sendConfig();
                break;
            case 'saveConfig':
                await this._saveConfig(message.apiKey);
                break;
            case 'setMode':
                this._approvalMode = message.mode;
                this._postMessage({ type: 'modeChanged', mode: message.mode });
                break;
            case 'applyEdit':
                await this._applyEdit(message.edit);
                break;
            case 'rejectEdit':
                this._postMessage({ type: 'editRejected', editId: message.editId });
                break;
        }
    }

    async _processUserMessage(userMessage) {
        this._conversationHistory.push({ role: 'user', content: userMessage });
        this._postMessage({ type: 'userMessage', content: userMessage });
        this._postMessage({ type: 'thinking' });

        try {
            const config = vscode.workspace.getConfiguration('labdev-ai');
            const apiKey = config.get('apiKey');

            if (!apiKey) {
                this._postMessage({
                    type: 'aiMessage',
                    content: 'Por favor configura tu API Key de HuggingFace en Settings o haz clic en el boton de configuracion.'
                });
                return;
            }

            // Procesar referencias @archivo
            const { processedMessage, referencedFiles } = await this._processFileReferences(userMessage);
            
            // Detectar acciones según el modo
            const actions = await this._detectActions(processedMessage);
            let contextInfo = referencedFiles;
            
            // En modo Chat, solo responder sin ejecutar acciones
            if (this._approvalMode === 'chat') {
                const fullPrompt = this._buildPrompt(processedMessage, contextInfo);
                const response = await this._callAI(fullPrompt, apiKey);
                this._conversationHistory.push({ role: 'assistant', content: response });
                this._postMessage({ type: 'aiMessage', content: response });
                return;
            }

            // En modo Agent, ejecutar acciones con aprobación
            if (actions.length > 0) {
                const actionResults = await this._executeActions(actions);
                contextInfo += '\n\n' + actionResults;
            }

            const fullPrompt = this._buildPrompt(processedMessage, contextInfo);
            const response = await this._callAI(fullPrompt, apiKey);

            // Detectar si la respuesta incluye ediciones de código
            const edits = this._detectCodeEdits(response);
            if (edits.length > 0 && this._approvalMode !== 'agent-full') {
                this._postMessage({ 
                    type: 'aiMessageWithEdits', 
                    content: response,
                    edits: edits 
                });
            } else if (edits.length > 0 && this._approvalMode === 'agent-full') {
                // Aplicar automáticamente en modo Full Access
                for (const edit of edits) {
                    await this._applyEdit(edit);
                }
                this._postMessage({ type: 'aiMessage', content: response });
            } else {
                this._postMessage({ type: 'aiMessage', content: response });
            }

            this._conversationHistory.push({ role: 'assistant', content: response });

        } catch (error) {
            this._postMessage({ type: 'aiMessage', content: `Error: ${error.message}` });
        }
    }

    async _detectActions(message) {
        const actions = [];
        const lowerMsg = message.toLowerCase();

        if (lowerMsg.includes('lee') || lowerMsg.includes('read') || lowerMsg.includes('muestra')) {
            const fileMatch = message.match(/[\w\-\.\/]+\.(js|ts|json|md|txt|py|html|css)/i);
            if (fileMatch) actions.push({ type: 'readFile', path: fileMatch[0] });
        }

        if (lowerMsg.includes('lista') || lowerMsg.includes('list') || lowerMsg.includes('archivos')) {
            actions.push({ type: 'listFiles' });
        }

        return actions;
    }

    async _executeActions(actions) {
        let results = [];
        for (const action of actions) {
            try {
                if (action.type === 'readFile') {
                    const content = await this._readFile(action.path);
                    results.push(`Contenido de ${action.path}:\n${content}`);
                } else if (action.type === 'listFiles') {
                    const files = await this._listFiles();
                    results.push(`Archivos: ${files.join(', ')}`);
                }
            } catch (error) {
                results.push(`Error: ${error.message}`);
            }
        }
        return results.join('\n\n');
    }

    async _readFile(filePath) {
        const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
        if (!workspaceFolder) throw new Error('No hay workspace abierto');
        const fullPath = path.join(workspaceFolder.uri.fsPath, filePath);
        return await fs.readFile(fullPath, 'utf8');
    }

    async _listFiles() {
        const files = await vscode.workspace.findFiles('**/*', '**/node_modules/**', 50);
        return files.map(f => vscode.workspace.asRelativePath(f));
    }

    async _processFileReferences(message) {
        const filePattern = /@([\w\-\.\/]+\.\w+)/g;
        const matches = [...message.matchAll(filePattern)];
        let referencedFiles = '';
        let processedMessage = message;

        for (const match of matches) {
            const filePath = match[1];
            try {
                const content = await this._readFile(filePath);
                referencedFiles += `\n\n--- Archivo: ${filePath} ---\n${content}\n`;
                processedMessage = processedMessage.replace(match[0], `el archivo ${filePath}`);
            } catch (error) {
                referencedFiles += `\n\n--- Error al leer ${filePath}: ${error.message} ---\n`;
            }
        }

        return { processedMessage, referencedFiles };
    }

    _detectCodeEdits(response) {
        const edits = [];
        const codeBlockPattern = /```(\w+)?\n([\s\S]+?)```/g;
        const filePathPattern = /(?:archivo|file|path):\s*([\w\-\.\/]+\.\w+)/i;
        
        let match;
        while ((match = codeBlockPattern.exec(response)) !== null) {
            const language = match[1] || 'text';
            const code = match[2];
            
            // Buscar nombre de archivo en el contexto cercano
            const contextBefore = response.substring(Math.max(0, match.index - 200), match.index);
            const fileMatch = contextBefore.match(filePathPattern);
            
            if (fileMatch) {
                edits.push({
                    id: Date.now() + Math.random(),
                    filePath: fileMatch[1],
                    language: language,
                    code: code,
                    action: 'replace'
                });
            }
        }

        return edits;
    }

    async _applyEdit(edit) {
        try {
            const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
            if (!workspaceFolder) throw new Error('No hay workspace abierto');
            
            const filePath = path.join(workspaceFolder.uri.fsPath, edit.filePath);
            const fileUri = vscode.Uri.file(filePath);
            
            // Crear o sobrescribir archivo
            await vscode.workspace.fs.writeFile(fileUri, Buffer.from(edit.code, 'utf8'));
            
            // Abrir el archivo editado
            const document = await vscode.workspace.openTextDocument(fileUri);
            await vscode.window.showTextDocument(document);
            
            this._postMessage({ 
                type: 'editApplied', 
                editId: edit.id,
                filePath: edit.filePath 
            });
            
            vscode.window.showInformationMessage(`✓ Archivo actualizado: ${edit.filePath}`);
        } catch (error) {
            this._postMessage({ 
                type: 'editError', 
                editId: edit.id,
                error: error.message 
            });
            vscode.window.showErrorMessage(`Error al aplicar edición: ${error.message}`);
        }
    }

    _buildPrompt(userMessage, contextInfo) {
        let prompt = '';
        if (contextInfo) prompt += `Contexto:\n${contextInfo}\n\n`;
        prompt += `Usuario: ${userMessage}\n\nAsistente:`;
        return prompt;
    }

    async _callAI(prompt, apiKey) {
        return new Promise((resolve, reject) => {
            const postData = JSON.stringify({
                inputs: prompt,
                parameters: {
                    max_new_tokens: 500,
                    temperature: 0.7,
                    return_full_text: false
                }
            });

            const options = {
                hostname: 'api-inference.huggingface.co',
                port: 443,
                path: '/models/mistralai/Mistral-7B-Instruct-v0.2',
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${apiKey}`,
                    'Content-Type': 'application/json',
                    'Content-Length': Buffer.byteLength(postData)
                }
            };

            const req = https.request(options, (res) => {
                let data = '';

                res.on('data', (chunk) => {
                    data += chunk;
                });

                res.on('end', () => {
                    try {
                        if (res.statusCode === 401) {
                            reject(new Error('API Key inválida. Verifica tu clave en Settings.'));
                            return;
                        }
                        if (res.statusCode === 503) {
                            reject(new Error('El modelo está cargando. Espera 20 segundos e intenta de nuevo.'));
                            return;
                        }
                        if (res.statusCode !== 200) {
                            reject(new Error(`Error ${res.statusCode}: ${res.statusMessage}`));
                            return;
                        }

                        const result = JSON.parse(data);
                        
                        if (Array.isArray(result) && result[0] && result[0].generated_text) {
                            resolve(result[0].generated_text.trim());
                        } else if (result.error) {
                            reject(new Error(result.error));
                        } else {
                            reject(new Error('Respuesta inesperada de la API'));
                        }
                    } catch (error) {
                        reject(new Error('Error al procesar respuesta: ' + error.message));
                    }
                });
            });

            req.on('error', (error) => {
                reject(new Error('Error de conexión: ' + error.message + '. Verifica tu internet.'));
            });

            req.write(postData);
            req.end();
        });
    }

    _sendConfig() {
        const config = vscode.workspace.getConfiguration('labdev-ai');
        this._postMessage({ type: 'config', apiKey: config.get('apiKey') || '' });
    }

    async _saveConfig(apiKey) {
        const config = vscode.workspace.getConfiguration('labdev-ai');
        await config.update('apiKey', apiKey, vscode.ConfigurationTarget.Global);
        this._postMessage({ type: 'configSaved' });
    }

    _postMessage(message) {
        if (this._view) this._view.webview.postMessage(message);
    }

    _getHtmlContent() {
        return require('./webview.js').getHtml();
    }
}

function activate(context) {
    const provider = new LabDevAIProvider(context);
    context.subscriptions.push(
        vscode.window.registerWebviewViewProvider('labdev-ai-chat', provider, {
            webviewOptions: { retainContextWhenHidden: true }
        })
    );
    context.subscriptions.push(
        vscode.commands.registerCommand('labdev-ai.openChat', () => {
            vscode.commands.executeCommand('workbench.view.extension.labdev-ai-complete');
        })
    );
}

function deactivate() {}

module.exports = { activate, deactivate };
