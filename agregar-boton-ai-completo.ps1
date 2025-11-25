# Script COMPLETO - Chat AI 100% funcional estilo Kiro
Write-Host "=== Instalando Chat AI Completo ===" -ForegroundColor Magenta

$workbenchPath = "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js"
$backupPath = "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js.backup"

if (Test-Path $backupPath) {
    Write-Host "Restaurando desde backup..." -ForegroundColor Yellow
    Copy-Item $backupPath $workbenchPath -Force
}

Write-Host "Leyendo workbench..." -ForegroundColor Yellow
$content = Get-Content $workbenchPath -Raw -Encoding UTF8

$injectionCode = @'
(function(){
if(window.labdevAIComplete)return;
window.labdevAIComplete=true;
let chatPanel=null;
let conversationHistory=[];
let apiKey='';
function loadApiKey(){
try{
const stored=localStorage.getItem('labdev-ai-apikey');
if(stored)apiKey=stored;
}catch(e){}
}
function saveApiKey(key){
apiKey=key;
try{
localStorage.setItem('labdev-ai-apikey',key);
}catch(e){}
}
async function sendToAI(message){
if(!apiKey){
return 'Por favor, configura tu API Key de HuggingFace primero. Haz clic en el icono de configuración (⚙️) arriba.';
}
try{
const response=await fetch('https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.2',{
method:'POST',
headers:{
'Authorization':'Bearer '+apiKey,
'Content-Type':'application/json'
},
body:JSON.stringify({
inputs:message,
parameters:{
max_new_tokens:500,
temperature:0.7,
return_full_text:false
}
})
});
if(!response.ok){
if(response.status===401){
return 'API Key inválida. Por favor verifica tu clave en la configuración.';
}
throw new Error('Error '+response.status);
}
const data=await response.json();
if(data[0]&&data[0].generated_text){
return data[0].generated_text;
}else if(data.error){
return 'Error: '+data.error;
}
return 'No se pudo obtener respuesta.';
}catch(error){
return 'Error de conexión: '+error.message+'. Verifica tu API Key y conexión a internet.';
}
}
function createChatPanel(){
if(chatPanel&&document.body.contains(chatPanel))return;
loadApiKey();
chatPanel=document.createElement('div');
chatPanel.id='labdev-ai-panel';
chatPanel.style.cssText='position:fixed;top:35px;right:0;width:450px;height:calc(100vh - 35px);background:#1a1a1a;border-left:2px solid #ff00ff;z-index:99999;display:none;flex-direction:column;box-shadow:-5px 0 20px rgba(0,0,0,0.5);font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif;';
const header=document.createElement('div');
header.style.cssText='padding:16px 20px;background:#1a1a1a;border-bottom:1px solid #2d2d2d;display:flex;justify-content:space-between;align-items:center;';
const titleArea=document.createElement('div');
titleArea.style.display='flex';
titleArea.style.alignItems='center';
titleArea.style.gap='10px';
const icon=document.createElement('span');
icon.textContent='💬';
icon.style.fontSize='20px';
const title=document.createElement('div');
title.textContent="Let's build";
title.style.cssText='color:#ff00ff;font-weight:600;font-size:18px;';
titleArea.appendChild(icon);
titleArea.appendChild(title);
const headerBtns=document.createElement('div');
headerBtns.style.display='flex';
headerBtns.style.gap='8px';
const settingsBtn=document.createElement('button');
settingsBtn.textContent='⚙️';
settingsBtn.style.cssText='background:transparent;border:none;color:#fff;font-size:16px;cursor:pointer;padding:4px 8px;border-radius:4px;';
settingsBtn.onmouseover=()=>{settingsBtn.style.background='rgba(255,255,255,0.1)';};
settingsBtn.onmouseout=()=>{settingsBtn.style.background='transparent';};
settingsBtn.onclick=()=>showSettings();
const closeBtn=document.createElement('button');
closeBtn.textContent='✕';
closeBtn.style.cssText='background:transparent;border:none;color:#fff;font-size:18px;cursor:pointer;padding:4px 8px;border-radius:4px;';
closeBtn.onmouseover=()=>{closeBtn.style.background='rgba(255,255,255,0.1)';};
closeBtn.onmouseout=()=>{closeBtn.style.background='transparent';};
closeBtn.onclick=()=>{chatPanel.style.display='none';};
headerBtns.appendChild(settingsBtn);
headerBtns.appendChild(closeBtn);
header.appendChild(titleArea);
header.appendChild(headerBtns);
const subtitle=document.createElement('div');
subtitle.textContent='Plan, search, or build anything';
subtitle.style.cssText='padding:12px 20px;color:#888;font-size:13px;background:#1a1a1a;border-bottom:1px solid #2d2d2d;';
const messages=document.createElement('div');
messages.id='ai-messages';
messages.style.cssText='flex:1;overflow-y:auto;padding:20px;background:#1a1a1a;';
const welcomeCard=document.createElement('div');
welcomeCard.style.cssText='background:#252525;padding:20px;border-radius:12px;border:1px solid #3d3d3d;margin-bottom:20px;';
const welcomeTitle=document.createElement('div');
welcomeTitle.textContent='💜 Vibe';
welcomeTitle.style.cssText='color:#ff00ff;font-weight:600;font-size:15px;margin-bottom:12px;';
const welcomeDesc=document.createElement('div');
welcomeDesc.textContent='Chat first, then build. Explore ideas and iterate as you discover needs.';
welcomeDesc.style.cssText='color:#ccc;font-size:13px;line-height:1.6;margin-bottom:12px;';
const greatFor=document.createElement('div');
greatFor.textContent='Great for:';
greatFor.style.cssText='color:#888;font-size:12px;margin-bottom:8px;font-weight:600;';
const list=document.createElement('ul');
list.style.cssText='color:#aaa;font-size:12px;line-height:1.8;margin:0;padding-left:20px;';
['Rapid exploration and testing','Building when requirements are unclear','Implementing a task'].forEach(text=>{
const li=document.createElement('li');
li.textContent=text;
list.appendChild(li);
});
welcomeCard.appendChild(welcomeTitle);
welcomeCard.appendChild(welcomeDesc);
welcomeCard.appendChild(greatFor);
welcomeCard.appendChild(list);
messages.appendChild(welcomeCard);
const inputArea=document.createElement('div');
inputArea.style.cssText='padding:16px 20px;background:#1a1a1a;border-top:1px solid #2d2d2d;';
const inputWrapper=document.createElement('div');
inputWrapper.style.cssText='position:relative;display:flex;align-items:center;background:#252525;border:1px solid #3d3d3d;border-radius:8px;padding:12px;transition:border-color 0.2s;';
const hashBtn=document.createElement('button');
hashBtn.textContent='#';
hashBtn.style.cssText='background:transparent;border:none;color:#888;font-size:16px;cursor:pointer;padding:0 8px;margin-right:4px;';
const emojiBtn=document.createElement('button');
emojiBtn.textContent='😊';
emojiBtn.style.cssText='background:transparent;border:none;font-size:16px;cursor:pointer;padding:0 8px;margin-right:8px;';
const input=document.createElement('textarea');
input.placeholder='Ask a question or describe a task...';
input.rows=1;
input.style.cssText='flex:1;background:transparent;color:#fff;border:none;outline:none;font-size:14px;resize:none;font-family:inherit;line-height:1.5;max-height:120px;';
input.oninput=()=>{
input.style.height='auto';
input.style.height=input.scrollHeight+'px';
};
const sendBtn=document.createElement('button');
sendBtn.textContent='↑';
sendBtn.style.cssText='background:#ff00ff;color:#fff;border:none;width:32px;height:32px;border-radius:6px;cursor:pointer;font-size:18px;font-weight:bold;display:flex;align-items:center;justify-content:center;margin-left:8px;transition:background 0.2s;';
sendBtn.onmouseover=()=>{sendBtn.style.background='#ff33ff';};
sendBtn.onmouseout=()=>{sendBtn.style.background='#ff00ff';};
sendBtn.onclick=()=>sendMessage();
input.onkeypress=(e)=>{if(e.key==='Enter'&&!e.shiftKey){e.preventDefault();sendMessage();}};
inputWrapper.appendChild(hashBtn);
inputWrapper.appendChild(emojiBtn);
inputWrapper.appendChild(input);
inputWrapper.appendChild(sendBtn);
inputArea.appendChild(inputWrapper);
async function sendMessage(){
const text=input.value.trim();
if(!text)return;
input.value='';
input.style.height='auto';
const userMsg=document.createElement('div');
userMsg.style.cssText='background:#252525;padding:14px 16px;border-radius:10px;margin-bottom:12px;border-left:3px solid #ff00ff;';
const userText=document.createElement('div');
userText.textContent=text;
userText.style.cssText='color:#fff;font-size:14px;line-height:1.6;';
userMsg.appendChild(userText);
messages.appendChild(userMsg);
messages.scrollTop=messages.scrollHeight;
const aiMsg=document.createElement('div');
aiMsg.style.cssText='background:#1e1e1e;padding:14px 16px;border-radius:10px;margin-bottom:12px;border-left:3px solid #ff00ff;';
const aiText=document.createElement('div');
aiText.textContent='💜 Pensando...';
aiText.style.cssText='color:#ccc;font-size:14px;line-height:1.6;';
aiMsg.appendChild(aiText);
messages.appendChild(aiMsg);
messages.scrollTop=messages.scrollHeight;
const response=await sendToAI(text);
aiText.textContent=response;
messages.scrollTop=messages.scrollHeight;
}
function showSettings(){
const overlay=document.createElement('div');
overlay.style.cssText='position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.7);z-index:999999;display:flex;align-items:center;justify-content:center;';
const modal=document.createElement('div');
modal.style.cssText='background:#2d2d2d;padding:24px;border-radius:12px;width:400px;border:1px solid #3d3d3d;';
const modalTitle=document.createElement('div');
modalTitle.textContent='⚙️ Configuración';
modalTitle.style.cssText='color:#ff00ff;font-size:18px;font-weight:600;margin-bottom:16px;';
const label=document.createElement('div');
label.textContent='API Key de HuggingFace:';
label.style.cssText='color:#ccc;font-size:13px;margin-bottom:8px;';
const keyInput=document.createElement('input');
keyInput.type='password';
keyInput.value=apiKey;
keyInput.placeholder='hf_...';
keyInput.style.cssText='width:100%;background:#1e1e1e;color:#fff;border:1px solid #3d3d3d;padding:10px;border-radius:6px;font-size:13px;margin-bottom:12px;';
const info=document.createElement('div');
info.style.cssText='color:#888;font-size:12px;margin-bottom:16px;line-height:1.5;';
const infoText=document.createElement('span');
infoText.textContent='Obtén tu API Key gratis en: ';
const infoLink=document.createElement('a');
infoLink.href='https://huggingface.co/settings/tokens';
infoLink.textContent='huggingface.co/settings/tokens';
infoLink.style.color='#ff00ff';
infoLink.target='_blank';
info.appendChild(infoText);
info.appendChild(infoLink);
const btnArea=document.createElement('div');
btnArea.style.cssText='display:flex;gap:8px;justify-content:flex-end;';
const cancelBtn=document.createElement('button');
cancelBtn.textContent='Cancelar';
cancelBtn.style.cssText='background:transparent;color:#ccc;border:1px solid #3d3d3d;padding:8px 16px;border-radius:6px;cursor:pointer;font-size:13px;';
cancelBtn.onclick=()=>document.body.removeChild(overlay);
const saveBtn=document.createElement('button');
saveBtn.textContent='Guardar';
saveBtn.style.cssText='background:#ff00ff;color:#fff;border:none;padding:8px 16px;border-radius:6px;cursor:pointer;font-size:13px;font-weight:600;';
saveBtn.onclick=()=>{
saveApiKey(keyInput.value.trim());
document.body.removeChild(overlay);
const msg=document.createElement('div');
msg.textContent='✓ API Key guardada';
msg.style.cssText='position:fixed;top:50px;right:20px;background:#ff00ff;color:#fff;padding:12px 20px;border-radius:8px;z-index:9999999;font-size:13px;';
document.body.appendChild(msg);
setTimeout(()=>document.body.removeChild(msg),2000);
};
btnArea.appendChild(cancelBtn);
btnArea.appendChild(saveBtn);
modal.appendChild(modalTitle);
modal.appendChild(label);
modal.appendChild(keyInput);
modal.appendChild(info);
modal.appendChild(btnArea);
overlay.appendChild(modal);
overlay.onclick=(e)=>{if(e.target===overlay)document.body.removeChild(overlay);};
document.body.appendChild(overlay);
keyInput.focus();
}
chatPanel.appendChild(header);
chatPanel.appendChild(subtitle);
chatPanel.appendChild(messages);
chatPanel.appendChild(inputArea);
document.body.appendChild(chatPanel);
}
function toggleChat(){
createChatPanel();
if(chatPanel.style.display==='none'||!chatPanel.style.display){
chatPanel.style.display='flex';
const input=chatPanel.querySelector('textarea');
if(input)input.focus();
}else{
chatPanel.style.display='none';
}
}
function addBtn(){
const selectors=['.part.titlebar','div[id="workbench.parts.titlebar"]','.titlebar-container'];
let bar=null;
for(let s of selectors){bar=document.querySelector(s);if(bar)break;}
if(!bar||document.getElementById('labdev-ai-btn')){setTimeout(addBtn,2000);return;}
const btn=document.createElement('div');
btn.id='labdev-ai-btn';
btn.title='LabDev AI Assistant';
btn.className='action-item';
btn.setAttribute('role','button');
btn.setAttribute('tabindex','0');
btn.style.cssText='position:absolute;right:140px;top:0;bottom:0;display:flex;align-items:center;justify-content:center;width:46px;height:100%;cursor:pointer;transition:background 0.2s;z-index:9999;';
const svg=document.createElementNS('http://www.w3.org/2000/svg','svg');
svg.setAttribute('width','16');
svg.setAttribute('height','16');
svg.setAttribute('viewBox','0 0 16 16');
svg.style.cssText='display:block;pointer-events:none;opacity:0.9;';
const g=document.createElementNS('http://www.w3.org/2000/svg','g');
const circle=document.createElementNS('http://www.w3.org/2000/svg','circle');
circle.setAttribute('cx','8');
circle.setAttribute('cy','8');
circle.setAttribute('r','6');
circle.setAttribute('fill','none');
circle.setAttribute('stroke','#ff00ff');
circle.setAttribute('stroke-width','1.5');
g.appendChild(circle);
const star=document.createElementNS('http://www.w3.org/2000/svg','path');
star.setAttribute('d','M8 4 L8.5 6.5 L11 7 L8.5 7.5 L8 10 L7.5 7.5 L5 7 L7.5 6.5 Z');
star.setAttribute('fill','#ff00ff');
g.appendChild(star);
svg.appendChild(g);
btn.appendChild(svg);
btn.onmouseover=()=>{btn.style.background='rgba(255,255,255,0.1)';svg.style.opacity='1';};
btn.onmouseout=()=>{btn.style.background='transparent';svg.style.opacity='0.9';};
btn.onclick=(e)=>{e.preventDefault();e.stopPropagation();toggleChat();};
bar.style.position='relative';
bar.appendChild(btn);
console.log('LabDev AI Complete ready');
}
if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',addBtn);}else{addBtn();}
setTimeout(addBtn,500);
setTimeout(addBtn,1500);
setTimeout(addBtn,3000);
})();
'@

Write-Host "Inyectando codigo..." -ForegroundColor Yellow
$content = $content + "`n" + $injectionCode

Write-Host "Guardando..." -ForegroundColor Yellow
$content | Out-File -FilePath $workbenchPath -Encoding UTF8 -NoNewline

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "  CHAT AI COMPLETO INSTALADO" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""
Write-Host "Reinicia LabDev Editor" -ForegroundColor Cyan
Write-Host ""
Write-Host "Funcionalidades:" -ForegroundColor White
Write-Host "  - Interfaz estilo Kiro" -ForegroundColor Gray
Write-Host "  - Chat 100% funcional con HuggingFace" -ForegroundColor Gray
Write-Host "  - Configuracion de API Key integrada" -ForegroundColor Gray
Write-Host "  - Respuestas reales de IA" -ForegroundColor Gray
