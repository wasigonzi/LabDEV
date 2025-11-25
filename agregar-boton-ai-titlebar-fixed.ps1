# Script FIXED - Sin innerHTML, solo createElement
Write-Host "=== Instalando boton AI (FIXED - Sin innerHTML) ===" -ForegroundColor Magenta

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
if(window.labdevAIFixed)return;
window.labdevAIFixed=true;
let chatPanel=null;
function createChatPanel(){
if(chatPanel&&document.body.contains(chatPanel))return;
chatPanel=document.createElement('div');
chatPanel.id='labdev-ai-panel';
chatPanel.style.cssText='position:fixed;top:35px;right:0;width:400px;height:calc(100vh - 35px);background:#1e1e1e;border-left:2px solid #ff00ff;z-index:99999;display:none;flex-direction:column;box-shadow:-5px 0 20px rgba(0,0,0,0.5);';
const header=document.createElement('div');
header.style.cssText='padding:15px;background:#2d2d2d;border-bottom:2px solid #ff00ff;display:flex;justify-content:space-between;align-items:center;';
const title=document.createElement('div');
title.textContent='💜 LabDev AI Assistant';
title.style.cssText='color:#ff00ff;font-weight:bold;font-size:14px;';
const closeBtn=document.createElement('button');
closeBtn.textContent='✕';
closeBtn.style.cssText='background:transparent;border:none;color:#fff;font-size:18px;cursor:pointer;padding:0 8px;';
closeBtn.onclick=()=>{chatPanel.style.display='none';};
header.appendChild(title);
header.appendChild(closeBtn);
const messages=document.createElement('div');
messages.id='ai-messages';
messages.style.cssText='flex:1;overflow-y:auto;padding:15px;';
const welcomeMsg=document.createElement('div');
welcomeMsg.style.cssText='background:#2d2d2d;padding:12px;border-radius:8px;border-left:3px solid #ff00ff;margin-bottom:12px;';
const welcomeRole=document.createElement('div');
welcomeRole.textContent='LabDev AI';
welcomeRole.style.cssText='color:#ff00ff;font-weight:bold;font-size:11px;margin-bottom:6px;';
const welcomeText=document.createElement('div');
welcomeText.style.cssText='color:#fff;font-size:13px;line-height:1.5;';
const p1=document.createElement('p');
p1.textContent='¡Hola! Soy tu asistente de IA. Puedo ayudarte con código, explicaciones y preguntas.';
p1.style.marginBottom='10px';
const p2=document.createElement('p');
p2.textContent='Para usar el chat, configura tu API Key de HuggingFace en:';
p2.style.marginBottom='5px';
const p3=document.createElement('strong');
p3.textContent='File → Preferences → Settings → LabDev AI';
p3.style.display='block';
p3.style.marginBottom='10px';
const p4=document.createElement('p');
p4.textContent='Obtén una gratis en: ';
const link=document.createElement('a');
link.href='https://huggingface.co/settings/tokens';
link.textContent='huggingface.co/settings/tokens';
link.style.color='#ff00ff';
link.target='_blank';
p4.appendChild(link);
welcomeText.appendChild(p1);
welcomeText.appendChild(p2);
welcomeText.appendChild(p3);
welcomeText.appendChild(p4);
welcomeMsg.appendChild(welcomeRole);
welcomeMsg.appendChild(welcomeText);
messages.appendChild(welcomeMsg);
const inputArea=document.createElement('div');
inputArea.style.cssText='padding:12px;background:#2d2d2d;border-top:1px solid #3d3d3d;display:flex;gap:8px;';
const input=document.createElement('input');
input.type='text';
input.placeholder='Pregunta algo...';
input.style.cssText='flex:1;background:#1e1e1e;color:#fff;border:1px solid #ff00ff;padding:10px;border-radius:6px;font-size:13px;outline:none;';
const sendBtn=document.createElement('button');
sendBtn.textContent='Enviar';
sendBtn.style.cssText='background:#ff00ff;color:#fff;border:none;padding:10px 20px;border-radius:6px;cursor:pointer;font-weight:bold;font-size:12px;';
sendBtn.onclick=()=>sendMessage();
input.onkeypress=(e)=>{if(e.key==='Enter')sendMessage();};
function sendMessage(){
const text=input.value.trim();
if(!text)return;
const userMsg=document.createElement('div');
userMsg.style.cssText='background:#2d2d2d;padding:12px;border-radius:8px;border-left:3px solid #ff00ff;margin-bottom:12px;';
const userRole=document.createElement('div');
userRole.textContent='Tú';
userRole.style.cssText='color:#ff00ff;font-weight:bold;font-size:11px;margin-bottom:6px;';
const userText=document.createElement('div');
userText.textContent=text;
userText.style.cssText='color:#fff;font-size:13px;line-height:1.5;';
userMsg.appendChild(userRole);
userMsg.appendChild(userText);
messages.appendChild(userMsg);
input.value='';
const aiMsg=document.createElement('div');
aiMsg.style.cssText='background:#1a1a1a;padding:12px;border-radius:8px;border-left:3px solid #ff00ff;margin-bottom:12px;';
const aiRole=document.createElement('div');
aiRole.textContent='LabDev AI';
aiRole.style.cssText='color:#ff00ff;font-weight:bold;font-size:11px;margin-bottom:6px;';
const aiText=document.createElement('div');
aiText.style.cssText='color:#fff;font-size:13px;line-height:1.5;';
const aiP1=document.createElement('p');
aiP1.textContent='💜 Procesando tu pregunta...';
const aiP2=document.createElement('p');
aiP2.style.cssText='color:#888;font-style:italic;margin-top:10px;';
aiP2.textContent='Nota: Para que el chat funcione, necesitas instalar y configurar la extensión LabDev AI Assistant con tu API Key de HuggingFace.';
aiText.appendChild(aiP1);
aiText.appendChild(aiP2);
aiMsg.appendChild(aiRole);
aiMsg.appendChild(aiText);
messages.appendChild(aiMsg);
messages.scrollTop=messages.scrollHeight;
}
inputArea.appendChild(input);
inputArea.appendChild(sendBtn);
chatPanel.appendChild(header);
chatPanel.appendChild(messages);
chatPanel.appendChild(inputArea);
document.body.appendChild(chatPanel);
}
function toggleChat(){
createChatPanel();
if(chatPanel.style.display==='none'||!chatPanel.style.display){
chatPanel.style.display='flex';
const input=chatPanel.querySelector('input');
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
console.log('LabDev AI button ready');
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
Write-Host "INSTALADO CORRECTAMENTE!" -ForegroundColor Green
Write-Host "Reinicia LabDev para ver el boton funcionando" -ForegroundColor Cyan
