# Script de instalacion de LabDev AI Complete
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "  INSTALANDO LABDEV AI COMPLETE" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""

Set-Location "labdev-ai-complete"

Write-Host "[1/4] Instalando dependencias..." -ForegroundColor Cyan
npm install

Write-Host ""
Write-Host "[2/4] Empaquetando extension..." -ForegroundColor Cyan
npx @vscode/vsce package --allow-missing-repository

Write-Host ""
Write-Host "[3/4] Instalando en LabDev..." -ForegroundColor Cyan
& "..\..\LabDev-Editor\LabDev.exe" --install-extension "labdev-ai-complete-1.0.0.vsix"

Set-Location ".."

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  INSTALACION COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "SIGUIENTE PASO:" -ForegroundColor Cyan
Write-Host "  1. Reinicia LabDev Editor" -ForegroundColor White
Write-Host "  2. Busca el icono fucsia en la barra lateral" -ForegroundColor White
Write-Host "  3. Haz clic en el icono para abrir el chat" -ForegroundColor White
Write-Host "  4. Configura tu API Key (boton de engranaje)" -ForegroundColor White
Write-Host ""
Write-Host "FUNCIONES DISPONIBLES:" -ForegroundColor Yellow
Write-Host "  - Chat con IA en tiempo real" -ForegroundColor Gray
Write-Host "  - Leer y escribir archivos" -ForegroundColor Gray
Write-Host "  - Ejecutar comandos" -ForegroundColor Gray
Write-Host "  - Explicar codigo seleccionado" -ForegroundColor Gray
Write-Host ""
