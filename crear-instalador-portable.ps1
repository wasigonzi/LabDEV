# Script para crear versión portable de LabDev

$editorPath = "C:\Users\sylex\LabDEV\LabDev-Editor"
$outputZip = "C:\Users\sylex\LabDEV\LabDev-Portable-v1.0.zip"

Write-Host "=== Creando instalador portable de LabDev ===" -ForegroundColor Green
Write-Host ""

# Verificar que existe
if (-not (Test-Path $editorPath)) {
    Write-Host "ERROR: No se encuentra LabDev en $editorPath" -ForegroundColor Red
    exit 1
}

# Eliminar ZIP anterior si existe
if (Test-Path $outputZip) {
    Remove-Item $outputZip -Force
    Write-Host "Eliminado ZIP anterior" -ForegroundColor Yellow
}

# Crear ZIP
Write-Host "Comprimiendo LabDev..." -ForegroundColor Cyan
Compress-Archive -Path $editorPath -DestinationPath $outputZip -CompressionLevel Optimal

# Verificar tamaño
$size = (Get-Item $outputZip).Length / 1MB
Write-Host ""
Write-Host "=== Instalador portable creado ===" -ForegroundColor Green
Write-Host "Archivo: $outputZip" -ForegroundColor Cyan
Write-Host "Tamaño: $([math]::Round($size, 2)) MB" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para distribuir:" -ForegroundColor Yellow
Write-Host "1. Sube este ZIP a GitHub Releases" -ForegroundColor White
Write-Host "2. Los usuarios solo necesitan extraer y ejecutar LabDev.exe" -ForegroundColor White
