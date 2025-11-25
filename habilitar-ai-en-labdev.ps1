# Script para habilitar AI Assistant en LabDev

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║         HABILITANDO AI ASSISTANT EN LABDEV                    ║" -ForegroundColor Magenta
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

# Copiar extensión
Write-Host "[1/3] Copiando extensión..." -ForegroundColor Cyan
$source = ".\labdev-ai-assistant"
$dest = "C:\Users\sylex\LabDEV\LabDev-Editor\resources\app\extensions\labdev-ai-assistant"

if (Test-Path $dest) {
    Remove-Item $dest -Recurse -Force
}

Copy-Item $source $dest -Recurse -Force
Write-Host "  ✓ Extensión copiada" -ForegroundColor Green

# Crear configuración de usuario
Write-Host ""
Write-Host "[2/3] Configurando..." -ForegroundColor Cyan
$settingsPath = "$env:USERPROFILE\.labdev\User\settings.json"
$settingsDir = Split-Path $settingsPath

if (-not (Test-Path $settingsDir)) {
    New-Item -ItemType Directory -Path $settingsDir -Force | Out-Null
}

$settings = @{}
if (Test-Path $settingsPath) {
    $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json -AsHashtable
}

# Agregar configuración de AI
$settings["labdev-ai.model"] = "mistralai/Mistral-7B-Instruct-v0.2"
$settings["labdev-ai.apiKey"] = ""

$settings | ConvertTo-Json | Set-Content $settingsPath -Encoding UTF8
Write-Host "  ✓ Configuración creada" -ForegroundColor Green

# Instrucciones
Write-Host ""
Write-Host "[3/3] Próximos pasos:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Obtén tu API Key GRATIS:" -ForegroundColor Yellow
Write-Host "   → https://huggingface.co/settings/tokens" -ForegroundColor White
Write-Host ""
Write-Host "2. Abre LabDev y configura la API Key:" -ForegroundColor Yellow
Write-Host "   → File → Preferences → Settings" -ForegroundColor White
Write-Host "   → Busca 'LabDev AI'" -ForegroundColor White
Write-Host "   → Pega tu API key" -ForegroundColor White
Write-Host ""
Write-Host "3. Usa el AI Assistant:" -ForegroundColor Yellow
Write-Host "   → Busca el icono 🤖 en la barra lateral izquierda" -ForegroundColor White
Write-Host "   → O presiona Ctrl+Shift+P → 'LabDev: Abrir Chat con IA'" -ForegroundColor White
Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║              ✓ AI ASSISTANT HABILITADO                        ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "IMPORTANTE: Reinicia LabDev para ver el panel de AI" -ForegroundColor Red
Write-Host ""
