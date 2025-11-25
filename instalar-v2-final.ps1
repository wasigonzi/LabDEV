# Script de instalacion final LabDev AI v2.0
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "  INSTALANDO LABDEV AI v2.0" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""

Write-Host "[1/6] Cerrando LabDev..." -ForegroundColor Cyan
Get-Process -Name "LabDev" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2

Write-Host ""
Write-Host "[2/6] Empaquetando extension..." -ForegroundColor Cyan
Set-Location "labdev-ai-complete"
npx @vscode/vsce package --allow-missing-repository --out labdev-ai-complete-2.0.0.vsix

Write-Host ""
Write-Host "[3/6] Desinstalando version anterior..." -ForegroundColor Cyan
& "..\..\LabDev-Editor\LabDev.exe" --uninstall-extension "labdev.labdev-ai-complete"
Start-Sleep -Seconds 2

Write-Host ""
Write-Host "[4/6] Instalando version 2.0..." -ForegroundColor Cyan
& "..\..\LabDev-Editor\LabDev.exe" --install-extension "labdev-ai-complete-2.0.0.vsix"
Start-Sleep -Seconds 2

Set-Location ".."

Write-Host ""
Write-Host "[5/6] Iniciando LabDev..." -ForegroundColor Cyan
Start-Process "..\LabDev-Editor\LabDev.exe"
Start-Sleep -Seconds 3

Write-Host ""
Write-Host "[6/6] Verificando instalacion..." -ForegroundColor Cyan
if (Test-Path "labdev-ai-complete\labdev-ai-complete-2.0.0.vsix") {
    $size = (Get-Item "labdev-ai-complete\labdev-ai-complete-2.0.0.vsix").Length
    $sizeKB = [math]::Round($size/1024, 2)
    Write-Host "  OK Extension empaquetada ($sizeKB KB)" -ForegroundColor Green
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  INSTALACION COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "NUEVAS CARACTERISTICAS v2.0:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. MODOS DE APROBACION:" -ForegroundColor Yellow
Write-Host "   - Chat: Solo conversacion" -ForegroundColor White
Write-Host "   - Agent: Lee/edita con aprobacion (por defecto)" -ForegroundColor White
Write-Host "   - Full Access: Acceso completo automatico" -ForegroundColor White
Write-Host ""
Write-Host "2. REFERENCIAS DE ARCHIVOS:" -ForegroundColor Yellow
Write-Host "   - Usa @archivo.js para referenciar archivos" -ForegroundColor White
Write-Host "   - Ejemplo: 'Lee @package.json y explicamelo'" -ForegroundColor White
Write-Host ""
Write-Host "3. PREVIEW DE EDICIONES:" -ForegroundColor Yellow
Write-Host "   - Ve los cambios antes de aplicarlos" -ForegroundColor White
Write-Host "   - Botones Aplicar/Rechazar" -ForegroundColor White
Write-Host "   - Control total sobre modificaciones" -ForegroundColor White
Write-Host ""
Write-Host "COMO USAR:" -ForegroundColor Cyan
Write-Host "  1. LabDev ya esta abierto" -ForegroundColor White
Write-Host "  2. Busca el icono FUCSIA en la barra lateral" -ForegroundColor Magenta
Write-Host "  3. Haz clic para abrir el chat" -ForegroundColor White
Write-Host "  4. Veras 3 botones de modo en la parte superior" -ForegroundColor White
Write-Host "  5. Prueba: 'Lee @package.json y explicamelo'" -ForegroundColor White
Write-Host ""
Write-Host "DOCUMENTACION:" -ForegroundColor Yellow
Write-Host "  - README-V2.md - Guia principal" -ForegroundColor Gray
Write-Host "  - NUEVAS-CARACTERISTICAS-V2.md - Guia completa" -ForegroundColor Gray
Write-Host "  - GUIA-VISUAL-V2.md - Guia visual" -ForegroundColor Gray
Write-Host ""
