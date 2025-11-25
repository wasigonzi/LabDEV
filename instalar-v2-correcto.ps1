# Script de instalacion CORRECTO para LabDev AI v2.0
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "  INSTALANDO LABDEV AI v2.0 (CORRECTO)" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""

# Cerrar LabDev
Write-Host "[1/7] Cerrando LabDev..." -ForegroundColor Cyan
Get-Process -Name "LabDev" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2

# Empaquetar extension
Write-Host ""
Write-Host "[2/7] Empaquetando extension..." -ForegroundColor Cyan
Set-Location "labdev-ai-complete"
npx @vscode/vsce package --allow-missing-repository --out labdev-ai-complete-2.0.0.vsix

# Extraer VSIX
Write-Host ""
Write-Host "[3/7] Extrayendo extension..." -ForegroundColor Cyan
Copy-Item "labdev-ai-complete-2.0.0.vsix" "labdev-ai-complete-2.0.0.zip" -Force
Expand-Archive -Path "labdev-ai-complete-2.0.0.zip" -DestinationPath "temp-extract" -Force

# Eliminar extension antigua
Write-Host ""
Write-Host "[4/7] Eliminando extension antigua..." -ForegroundColor Cyan
$oldExt = "..\..\LabDev-Editor\resources\app\extensions\labdev-ai-assistant"
if (Test-Path $oldExt) {
    Remove-Item $oldExt -Recurse -Force
    Write-Host "  OK Extension antigua eliminada" -ForegroundColor Green
}

# Copiar nueva extension
Write-Host ""
Write-Host "[5/7] Instalando nueva extension..." -ForegroundColor Cyan
$dest = "..\..\LabDev-Editor\resources\app\extensions\labdev-ai-complete"
if (Test-Path $dest) {
    Remove-Item $dest -Recurse -Force
}
Copy-Item "temp-extract\extension" $dest -Recurse -Force
Write-Host "  OK Extension instalada en: $dest" -ForegroundColor Green

# Limpiar archivos temporales
Write-Host ""
Write-Host "[6/7] Limpiando archivos temporales..." -ForegroundColor Cyan
Remove-Item "temp-extract" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "labdev-ai-complete-2.0.0.zip" -Force -ErrorAction SilentlyContinue
Write-Host "  OK Archivos temporales eliminados" -ForegroundColor Green

Set-Location ".."

# Iniciar LabDev
Write-Host ""
Write-Host "[7/7] Iniciando LabDev..." -ForegroundColor Cyan
Start-Process "..\LabDev-Editor\LabDev.exe"
Start-Sleep -Seconds 3

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  INSTALACION COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "AHORA DEBES VER:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Abre el chat AI (icono fucsia)" -ForegroundColor White
Write-Host "2. En la parte superior veras:" -ForegroundColor White
Write-Host "   [Chat] [Agent] [Full Access]" -ForegroundColor Magenta
Write-Host ""
Write-Host "3. El mensaje de bienvenida dira:" -ForegroundColor White
Write-Host "   'LabDev AI Agent' (no 'Vibe')" -ForegroundColor Magenta
Write-Host ""
Write-Host "4. Veras secciones:" -ForegroundColor White
Write-Host "   - Modos disponibles" -ForegroundColor Magenta
Write-Host "   - Caracteristicas" -ForegroundColor Magenta
Write-Host ""
Write-Host "PRUEBA:" -ForegroundColor Yellow
Write-Host "  Lee @package.json" -ForegroundColor Gray
Write-Host ""
