# ============================================
# LabDEV - Crear Version Portable
# ============================================
# Este script crea un ZIP portable del editor
# ============================================

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$editorPath = Join-Path $projectRoot "..\LabDev-Editor"
$outputPath = Join-Path $projectRoot "dist"
$zipName = "LabDev-Portable-v1.0.zip"

Write-Host ""
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "   LabDEV - Crear Version Portable" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

# Verificar que existe el editor
if (-not (Test-Path $editorPath)) {
    Write-Host "[ERROR] No se encontro LabDev-Editor" -ForegroundColor Red
    exit 1
}

# Crear directorio de salida
if (-not (Test-Path $outputPath)) {
    New-Item -ItemType Directory -Path $outputPath -Force | Out-Null
}

$zipPath = Join-Path $outputPath $zipName

Write-Host "[1/2] Creando archivo ZIP..." -ForegroundColor Cyan
Write-Host "  Origen: $editorPath" -ForegroundColor Gray
Write-Host "  Destino: $zipPath" -ForegroundColor Gray

# Eliminar ZIP anterior si existe
if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
}

# Crear ZIP
Compress-Archive -Path "$editorPath\*" -DestinationPath $zipPath -CompressionLevel Optimal

Write-Host "[2/2] Verificando..." -ForegroundColor Cyan
if (Test-Path $zipPath) {
    $size = (Get-Item $zipPath).Length / 1MB
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host "   ZIP creado exitosamente!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "Archivo: $zipPath" -ForegroundColor White
    Write-Host "Tamano: $([math]::Round($size, 2)) MB" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host "[ERROR] No se pudo crear el ZIP" -ForegroundColor Red
    exit 1
}
