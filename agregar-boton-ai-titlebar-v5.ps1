# Script v5 - Ejecuta comando directamente
Write-Host "=== Instalando boton AI (v5 - Comando directo) ===" -ForegroundColor Magenta

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

# Codigo con ejecucion directa del comando
$injectionCode = @'
(function(){
if(window.labdevAIv5)return;
window.labdevAIv5=true;
let commandService=null;
function findCommandService(){
if(commandService)return commandService;
try{
const keys=Object.keys(window);
for(let key of keys){
if(window[key]&&typeof window[key]==='object'){
const obj=window[key];
if(obj._commandService||obj.commandService){
commandService=obj._commandService||obj.commandService;
console.log('Found command service via',key);
return commandService;
}
}
}
}catch(e){}
return null;
}
function addBtn(){
const selectors=['.part.titlebar','div[id="workbench.parts.titlebar"]','.titlebar-container'];
let bar=null;
for(let s of selectors){bar=document.querySelector(s);if(bar)break;}
if(!bar||document.getElementById('labdev-ai-btn')){setTimeout(addBtn,2000);return;}
const btn=document.createElement('div');
btn.id='labdev-ai-btn';
btn.title='LabDev AI Assistant (Ctrl+Shift+L)';
btn.className='action-item';
btn.setAttribute('role','button');
btn.setAttribute('tabindex','0');
btn.style.cssText='position:absolute;right:140px;top:0;bottom:0;display:flex;align-items:center;justify-content:center;width:46px;height:100%;cursor:pointer;transition:background 0.2s;z-index:9999;';
const svg=document.createElementNS('http://www.w3.org/2000/svg','svg');
svg.setAttribute('width','16');
svg.setAttribute('height','16');
svg.setAttribute('viewBox','0 0 16 16');
svg.style.display='block';
svg.style.pointerEvents='none';
const path=document.createElementNS('http://www.w3.org/2000/svg','path');
path.setAttribute('d','M8 2 L9 6 L13 7 L9 8 L8 12 L7 8 L3 7 L7 6 Z');
path.setAttribute('fill','#ff00ff');
path.setAttribute('stroke','#ff00ff');
path.setAttribute('stroke-width','0.5');
svg.appendChild(path);
const circles=[[4,4],[12,4],[4,12],[12,12]];
circles.forEach(([cx,cy])=>{
const c=document.createElementNS('http://www.w3.org/2000/svg','circle');
c.setAttribute('cx',cx);
c.setAttribute('cy',cy);
c.setAttribute('r','0.8');
c.setAttribute('fill','#ff00ff');
svg.appendChild(c);
});
btn.appendChild(svg);
btn.onmouseover=()=>{btn.style.background='rgba(255,255,255,0.1)';};
btn.onmouseout=()=>{btn.style.background='transparent';};
btn.onclick=(e)=>{
e.preventDefault();
e.stopPropagation();
console.log('AI button clicked');
const cs=findCommandService();
if(cs&&cs.executeCommand){
cs.executeCommand('labdev-ai.openChat').then(()=>{
console.log('Command executed successfully');
}).catch(err=>{
console.log('Command failed, trying palette');
if(cs.executeCommand){
cs.executeCommand('workbench.action.showCommands').then(()=>{
setTimeout(()=>{
const input=document.querySelector('.quick-input-widget input');
if(input){
input.value='LabDev: Chat con IA';
input.dispatchEvent(new Event('input',{bubbles:true}));
}
},100);
});
}
});
}else{
console.log('Opening command palette');
const paletteKeys=['F1','workbench.action.showCommands'];
for(let k of paletteKeys){
try{
const evt=new KeyboardEvent('keydown',{key:k,bubbles:true,cancelable:true});
document.dispatchEvent(evt);
}catch(e){}
}
}
};
bar.style.position='relative';
bar.appendChild(btn);
console.log('LabDev AI button added');
setTimeout(findCommandService,2000);
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
Write-Host "Instalado! Reinicia LabDev" -ForegroundColor Green
Write-Host ""
Write-Host "El boton ahora ejecutara el comando directamente" -ForegroundColor Cyan
Write-Host "o abrira la paleta de comandos si es necesario" -ForegroundColor Cyan
