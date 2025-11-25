# Script mejorado para agregar boton AI en la barra de titulo
Write-Host "=== Agregando boton AI Assistant (Version 2) ===" -ForegroundColor Magenta

$workbenchPath = "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js"
$backupPath = "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js.backup"

# Crear backup
if (-not (Test-Path $backupPath)) {
    Write-Host "Creando backup..." -ForegroundColor Yellow
    Copy-Item $workbenchPath $backupPath
}

# Leer contenido
Write-Host "Leyendo workbench..." -ForegroundColor Yellow
$content = Get-Content $workbenchPath -Raw -Encoding UTF8

# Codigo mejorado que busca multiples selectores
$injectionCode = @'
(function(){
if(window.labdevAIv2)return;
window.labdevAIv2=true;
function addBtn(){
const selectors=[
'.part.titlebar',
'.titlebar-container',
'div[id="workbench.parts.titlebar"]',
'.window-title',
'.menubar',
'header'
];
let bar=null;
for(let s of selectors){
bar=document.querySelector(s);
if(bar)break;
}
if(!bar||document.getElementById('labdev-ai-btn')){
setTimeout(addBtn,2000);
return;
}
const btn=document.createElement('div');
btn.id='labdev-ai-btn';
btn.innerHTML='<svg width="20" height="20" viewBox="0 0 16 16" style="display:block"><path d="M8 2 L9 6 L13 7 L9 8 L8 12 L7 8 L3 7 L7 6 Z" fill="#ff00ff" stroke="#ff00ff" stroke-width="0.5"/><circle cx="4" cy="4" r="0.8" fill="#ff00ff"/><circle cx="12" cy="4" r="0.8" fill="#ff00ff"/><circle cx="4" cy="12" r="0.8" fill="#ff00ff"/><circle cx="12" cy="12" r="0.8" fill="#ff00ff"/></svg>';
btn.title='LabDev AI Assistant (Ctrl+Shift+L)';
btn.style.cssText='position:absolute;right:150px;top:50%;transform:translateY(-50%);display:inline-flex;align-items:center;justify-content:center;width:35px;height:35px;cursor:pointer;border-radius:5px;transition:all 0.2s;z-index:9999;';
btn.onmouseover=()=>{btn.style.background='rgba(255,0,255,0.2)';btn.style.transform='translateY(-50%) scale(1.1)';};
btn.onmouseout=()=>{btn.style.background='transparent';btn.style.transform='translateY(-50%) scale(1)';};
btn.onclick=()=>{
const evt=new KeyboardEvent('keydown',{key:'l',code:'KeyL',ctrlKey:true,shiftKey:true,bubbles:true});
document.dispatchEvent(evt);
console.log('LabDev AI clicked');
};
bar.style.position='relative';
bar.appendChild(btn);
console.log('LabDev AI button added to:',bar.className);
}
if(document.readyState==='loading'){
document.addEventListener('DOMContentLoaded',addBtn);
}else{
addBtn();
}
setTimeout(addBtn,500);
setTimeout(addBtn,1500);
setTimeout(addBtn,3000);
})();
'@

# Verificar si ya esta inyectado
if ($content -match "labdevAIv2") {
    Write-Host "Ya esta instalado. Reinstalando..." -ForegroundColor Yellow
    # Restaurar backup y volver a inyectar
    $content = Get-Content $backupPath -Raw -Encoding UTF8
}

# Inyectar
Write-Host "Inyectando codigo..." -ForegroundColor Yellow
$content = $content + "`n" + $injectionCode

# Guardar
Write-Host "Guardando..." -ForegroundColor Yellow
$content | Out-File -FilePath $workbenchPath -Encoding UTF8 -NoNewline

Write-Host ""
Write-Host "Instalado! Reinicia LabDev Editor" -ForegroundColor Green
Write-Host "El boton aparecera en la esquina superior derecha" -ForegroundColor Cyan
