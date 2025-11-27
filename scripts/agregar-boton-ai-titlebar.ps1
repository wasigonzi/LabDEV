# Script para agregar botón AI en la barra de título
$ErrorActionPreference = "Stop"

$workbenchJs = "LabDev-Editor/resources/app/out/vs/workbench/workbench.desktop.main.js"

# Crear backup
$backup = "$workbenchJs.backup_ai_button"
if (-not (Test-Path $backup)) {
    Copy-Item $workbenchJs $backup
    Write-Host "Backup creado: $backup"
}

# Leer el contenido
$content = Get-Content $workbenchJs -Raw

# Código para agregar el botón AI
$aiButtonCode = @"
(function(){const t=setInterval(()=>{const e=document.querySelector('.window-controls-container');if(e){clearInterval(t);const n=document.createElement('div');n.className='window-icon';n.innerHTML='<span style="color:#ff00ff;font-size:20px;cursor:pointer;" title="LabDev AI (Ctrl+Shift+L)">✨</span>';n.onclick=()=>{const c=new KeyboardEvent('keydown',{key:'l',code:'KeyL',ctrlKey:true,shiftKey:true,bubbles:true});document.dispatchEvent(c);};e.insertBefore(n,e.firstChild);}},100);})();
"@

# Buscar un punto de inyección al final del archivo
if ($content -notmatch [regex]::Escape($aiButtonCode)) {
    $content = $content + $aiButtonCode
    Set-Content -Path $workbenchJs -Value $content -NoNewline
    Write-Host "Botón AI agregado exitosamente"
} else {
    Write-Host "El botón AI ya está agregado"
}

Write-Host "`nReinicia LabDev Editor para ver el botón ✨ en la barra de título"
