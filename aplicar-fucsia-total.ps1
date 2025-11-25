# Script para reemplazar TODOS los azules por fucsia en LabDev

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║         APLICANDO FUCSIA EN TODOS LOS TEMAS                   ║" -ForegroundColor Magenta
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

$themesPath = "C:\Users\sylex\LabDEV\LabDev-Editor\resources\app\extensions\theme-defaults\themes"

# Colores azules a reemplazar por fucsia
$azules = @(
    '#569cd6',  # Azul claro (keywords en Dark+)
    '#4ec9b0',  # Verde azulado (tipos)
    '#9cdcfe',  # Azul muy claro (variables)
    '#2472c8',  # Azul medio (terminal)
    '#3b8eea',  # Azul brillante (terminal)
    '#0078d4',  # Azul Microsoft
    '#007acc',  # Azul VSCode
    '#4fc1ff',  # Azul claro
    '#0098ff',  # Azul brillante
    '#00bfff'   # Deep Sky Blue
)

$fucsia = '#ff00ff'
$fuchsiaBright = '#ff33ff'

# Procesar todos los temas oscuros
$temas = @(
    'dark_plus.json',
    'dark_modern.json',
    'dark_vs.json',
    'labdev-dark-color-theme.json'
)

foreach ($tema in $temas) {
    $temaPath = Join-Path $themesPath $tema
    
    if (Test-Path $temaPath) {
        Write-Host "Procesando: $tema" -ForegroundColor Cyan
        
        $content = Get-Content $temaPath -Raw
        
        # Reemplazar todos los azules por fucsia
        foreach ($azul in $azules) {
            if ($azul -match 'bright|ff') {
                $content = $content -replace $azul, $fuchsiaBright
            } else {
                $content = $content -replace $azul, $fucsia
            }
        }
        
        $content | Set-Content $temaPath -Encoding UTF8
        Write-Host "  ✓ Azules reemplazados por fucsia" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Configurando tema por defecto..." -ForegroundColor Cyan

# Configurar settings.json del usuario
$settingsPath = "$env:USERPROFILE\.labdev\User\settings.json"
$settingsDir = Split-Path $settingsPath

if (-not (Test-Path $settingsDir)) {
    New-Item -ItemType Directory -Path $settingsDir -Force | Out-Null
}

$settings = @{
    "workbench.colorTheme" = "LabDev Dark"
    "workbench.iconTheme" = "vs-seti"
    "editor.fontFamily" = "Consolas, 'Courier New', monospace"
    "editor.fontSize" = 14
    "editor.cursorBlinking" = "smooth"
    "editor.cursorSmoothCaretAnimation" = "on"
    "editor.bracketPairColorization.enabled" = $true
}

$settings | ConvertTo-Json | Set-Content $settingsPath -Encoding UTF8

Write-Host "  ✓ Tema LabDev Dark configurado como predeterminado" -ForegroundColor Green

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║              ✓ FUCSIA APLICADO EXITOSAMENTE                   ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Cambios realizados:" -ForegroundColor Yellow
Write-Host "  • Todos los azules → Fucsia (#ff00ff)" -ForegroundColor Magenta
Write-Host "  • Variables → Fucsia" -ForegroundColor Magenta
Write-Host "  • Tipos/Clases → Fucsia" -ForegroundColor Magenta
Write-Host "  • Keywords → Fucsia" -ForegroundColor Magenta
Write-Host "  • Terminal azul → Fucsia" -ForegroundColor Magenta
Write-Host ""
Write-Host "IMPORTANTE:" -ForegroundColor Red
Write-Host "1. Cierra LabDev COMPLETAMENTE" -ForegroundColor White
Write-Host "2. Abre LabDev de nuevo" -ForegroundColor White
Write-Host "3. Todo lo azul ahora será FUCSIA" -ForegroundColor Magenta
Write-Host ""
