# Script de actualizacion a LabDev AI Complete v2.0
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "  ACTUALIZANDO A LABDEV AI v2.0" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "NUEVAS CARACTERISTICAS:" -ForegroundColor Cyan
Write-Host "  - Modos de aprobacion (Chat/Agent/Full Access)" -ForegroundColor White
Write-Host "  - Referencias de archivos con @" -ForegroundColor White
Write-Host "  - Preview de ediciones de codigo" -ForegroundColor White
Write-Host ""

Set-Location "labdev-ai-complete"

Write-Host "[1/5] Verificando dependencias..." -ForegroundColor Cyan
npm install

Write-Host ""
Write-Host "[2/5] Eliminando version anterior..." -ForegroundColor Cyan
if (Test-Path "labdev-ai-complete-1.0.0.vsix") {
    Remove-Item "labdev-ai-complete-1.0.0.vsix" -Force
    Write-Host "  OK Version 1.0.0 eliminada" -ForegroundColor Green
}

Write-Host ""
Write-Host "[3/5] Empaquetando version 2.0..." -ForegroundColor Cyan
npx @vscode/vsce package --allow-missing-repository

Write-Host ""
Write-Host "[4/5] Desinstalando version anterior..." -ForegroundColor Cyan
& "..\..\LabDev-Editor\LabDev.exe" --uninstall-extension "labdev.labdev-ai-complete"
Start-Sleep -Seconds 2

Write-Host ""
Write-Host "[5/5] Instalando version 2.0..." -ForegroundColor Cyan
& "..\..\LabDev-Editor\LabDev.exe" --install-extension "labdev-ai-complete-2.0.0.vsix"

Set-Location ".."

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  ACTUALIZACION COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "NUEVAS FUNCIONALIDADES:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. MODOS DE APROBACION:" -ForegroundColor Yellow
Write-Host "   - Chat: Solo conversacion" -ForegroundColor Gray
Write-Host "   - Agent: Lee/edita con aprobacion" -ForegroundColor Gray
Write-Host "   - Full Access: Acceso completo automatico" -ForegroundColor Gray
Write-Host ""
Write-Host "2. REFERENCIAS DE ARCHIVOS:" -ForegroundColor Yellow
Write-Host "   Usa @archivo.js para referenciar archivos" -ForegroundColor Gray
Write-Host "   Ejemplo: 'Usa @package.json como referencia'" -ForegroundColor Gray
Write-Host ""
Write-Host "3. PREVIEW DE EDICIONES:" -ForegroundColor Yellow
Write-Host "   - Ve los cambios antes de aplicarlos" -ForegroundColor Gray
Write-Host "   - Aprueba o rechaza cada edicion" -ForegroundColor Gray
Write-Host "   - Edicion con un solo clic" -ForegroundColor Gray
Write-Host ""
Write-Host "SIGUIENTE PASO:" -ForegroundColor Cyan
Write-Host "  1. Reinicia LabDev Editor" -ForegroundColor White
Write-Host "  2. Abre el chat AI (Ctrl+Shift+L)" -ForegroundColor White
Write-Host "  3. Prueba los nuevos modos en la parte superior" -ForegroundColor White
Write-Host "  4. Prueba: 'Lee @package.json y explicamelo'" -ForegroundColor White
Write-Host ""
