function getHtml() {
    return `<!DOCTYPE html>
<html><head><meta charset="UTF-8"><style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;background:#1a1a1a;color:#fff;height:100vh;display:flex;flex-direction:column;overflow:hidden}
#header{padding:16px 20px;background:#1a1a1a;border-bottom:1px solid #2d2d2d;flex-shrink:0}
#title-row{display:flex;justify-content:space-between;align-items:center;margin-bottom:12px}
#title-area{display:flex;align-items:center;gap:10px}
#title{color:#ff00ff;font-weight:600;font-size:18px}
#subtitle{color:#888;font-size:13px}
.btn{background:transparent;border:none;color:#fff;font-size:16px;cursor:pointer;padding:4px 8px;border-radius:4px}
.btn:hover{background:rgba(255,255,255,0.1)}
#messages{flex:1;overflow-y:auto;padding:20px}
#welcome-card{background:#252525;padding:20px;border-radius:12px;border:1px solid #3d3d3d;margin-bottom:20px}
#welcome-title{color:#ff00ff;font-weight:600;font-size:15px;margin-bottom:12px}
#welcome-desc{color:#ccc;font-size:13px;line-height:1.6;margin-bottom:12px}
.great-for{color:#888;font-size:12px;margin-bottom:8px;font-weight:600}
ul{color:#aaa;font-size:12px;line-height:1.8;padding-left:20px}
.message{padding:14px 16px;border-radius:10px;margin-bottom:12px;border-left:3px solid #ff00ff}
.message.user{background:#252525}
.message.ai{background:#1e1e1e}
.message-content{color:#fff;font-size:14px;line-height:1.6;white-space:pre-wrap}
#input-area{padding:16px 20px;background:#1a1a1a;border-top:1px solid #2d2d2d;flex-shrink:0}
#input-wrapper{display:flex;align-items:center;background:#252525;border:1px solid #3d3d3d;border-radius:8px;padding:12px}
#input{flex:1;background:transparent;color:#fff;border:none;outline:none;font-size:14px;resize:none;font-family:inherit;line-height:1.5;max-height:120px}
#send-btn{background:#ff00ff;color:#fff;border:none;width:32px;height:32px;border-radius:6px;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;margin-left:8px;flex-shrink:0}
#send-btn:hover{background:#ff33ff}
::-webkit-scrollbar{width:8px}
::-webkit-scrollbar-track{background:#1a1a1a}
::-webkit-scrollbar-thumb{background:#3d3d3d;border-radius:4px}
</style></head><body>
<div id="header">
<div id="title-row">
<div id="title-area"><span style="font-size:20px">💬</span><div id="title">Let's build</div></div>
<button class="btn" onclick="openConfig()">⚙️</button>
</div>
<div id="subtitle">Plan, search, or build anything</div>
</div>
<div id="messages">
<div id="welcome-card">
<div id="welcome-title">💜 Vibe</div>
<div id="welcome-desc">Chat first, then build. Explore ideas and iterate as you discover needs.</div>
<div class="great-for">Great for:</div>
<ul><li>Rapid exploration and testing</li><li>Building when requirements are unclear</li><li>Implementing a task</li></ul>
</div>
</div>
<div id="input-area">
<div id="input-wrapper">
<button class="btn" style="color:#888;font-size:16px;padding:0 8px;margin-right:4px">#</button>
<button class="btn" style="font-size:16px;padding:0 8px;margin-right:8px">😊</button>
<textarea id="input" rows="1" placeholder="Ask a question or describe a task..."></textarea>
<button id="send-btn" onclick="sendMessage()">↑</button>
</div>
</div>
<script>
const vscode=acquireVsCodeApi();
const messages=document.getElementById('messages');
const input=document.getElementById('input');
input.oninput=()=>{input.style.height='auto';input.style.height=input.scrollHeight+'px'};
input.onkeydown=(e)=>{if(e.key==='Enter'&&!e.shiftKey){e.preventDefault();sendMessage()}};
function sendMessage(){const text=input.value.trim();if(!text)return;vscode.postMessage({type:'sendMessage',text:text});input.value='';input.style.height='auto'}
function addMessage(role,content){const msg=document.createElement('div');msg.className='message '+role;const msgContent=document.createElement('div');msgContent.className='message-content';msgContent.textContent=content;msg.appendChild(msgContent);messages.appendChild(msg);messages.scrollTop=messages.scrollHeight;return msg}
function openConfig(){vscode.postMessage({type:'getConfig'})}
window.addEventListener('message',event=>{const msg=event.data;switch(msg.type){case 'userMessage':addMessage('user',msg.content);break;case 'thinking':addMessage('ai','💜 Pensando...');break;case 'aiMessage':const lastMsg=messages.lastElementChild;if(lastMsg&&lastMsg.textContent.includes('Pensando')){lastMsg.querySelector('.message-content').textContent=msg.content}else{addMessage('ai',msg.content)}break;case 'config':showConfigModal(msg.apiKey);break;case 'configSaved':const modal=document.querySelector('.modal');if(modal)modal.remove();addMessage('ai','✓ Configuración guardada');break}});
function showConfigModal(apiKey){const modal=document.createElement('div');modal.className='modal';modal.style.cssText='position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.8);display:flex;align-items:center;justify-content:center;z-index:9999';modal.innerHTML=\`<div style="background:#2d2d2d;padding:24px;border-radius:12px;width:90%;max-width:400px;border:1px solid #3d3d3d"><div style="color:#ff00ff;font-size:18px;font-weight:600;margin-bottom:16px">⚙️ Configuración</div><div style="color:#ccc;font-size:13px;margin-bottom:8px">API Key de HuggingFace:</div><input type="password" id="api-key" value="\${apiKey}" placeholder="hf_..." style="width:100%;background:#1e1e1e;color:#fff;border:1px solid #3d3d3d;padding:10px;border-radius:6px;font-size:13px;margin-bottom:12px"><div style="color:#888;font-size:12px;margin-bottom:16px;line-height:1.5">Obtén tu API Key gratis en: <a href="https://huggingface.co/settings/tokens" target="_blank" style="color:#ff00ff">huggingface.co/settings/tokens</a></div><div style="display:flex;gap:8px;justify-content:flex-end"><button onclick="closeModal()" style="background:transparent;color:#ccc;border:1px solid #3d3d3d;padding:8px 16px;border-radius:6px;cursor:pointer;font-size:13px">Cancelar</button><button onclick="saveConfig()" style="background:#ff00ff;color:#fff;border:none;padding:8px 16px;border-radius:6px;cursor:pointer;font-size:13px;font-weight:600">Guardar</button></div></div>\`;document.body.appendChild(modal);document.getElementById('api-key').focus()}
function closeModal(){const modal=document.querySelector('.modal');if(modal)modal.remove()}
function saveConfig(){const apiKey=document.getElementById('api-key').value.trim();vscode.postMessage({type:'saveConfig',apiKey:apiKey})}
</script>
</body></html>`;
}

module.exports = { getHtml };
