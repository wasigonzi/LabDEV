# Script para limpiar archivos temporales de compilación

Write-Host "=== Limpiando archivos temporales ===" -ForegroundColor Yellow

$itemsToDelete = @(
    "C:\Users\sylex\LabDEV\LabDEV\vscode",
    "C:\Users\sylex\LabDEV\VSCodium-Original",
    "C:\Users\sylex\LabDEV\VSCodium.zip"
)

foreach ($item in $itemsToDelete) {
    if (Test-Path $item) {
        Write-Host "Eliminando: $item" -ForegroundColor Cyan
        try {
            Remove-Item $item -Recurse -Force -ErrorAction Stop
            Write-Host "  OK Eliminado" -ForegroundColor Green
        } catch {
            Write-Host "  ADVERTENCIA: No se pudo eliminar (puede estar en uso)" -ForegroundColor Yellow
            Write-Host "  Cierra todos los procesos y ejecuta este script nuevamente" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "=== Limpieza completada ===" -ForegroundColor Green
Write-Host ""
Write-Host "Archivos finales en el proyecto:" -ForegroundColor Cyan
Get-ChildItem "C:\Users\sylex\LabDEV\LabDEV" -File | Select-Object Name | Format-Table -AutoSize
