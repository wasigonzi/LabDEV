# Script para iniciar LabDev con la extension AI
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "  INICIANDO LABDEV CON AI" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""

# Cerrar instancias existentes de LabDev
Write-Host "[1/2] Cerrando instancias existentes..." -ForegroundColor Cyan
Get-Process -Name "LabDev" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2

# Iniciar LabDev
Write-Host ""
Write-Host "[2/2] Iniciando LabDev Editor..." -ForegroundColor Cyan
Start-Process "..\LabDev-Editor\LabDev.exe"

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  LABDEV INICIADO" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "PASOS SIGUIENTES:" -ForegroundColor Cyan
Write-Host "  1. Espera a que LabDev cargue completamente" -ForegroundColor White
Write-Host "  2. Busca el icono FUCSIA en la barra lateral izquierda" -ForegroundColor Magenta
Write-Host "  3. Haz clic en el icono para abrir el chat AI" -ForegroundColor White
Write-Host "  4. Haz clic en el boton de engranaje (arriba derecha)" -ForegroundColor White
Write-Host "  5. Pega tu API Key de HuggingFace" -ForegroundColor White
Write-Host ""
Write-Host "OBTENER API KEY GRATIS:" -ForegroundColor Yellow
Write-Host "  https://huggingface.co/settings/tokens" -ForegroundColor Gray
Write-Host ""
Write-Host "ATAJO DE TECLADO:" -ForegroundColor Yellow
Write-Host "  Ctrl+Shift+L - Abrir chat AI" -ForegroundColor Gray
Write-Host ""
