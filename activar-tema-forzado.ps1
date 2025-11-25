# Script para forzar la activación del tema LabDev

$settingsPath = "$env:USERPROFILE\.labdev\User\settings.json"

Write-Host "=== Forzando activación del tema LabDev ===" -ForegroundColor Magenta
Write-Host ""

# Crear directorio si no existe
$settingsDir = Split-Path $settingsPath
if (-not (Test-Path $settingsDir)) {
    New-Item -ItemType Directory -Path $settingsDir -Force | Out-Null
    Write-Host "Directorio de configuración creado" -ForegroundColor Green
}

# Crear configuración
$settings = @{
    "workbench.colorTheme" = "LabDev Dark"
    "workbench.iconTheme" = "vs-seti"
    "editor.fontFamily" = "Consolas, 'Courier New', monospace"
    "editor.fontSize" = 14
    "editor.lineHeight" = 22
    "editor.cursorBlinking" = "smooth"
    "editor.cursorSmoothCaretAnimation" = "on"
    "editor.bracketPairColorization.enabled" = $true
    "editor.guides.bracketPairs" = "active"
    "window.titleBarStyle" = "custom"
}

$settings | ConvertTo-Json | Set-Content $settingsPath -Encoding UTF8

Write-Host "OK Configuración guardada en:" -ForegroundColor Green
Write-Host "   $settingsPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "Ahora:" -ForegroundColor Yellow
Write-Host "1. Cierra LabDev completamente" -ForegroundColor White
Write-Host "2. Abre LabDev de nuevo" -ForegroundColor White
Write-Host "3. El tema LabDev Dark se activará automáticamente" -ForegroundColor White
Write-Host ""
