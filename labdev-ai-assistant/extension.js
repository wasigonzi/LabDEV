const vscode = require('vscode');

let chatPanel = null;
let statusBarItem = null;

class ChatViewProvider {
    constructor(extensionUri) {
        this._extensionUri = extensionUri;
    }

    resolveWebviewView(webviewView) {
        this._view = webviewView;

        webviewView.webview.options = {
            enableScripts: true,
            localResourceRoots: [this._extensionUri]
        };

        webviewView.webview.html = getChatHtml();

        webviewView.webview.onDidReceiveMessage(async data => {
            if (data.type === 'sendMessage') {
                await handleChatMessage(data.message, webviewView.webview);
            }
        });
    }
}

async function handleChatMessage(message, webview) {
    webview.postMessage({
        type: 'addMessage',
        role: 'user',
        content: message
    });

    webview.postMessage({
        type: 'addMessage',
        role: 'assistant',
        content: '💜 Pensando...'
    });

    try {
        const config = vscode.workspace.getConfiguration('labdev-ai');
        const apiKey = config.get('apiKey');

        if (!apiKey) {
            webview.postMessage({
                type: 'updateLast',
                content: '⚠️ Configura tu API Key de HuggingFace\n\nVe a: File → Preferences → Settings → LabDev AI\n\nObtén una GRATIS en: https://huggingface.co/settings/tokens'
            });
            return;
        }

        const { HfInference } = require('@huggingface/inference');
        const hf = new HfInference(apiKey);
        const model = config.get('model') || 'mistralai/Mistral-7B-Instruct-v0.2';

        const response = await hf.textGeneration({
            model: model,
            inputs: message,
            parameters: {
                max_new_tokens: 500,
                temperature: 0.7,
                return_full_text: false
            }
        });

        webview.postMessage({
            type: 'updateLast',
            content: response.generated_text.trim()
        });

    } catch (error) {
        webview.postMessage({
            type: 'updateLast',
            content: `❌ Error: ${error.message}\n\nVerifica tu API Key en Settings.`
        });
    }
}

function getChatHtml() {
    return `<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: var(--vscode-font-family);
            background: var(--vscode-editor-background);
            color: var(--vscode-editor-foreground);
            height: 100vh;
            display: flex;
            flex-direction: column;
        }
        #header {
            padding: 12px;
            background: #1a1a1a;
            border-bottom: 2px solid #ff00ff;
            text-align: center;
        }
        #header h3 {
            color: #ff00ff;
            font-size: 14px;
            margin: 0;
        }
        #messages {
            flex: 1;
            overflow-y: auto;
            padding: 10px;
        }
        .message {
            margin-bottom: 12px;
            padding: 10px;
            border-radius: 6px;
            font-size: 13px;
            line-height: 1.5;
        }
        .user {
            background: #2d2d2d;
            border-left: 3px solid #ff00ff;
        }
        .assistant {
            background: #1e1e1e;
            border-left: 3px solid #ff00ff;
        }
        .role {
            font-weight: bold;
            color: #ff00ff;
            font-size: 11px;
            margin-bottom: 4px;
        }
        #inputArea {
            padding: 10px;
            background: #1a1a1a;
            border-top: 1px solid #2d2d2d;
            display: flex;
            gap: 8px;
        }
        #messageInput {
            flex: 1;
            background: #2d2d2d;
            color: var(--vscode-editor-foreground);
            border: 1px solid #ff00ff;
            padding: 8px;
            border-radius: 4px;
            font-size: 13px;
        }
        #sendBtn {
            background: #ff00ff;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            font-size: 12px;
        }
        #sendBtn:hover { background: #ff33ff; }
        code {
            background: #0d0d0d;
            padding: 2px 6px;
            border-radius: 3px;
            color: #ff00ff;
        }
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #1a1a1a; }
        ::-webkit-scrollbar-thumb { background: #ff00ff; border-radius: 4px; }
    </style>
</head>
<body>
    <div id="header">
        <h3>💜 LabDev AI Assistant</h3>
    </div>
    <div id="messages">
        <div class="message assistant">
            <div class="role">LabDev AI</div>
            <div>¡Hola! Soy tu asistente de IA. Puedo ayudarte con código, explicaciones y preguntas. ¿En qué puedo ayudarte?</div>
        </div>
    </div>
    <div id="inputArea">
        <input type="text" id="messageInput" placeholder="Pregunta algo..." />
        <button id="sendBtn">Enviar</button>
    </div>
    <script>
        const vscode = acquireVsCodeApi();
        const messagesDiv = document.getElementById('messages');
        const messageInput = document.getElementById('messageInput');
        const sendBtn = document.getElementById('sendBtn');

        function addMessage(role, content) {
            const messageDiv = document.createElement('div');
            messageDiv.className = 'message ' + role;
            
            const roleDiv = document.createElement('div');
            roleDiv.className = 'role';
            roleDiv.textContent = role === 'user' ? 'Tú' : 'LabDev AI';
            
            const contentDiv = document.createElement('div');
            contentDiv.textContent = content;
            
            messageDiv.appendChild(roleDiv);
            messageDiv.appendChild(contentDiv);
            messagesDiv.appendChild(messageDiv);
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
        }

        function sendMessage() {
            const text = messageInput.value.trim();
            if (!text) return;

            addMessage('user', text);
            vscode.postMessage({ type: 'sendMessage', message: text });
            messageInput.value = '';
        }

        sendBtn.addEventListener('click', sendMessage);
        messageInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') sendMessage();
        });

        window.addEventListener('message', event => {
            const message = event.data;
            if (message.type === 'addMessage') {
                addMessage(message.role, message.content);
            } else if (message.type === 'updateLast') {
                const lastMsg = messagesDiv.lastElementChild;
                if (lastMsg) {
                    lastMsg.querySelector('div:last-child').textContent = message.content;
                }
            } else if (message.type === 'setInput') {
                messageInput.value = message.text;
            }
        });
    </script>
</body>
</html>`;
}

