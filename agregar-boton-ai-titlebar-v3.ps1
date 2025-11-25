# Script v3 - Corrige el problema de TrustedHTML
Write-Host "=== Agregando boton AI Assistant (Version 3 - Fixed) ===" -ForegroundColor Magenta

$workbenchPath = "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js"
$backupPath = "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js.backup"

# Restaurar desde backup
if (Test-Path $backupPath) {
    Write-Host "Restaurando desde backup..." -ForegroundColor Yellow
    Copy-Item $backupPath $workbenchPath -Force
} else {
    Write-Host "Creando backup..." -ForegroundColor Yellow
    Copy-Item $workbenchPath $backupPath
}

# Leer contenido
Write-Host "Leyendo workbench..." -ForegroundColor Yellow
$content = Get-Content $workbenchPath -Raw -Encoding UTF8

# Codigo corregido sin innerHTML
$injectionCode = @'
(function(){
if(window.labdevAIv3)return;
window.labdevAIv3=true;
function addBtn(){
const selectors=['.part.titlebar','div[id="workbench.parts.titlebar"]','.titlebar-container'];
let bar=null;
for(let s of selectors){bar=document.querySelector(s);if(bar)break;}
if(!bar||document.getElementById('labdev-ai-btn')){setTimeout(addBtn,2000);return;}
const btn=document.createElement('div');
btn.id='labdev-ai-btn';
btn.title='LabDev AI Assistant (Ctrl+Shift+L)';
btn.style.cssText='position:absolute;right:150px;top:50%;transform:translateY(-50%);display:inline-flex;align-items:center;justify-content:center;width:35px;height:35px;cursor:pointer;border-radius:5px;transition:all 0.2s;z-index:9999;';
const svg=document.createElementNS('http://www.w3.org/2000/svg','svg');
svg.setAttribute('width','20');
svg.setAttribute('height','20');
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
btn.onmouseover=()=>{btn.style.background='rgba(255,0,255,0.2)';btn.style.transform='translateY(-50%) scale(1.1)';};
btn.onmouseout=()=>{btn.style.background='transparent';btn.style.transform='translateY(-50%) scale(1)';};
btn.onclick=()=>{
const evt=new KeyboardEvent('keydown',{key:'l',code:'KeyL',ctrlKey:true,shiftKey:true,bubbles:true});
document.dispatchEvent(evt);
console.log('LabDev AI clicked - sending Ctrl+Shift+L');
};
bar.style.position='relative';
bar.appendChild(btn);
console.log('LabDev AI button added successfully to:',bar.className||bar.id);
}
if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',addBtn);}else{addBtn();}
setTimeout(addBtn,500);
setTimeout(addBtn,1500);
setTimeout(addBtn,3000);
setTimeout(addBtn,5000);
})();
'@

# Inyectar
Write-Host "Inyectando codigo corregido..." -ForegroundColor Yellow
$content = $content + "`n" + $injectionCode

# Guardar
Write-Host "Guardando..." -ForegroundColor Yellow
$content | Out-File -FilePath $workbenchPath -Encoding UTF8 -NoNewline

Write-Host ""
Write-Host "Instalado correctamente!" -ForegroundColor Green
Write-Host ""
Write-Host "IMPORTANTE:" -ForegroundColor Cyan
Write-Host "1. Cierra LabDev COMPLETAMENTE" -ForegroundColor White
Write-Host "2. Vuelve a abrir LabDev" -ForegroundColor White
Write-Host "3. El boton fucsia aparecera en la esquina superior derecha" -ForegroundColor White
Write-Host ""
Write-Host "Si no aparece, abre la consola (F12) y busca el mensaje:" -ForegroundColor Yellow
Write-Host "  'LabDev AI button added successfully'" -ForegroundColor Gray
