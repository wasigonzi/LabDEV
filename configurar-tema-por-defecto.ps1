# Script para configurar el tema LabDev como predeterminado

$editorPath = "C:\Users\sylex\LabDEV\LabDev-Editor"
$productJsonPath = "$editorPath\resources\app\product.json"

Write-Host "=== Configurando tema LabDev como predeterminado ===" -ForegroundColor Magenta
Write-Host ""

# Leer product.json
$productJson = Get-Content $productJsonPath -Raw | ConvertFrom-Json

# Agregar configuración por defecto
if (-not $productJson.PSObject.Properties['defaultSettings']) {
    $productJson | Add-Member -MemberType NoteProperty -Name 'defaultSettings' -Value @{}
}

$productJson.defaultSettings = @{
    "workbench.colorTheme" = "LabDev Dark"
    "workbench.iconTheme" = "vs-seti"
    "editor.fontFamily" = "Consolas, 'Courier New', monospace"
    "editor.fontSize" = 14
    "editor.lineHeight" = 22
    "editor.cursorBlinking" = "smooth"
    "editor.cursorSmoothCaretAnimation" = "on"
    "editor.bracketPairColorization.enabled" = $true
    "editor.guides.bracketPairs" = "active"
    "workbench.startupEditor" = "welcomePage"
    "window.titleBarStyle" = "custom"
    "window.menuBarVisibility" = "toggle"
}

# Guardar cambios
$productJson | ConvertTo-Json -Depth 100 | Set-Content $productJsonPath -Encoding UTF8

Write-Host "OK Tema configurado como predeterminado" -ForegroundColor Green
Write-Host ""
Write-Host "=== Configuración completada ===" -ForegroundColor Magenta
Write-Host ""
Write-Host "El tema LabDev Dark se activará automáticamente" -ForegroundColor Cyan
Write-Host "la primera vez que abras LabDev." -ForegroundColor Cyan
Write-Host ""
Write-Host "Características del tema:" -ForegroundColor Yellow
Write-Host "  - Color principal: Fucsia (#ff00ff)" -ForegroundColor Magenta
Write-Host "  - Fondo oscuro estilo Kiro" -ForegroundColor DarkGray
Write-Host "  - Cursores y acentos en fucsia" -ForegroundColor Magenta
Write-Host "  - Resaltado de sintaxis optimizado" -ForegroundColor White