function activate(context) {
    console.log('LabDev AI Assistant activating...');
    
    // Registrar el webview provider para la vista en la barra lateral
    const provider = new ChatViewProvider(context.extensionUri);
    context.subscriptions.push(
        vscode.window.registerWebviewViewProvider('labdev-ai-chat', provider)
    );

    // Crear botón en barra de estado
    statusBarItem = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Right, 100);
    statusBarItem.text = "$(sparkle) LabDev AI";
    statusBarItem.tooltip = "Abrir Chat con IA (Ctrl+Shift+L)";
    statusBarItem.command = 'labdev-ai.openChat';
    statusBarItem.backgroundColor = new vscode.ThemeColor('statusBarItem.prominentBackground');
    statusBarItem.show();
    context.subscriptions.push(statusBarItem);

    // Comando para abrir chat en panel
    context.subscriptions.push(
        vscode.commands.registerCommand('labdev-ai.openChat', () => {
            if (chatPanel) {
                chatPanel.reveal(vscode.ViewColumn.Two);
            } else {
                chatPanel = vscode.window.createWebviewPanel(
                    'labdevAiChat',
                    '💜 LabDev AI',
                    vscode.ViewColumn.Two,
                    {
                        enableScripts: true,
                        retainContextWhenHidden: true
                    }
                );

                chatPanel.webview.html = getChatHtml();

                chatPanel.webview.onDidReceiveMessage(
                    async message => {
                        if (message.type === 'sendMessage') {
                            await handleChatMessage(message.message, chatPanel.webview);
                        }
                    }
                );

                chatPanel.onDidDispose(() => {
                    chatPanel = null;
                });
            }
        })
    );

    // Comando para explicar código
    context.subscriptions.push(
        vscode.commands.registerCommand('labdev-ai.explainCode', async () => {
            const editor = vscode.window.activeTextEditor;
            if (!editor) return;
            const selection = editor.document.getText(editor.selection);
            if (selection) {
                vscode.commands.executeCommand('labdev-ai.openChat');
                setTimeout(() => {
                    if (chatPanel) {
                        chatPanel.webview.postMessage({
                            type: 'setInput',
                            text: `Explica este código:\n\n${selection}`
                        });
                    }
                }, 500);
            }
        })
    );
}

function deactivate() {}

module.exports = { activate, deactivate };
