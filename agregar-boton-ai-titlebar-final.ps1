# Script final - Boton AI estilo Kiro con chat integrado
Write-Host "=== Instalando boton AI estilo Kiro ===" -ForegroundColor Magenta

$workbenchPath = "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js"
$backupPath = "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js.backup"

# Restaurar desde backup
if (Test-Path $backupPath) {
    Write-Host "Restaurando desde backup..." -ForegroundColor Yellow
    Copy-Item $backupPath $workbenchPath -Force
}

# Leer contenido
Write-Host "Leyendo workbench..." -ForegroundColor Yellow
$content = Get-Content $workbenchPath -Raw -Encoding UTF8

# Codigo completo con chat integrado
$injectionCode = @'
(function(){
if(window.labdevAIFinal)return;
window.labdevAIFinal=true;
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
welcomeMsg.innerHTML='<div style="color:#ff00ff;font-weight:bold;font-size:11px;margin-bottom:6px;">LabDev AI</div><div style="color:#fff;font-size:13px;line-height:1.5;">¡Hola! Soy tu asistente de IA. Puedo ayudarte con código, explicaciones y preguntas.<br><br>Para usar el chat, configura tu API Key de HuggingFace en:<br><strong>File → Preferences → Settings → LabDev AI</strong><br><br>Obtén una gratis en: <a href="https://huggingface.co/settings/tokens" style="color:#ff00ff;">huggingface.co/settings/tokens</a></div>';
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
userMsg.innerHTML='<div style="color:#ff00ff;font-weight:bold;font-size:11px;margin-bottom:6px;">Tú</div><div style="color:#fff;font-size:13px;line-height:1.5;">'+text+'</div>';
messages.appendChild(userMsg);
input.value='';
const aiMsg=document.createElement('div');
aiMsg.style.cssText='background:#1a1a1a;padding:12px;border-radius:8px;border-left:3px solid #ff00ff;margin-bottom:12px;';
aiMsg.innerHTML='<div style="color:#ff00ff;font-weight:bold;font-size:11px;margin-bottom:6px;">LabDev AI</div><div style="color:#fff;font-size:13px;line-height:1.5;">💜 Procesando tu pregunta...<br><br><em style="color:#888;">Nota: Para que el chat funcione, necesitas instalar y configurar la extensión LabDev AI Assistant con tu API Key de HuggingFace.</em></div>';
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
console.log('LabDev AI button added - Click to open chat');
}
if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',addBtn);}else{addBtn();}
setTimeout(addBtn,500);
setTimeout(addBtn,1500);
setTimeout(addBtn,3000);
})();
'@

# Inyectar
Write-Host "Inyectando codigo..." -ForegroundColor Yellow
$content = $content + "`n" + $injectionCode

# Guardar
Write-Host "Guardando..." -ForegroundColor Yellow
$content | Out-File -FilePath $workbenchPath -Encoding UTF8 -NoNewline

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "  INSTALACION COMPLETADA" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""
Write-Host "Reinicia LabDev Editor" -ForegroundColor Cyan
Write-Host ""
Write-Host "El boton abrira un panel de chat lateral" -ForegroundColor White
Write-Host "similar al asistente de Kiro" -ForegroundColor White
