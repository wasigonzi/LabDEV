# ============================================
# LabDEV - Instalador de Extension AI
# ============================================
# Este script instala la extension labdev-ai-complete
# en el editor LabDev-Editor
# ============================================

$ErrorActionPreference = "Stop"

# Rutas
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$extensionSource = Join-Path $projectRoot "extension\labdev-ai-complete"
$editorExtensions = Join-Path $projectRoot "..\LabDev-Editor\resources\app\extensions\labdev-ai-complete"

Write-Host ""
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "   LabDEV AI - Instalador de Extension" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

# Verificar que existe la extension fuente
if (-not (Test-Path $extensionSource)) {
    Write-Host "[ERROR] No se encontro la extension en: $extensionSource" -ForegroundColor Red
    exit 1
}

# Crear directorio destino si no existe
if (-not (Test-Path (Split-Path -Parent $editorExtensions))) {
    Write-Host "[ERROR] No se encontro el editor en la ruta esperada" -ForegroundColor Red
    exit 1
}

# Copiar extension
Write-Host "[1/3] Copiando extension..." -ForegroundColor Cyan
if (Test-Path $editorExtensions) {
    Remove-Item -Path $editorExtensions -Recurse -Force
}
Copy-Item -Path $extensionSource -Destination $editorExtensions -Recurse

# Verificar instalacion
Write-Host "[2/3] Verificando instalacion..." -ForegroundColor Cyan
$requiredFiles = @("extension.js", "package.json", "webview.js")
$allFilesExist = $true
foreach ($file in $requiredFiles) {
    $filePath = Join-Path $editorExtensions $file
    if (-not (Test-Path $filePath)) {
        Write-Host "  [FALTA] $file" -ForegroundColor Red
        $allFilesExist = $false
    } else {
        Write-Host "  [OK] $file" -ForegroundColor Green
    }
}

if (-not $allFilesExist) {
    Write-Host "[ERROR] Instalacion incompleta" -ForegroundColor Red
    exit 1
}

Write-Host "[3/3] Instalacion completada!" -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "   Extension instalada correctamente!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "Para usar:" -ForegroundColor Yellow
Write-Host "  1. Abre LabDev-Editor" -ForegroundColor White
Write-Host "  2. Presiona Ctrl+Shift+L para abrir el chat" -ForegroundColor White
Write-Host ""
