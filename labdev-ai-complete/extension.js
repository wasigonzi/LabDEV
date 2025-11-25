const vscode = require('vscode');
const fs = require('fs').promises;
const path = require('path');
const https = require('https');

class LabDevAIProvider {
    constructor(context) {
        this._context = context;
        this._view = null;
        this._conversationHistory = [];
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

            const actions = await this._detectActions(userMessage);
            let contextInfo = '';
            if (actions.length > 0) {
                contextInfo = await this._executeActions(actions);
            }

            const fullPrompt = this._buildPrompt(userMessage, contextInfo);
            const response = await this._callAI(fullPrompt, apiKey);

            this._conversationHistory.push({ role: 'assistant', content: response });
            this._postMessage({ type: 'aiMessage', content: response });

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
