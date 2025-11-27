# Script definitivo para agregar botón AI en la barra de título
$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  Agregar Botón AI en Barra de Título" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

$workbenchJs = "LabDev-Editor/resources/app/out/vs/workbench/workbench.desktop.main.js"
$backup = "$workbenchJs.backup"

# Crear backup si no existe
if (-not (Test-Path $backup)) {
    Copy-Item $workbenchJs $backup
    Write-Host "[✓] Backup creado" -ForegroundColor Green
} else {
    Write-Host "[✓] Backup ya existe" -ForegroundColor Yellow
}

# Restaurar desde backup para empezar limpio
Copy-Item $backup $workbenchJs -Force
Write-Host "[✓] Workbench restaurado desde backup" -ForegroundColor Green

# Leer contenido
$content = Get-Content $workbenchJs -Raw

# Código JavaScript optimizado
$aiButtonCode = @'
;(function(){function add(){if(document.getElementById('labdev-ai-btn'))return;const t=document.querySelector('.titlebar-right .action-toolbar-container')||document.querySelector('.titlebar-right');const w=document.querySelector('.window-controls-container');if(!t&&!w)return;const b=document.createElement('div');b.id='labdev-ai-btn';b.className='action-item';b.style.cssText='display:flex;align-items:center;justify-content:center;width:46px;height:100%;cursor:pointer;color:#ff00ff;font-size:18px;transition:background 0.2s;';b.innerHTML='✨';b.title='LabDev AI (Ctrl+Shift+L)';b.onmouseenter=()=>b.style.backgroundColor='rgba(255,255,255,0.1)';b.onmouseleave=()=>b.style.backgroundColor='transparent';b.onclick=()=>{const e=new KeyboardEvent('keydown',{key:'l',code:'KeyL',ctrlKey:true,shiftKey:true,bubbles:true});document.dispatchEvent(e);};if(t){t.appendChild(b);}else if(w&&w.parentElement){w.parentElement.insertBefore(b,w);}console.log('LabDev AI button added');}if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',add);}else{setTimeout(add,1000);}setInterval(add,3000);})();
'@

# Agregar el código al final
$content = $content + $aiButtonCode

# Guardar
Set-Content -Path $workbenchJs -Value $content -NoNewline

Write-Host "[✓] Botón AI agregado exitosamente" -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  Reinicia LabDev Editor" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "El botón ✨ aparecerá en la barra de título" -ForegroundColor Cyan
Write-Host "Al hacer clic, se abrirá el chat de LabDev AI" -ForegroundColor Cyan
