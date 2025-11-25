# Script v4 - Ajusta tamano y funcionalidad
Write-Host "=== Instalando boton AI (v4 - Ajustado) ===" -ForegroundColor Magenta

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

# Codigo optimizado con tamano correcto
$injectionCode = @'
(function(){
if(window.labdevAIv4)return;
window.labdevAIv4=true;
function addBtn(){
const selectors=['.part.titlebar','div[id="workbench.parts.titlebar"]','.titlebar-container'];
let bar=null;
for(let s of selectors){bar=document.querySelector(s);if(bar)break;}
if(!bar||document.getElementById('labdev-ai-btn')){setTimeout(addBtn,2000);return;}
const btn=document.createElement('div');
btn.id='labdev-ai-btn';
btn.title='LabDev AI Assistant (Ctrl+Shift+L)';
btn.className='action-item';
btn.style.cssText='position:absolute;right:140px;top:0;bottom:0;display:flex;align-items:center;justify-content:center;width:46px;height:100%;cursor:pointer;transition:background 0.2s;z-index:9999;';
const svg=document.createElementNS('http://www.w3.org/2000/svg','svg');
svg.setAttribute('width','16');
svg.setAttribute('height','16');
svg.setAttribute('viewBox','0 0 16 16');
svg.style.display='block';
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
btn.onclick=()=>{
try{
if(window.vscode&&window.vscode.commands){
window.vscode.commands.executeCommand('labdev-ai.openChat');
console.log('Executing command via vscode.commands');
}else{
const evt=new KeyboardEvent('keydown',{key:'l',code:'KeyL',keyCode:76,ctrlKey:true,shiftKey:true,bubbles:true,cancelable:true});
document.dispatchEvent(evt);
window.dispatchEvent(evt);
console.log('Simulating Ctrl+Shift+L');
}
}catch(e){
console.error('Error opening AI:',e);
}
};
bar.style.position='relative';
bar.appendChild(btn);
console.log('LabDev AI button added successfully');
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
Write-Host "Boton ajustado correctamente!" -ForegroundColor Green
Write-Host "Reinicia LabDev para ver los cambios" -ForegroundColor Cyan
