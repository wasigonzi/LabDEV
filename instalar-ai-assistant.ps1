# Script para instalar LabDev AI Assistant

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║         INSTALANDO LABDEV AI ASSISTANT                       ║" -ForegroundColor Magenta
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

$extensionPath = ".\labdev-ai-assistant"

# Verificar Node.js
Write-Host "[1/5] Verificando Node.js..." -ForegroundColor Cyan
$nodeVersion = node --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "  ❌ Node.js no está instalado" -ForegroundColor Red
    Write-Host "  Descarga Node.js desde: https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}
Write-Host "  ✓ Node.js $nodeVersion" -ForegroundColor Green

# Instalar dependencias
Write-Host ""
Write-Host "[2/5] Instalando dependencias..." -ForegroundColor Cyan
Push-Location $extensionPath
npm install --silent
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ Dependencias instaladas" -ForegroundColor Green
} else {
    Write-Host "  ❌ Error instalando dependencias" -ForegroundColor Red
    Pop-Location
    exit 1
}

# Instalar vsce si no está
Write-Host ""
Write-Host "[3/5] Verificando vsce..." -ForegroundColor Cyan
$vsceInstalled = Get-Command vsce -ErrorAction SilentlyContinue
if (-not $vsceInstalled) {
    Write-Host "  Instalando vsce..." -ForegroundColor Yellow
    npm install -g @vscode/vsce --silent
}
Write-Host "  ✓ vsce disponible" -ForegroundColor Green

# Empaquetar extensión
Write-Host ""
Write-Host "[4/5] Empaquetando extensión..." -ForegroundColor Cyan
vsce package --no-dependencies 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ Extensión empaquetada" -ForegroundColor Green
} else {
    Write-Host "  ❌ Error empaquetando" -ForegroundColor Red
    Pop-Location
    exit 1
}

Pop-Location

# Copiar a LabDev
Write-Host ""
Write-Host "[5/5] Copiando a LabDev..." -ForegroundColor Cyan
$vsixFile = Get-ChildItem "$extensionPath\*.vsix" | Select-Object -First 1
$labdevExtensions = "C:\Users\sylex\LabDEV\LabDev-Editor\extensions"

if (-not (Test-Path $labdevExtensions)) {
    New-Item -ItemType Directory -Path $labdevExtensions -Force | Out-Null
}

Copy-Item $vsixFile.FullName $labdevExtensions -Force
Write-Host "  ✓ Extensión copiada" -ForegroundColor Green

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║              ✓ INSTALACIÓN COMPLETADA                         ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Próximos pasos:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Obtén tu API Key GRATIS:" -ForegroundColor White
Write-Host "   → Ve a https://huggingface.co/" -ForegroundColor Cyan
Write-Host "   → Crea cuenta (gratis)" -ForegroundColor Cyan
Write-Host "   → Settings → Access Tokens → New Token" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Instala la extensión en LabDev:" -ForegroundColor White
Write-Host "   → Abre LabDev" -ForegroundColor Cyan
Write-Host "   → Ctrl+Shift+P" -ForegroundColor Cyan
Write-Host "   → 'Extensions: Install from VSIX'" -ForegroundColor Cyan
Write-Host "   → Selecciona: $($vsixFile.Name)" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Configura tu API Key:" -ForegroundColor White
Write-Host "   → File → Preferences → Settings" -ForegroundColor Cyan
Write-Host "   → Busca 'LabDev AI'" -ForegroundColor Cyan
Write-Host "   → Pega tu API key" -ForegroundColor Cyan
Write-Host ""
Write-Host "4. Usa el chat:" -ForegroundColor White
Write-Host "   → Ctrl+Shift+P → 'LabDev: Abrir Chat con IA'" -ForegroundColor Cyan
Write-Host ""
Write-Host "Archivo VSIX: $($vsixFile.FullName)" -ForegroundColor Yellow
Write-Host ""
