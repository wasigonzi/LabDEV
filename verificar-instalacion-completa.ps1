# Script de verificacion completa de LabDev AI
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "  VERIFICANDO INSTALACION LABDEV AI" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""

# Verificar archivos de la extension
Write-Host "[1/5] Verificando archivos de extension..." -ForegroundColor Cyan
$archivos = @(
    "labdev-ai-complete\extension.js",
    "labdev-ai-complete\webview.js",
    "labdev-ai-complete\package.json",
    "labdev-ai-complete\resources\icon.svg",
    "labdev-ai-complete\labdev-ai-complete-1.0.0.vsix"
)

$todosExisten = $true
foreach ($archivo in $archivos) {
    if (Test-Path $archivo) {
        Write-Host "  OK $archivo" -ForegroundColor Green
    } else {
        Write-Host "  ERROR $archivo FALTA" -ForegroundColor Red
        $todosExisten = $false
    }
}

# Verificar node_modules
Write-Host ""
Write-Host "[2/5] Verificando dependencias..." -ForegroundColor Cyan
if (Test-Path "labdev-ai-complete\node_modules") {
    Write-Host "  OK node_modules instalado" -ForegroundColor Green
} else {
    Write-Host "  ERROR node_modules FALTA - ejecuta: npm install" -ForegroundColor Red
    $todosExisten = $false
}

# Verificar LabDev Editor
Write-Host ""
Write-Host "[3/5] Verificando LabDev Editor..." -ForegroundColor Cyan
if (Test-Path "..\LabDev-Editor\LabDev.exe") {
    Write-Host "  OK LabDev.exe encontrado" -ForegroundColor Green
} else {
    Write-Host "  ERROR LabDev.exe NO ENCONTRADO" -ForegroundColor Red
    $todosExisten = $false
}

# Verificar extension instalada
Write-Host ""
Write-Host "[4/5] Verificando extension instalada..." -ForegroundColor Cyan
$extensionPath = "$env:USERPROFILE\.vscode-oss\extensions"
if (Test-Path $extensionPath) {
    $instalada = Get-ChildItem $extensionPath -Filter "labdev.labdev-ai-complete*" -Directory
    if ($instalada) {
        Write-Host "  OK Extension instalada en: $($instalada.FullName)" -ForegroundColor Green
    } else {
        Write-Host "  AVISO Extension NO instalada - ejecuta: instalar-extension-completa.ps1" -ForegroundColor Yellow
    }
} else {
    Write-Host "  AVISO Carpeta de extensiones no existe aun" -ForegroundColor Yellow
}

# Verificar VSIX
Write-Host ""
Write-Host "[5/5] Verificando paquete VSIX..." -ForegroundColor Cyan
if (Test-Path "labdev-ai-complete\labdev-ai-complete-1.0.0.vsix") {
    $vsixSize = (Get-Item "labdev-ai-complete\labdev-ai-complete-1.0.0.vsix").Length
    $sizeKB = [math]::Round($vsixSize/1024, 2)
    Write-Host "  OK VSIX creado ($sizeKB KB)" -ForegroundColor Green
} else {
    Write-Host "  ERROR VSIX NO CREADO - ejecuta: npx @vscode/vsce package" -ForegroundColor Red
    $todosExisten = $false
}

# Resumen
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
if ($todosExisten) {
    Write-Host "  OK TODO LISTO PARA USAR" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "PASOS PARA USAR:" -ForegroundColor Cyan
    Write-Host "  1. Abre LabDev Editor" -ForegroundColor White
    Write-Host "  2. Busca el icono fucsia en la barra lateral izquierda" -ForegroundColor White
    Write-Host "  3. Haz clic para abrir el chat AI" -ForegroundColor White
    Write-Host "  4. Configura tu API Key (boton engranaje ⚙️)" -ForegroundColor White
    Write-Host "  5. Obtén tu API Key gratis en:" -ForegroundColor White
    Write-Host "     https://huggingface.co/settings/tokens" -ForegroundColor Gray
    Write-Host ""
    Write-Host "ATAJOS DE TECLADO:" -ForegroundColor Yellow
    Write-Host "  Ctrl+Shift+L - Abrir chat AI" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host "  AVISO FALTAN ALGUNOS ARCHIVOS" -ForegroundColor Yellow
    Write-Host "============================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "EJECUTA ESTOS COMANDOS:" -ForegroundColor Cyan
    Write-Host "  cd labdev-ai-complete" -ForegroundColor White
    Write-Host "  npm install" -ForegroundColor White
    Write-Host "  npx @vscode/vsce package --allow-missing-repository" -ForegroundColor White
    Write-Host "  cd .." -ForegroundColor White
    Write-Host "  .\instalar-extension-completa.ps1" -ForegroundColor White
    Write-Host ""
}
