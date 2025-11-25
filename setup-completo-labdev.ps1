# Script completo para configurar LabDev con tema fucsia

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║           CONFIGURACIÓN COMPLETA DE LABDEV                    ║" -ForegroundColor Magenta
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

# Paso 1: Aplicar branding
Write-Host "[1/3] Aplicando branding LabDev..." -ForegroundColor Cyan
& .\rebrand-to-labdev.ps1
Write-Host ""

# Paso 2: Aplicar tema
Write-Host "[2/3] Aplicando tema con colores fucsia..." -ForegroundColor Cyan
& .\aplicar-tema-labdev.ps1
Write-Host ""

# Paso 3: Configurar tema por defecto
Write-Host "[3/3] Configurando tema como predeterminado..." -ForegroundColor Cyan
& .\configurar-tema-por-defecto.ps1
Write-Host ""

Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║              ✓ CONFIGURACIÓN COMPLETADA                       ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "LabDev está listo con:" -ForegroundColor Yellow
Write-Host "  ✓ Branding personalizado" -ForegroundColor White
Write-Host "  ✓ Tema LabDev Dark con colores fucsia" -ForegroundColor Magenta
Write-Host "  ✓ Configuración optimizada" -ForegroundColor White
Write-Host ""
Write-Host "Para ejecutar LabDev:" -ForegroundColor Cyan
Write-Host "  C:\Users\sylex\LabDEV\LabDev-Editor\LabDev.exe" -ForegroundColor White
Write-Host ""
Write-Host "Documentación del tema: TEMA-LABDEV.md" -ForegroundColor Yellow
Write-Host ""
