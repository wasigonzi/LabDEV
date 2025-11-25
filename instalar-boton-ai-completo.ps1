# Script completo para instalar el boton AI en la barra de titulo
Write-Host ""
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  INSTALACION BOTON AI EN BARRA TITULO" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

# Paso 1: Inyectar codigo en workbench
Write-Host "[1/2] Inyectando boton en workbench..." -ForegroundColor Cyan
& ".\agregar-boton-ai-titlebar.ps1"

Write-Host ""
Write-Host "[2/2] Instalando extension AI Assistant..." -ForegroundColor Cyan
Set-Location "labdev-ai-assistant"

# Empaquetar extension
Write-Host "  - Empaquetando extension..." -ForegroundColor Yellow
npx @vscode/vsce package --allow-missing-repository 2>&1 | Out-Null

# Instalar extension
Write-Host "  - Instalando en LabDev..." -ForegroundColor Yellow
& "..\..\..\LabDev-Editor\LabDev.exe" --install-extension "labdev-ai-assistant-1.0.0.vsix" 2>&1 | Out-Null

Set-Location ".."

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  INSTALACION COMPLETADA" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "SIGUIENTE PASO:" -ForegroundColor Cyan
Write-Host "1. Cierra LabDev Editor completamente" -ForegroundColor White
Write-Host "2. Vuelve a abrir LabDev Editor" -ForegroundColor White
Write-Host "3. Veras el icono fucsia en la barra de titulo superior" -ForegroundColor White
Write-Host ""
Write-Host "El boton estara al lado de 'Customize Layout'" -ForegroundColor Yellow
Write-Host "Tambien puedes usar Ctrl+Shift+L para abrir el chat" -ForegroundColor Yellow
Write-Host ""
