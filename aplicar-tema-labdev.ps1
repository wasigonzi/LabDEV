# Script para aplicar el tema LabDev con colores fucsia

$editorPath = "C:\Users\sylex\LabDEV\LabDev-Editor"
$themesPath = "$editorPath\resources\app\extensions\theme-defaults\themes"
$themeFile = "labdev-dark-color-theme.json"

Write-Host "=== Aplicando tema LabDev con colores fucsia ===" -ForegroundColor Magenta
Write-Host ""

# Verificar que existe el directorio
if (-not (Test-Path $themesPath)) {
    Write-Host "ERROR: No se encuentra el directorio de temas" -ForegroundColor Red
    Write-Host "Ruta: $themesPath" -ForegroundColor Yellow
    exit 1
}

# Copiar el tema
Write-Host "Copiando tema personalizado..." -ForegroundColor Cyan
Copy-Item ".\labdev-theme.json" "$themesPath\$themeFile" -Force

Write-Host "OK Tema copiado" -ForegroundColor Green

# Modificar package.json para registrar el tema
$packageJsonPath = "$editorPath\resources\app\extensions\theme-defaults\package.json"

if (Test-Path $packageJsonPath) {
    Write-Host "Registrando tema en package.json..." -ForegroundColor Cyan
    
    $packageJson = Get-Content $packageJsonPath -Raw | ConvertFrom-Json
    
    # Agregar el tema si no existe
    $themeExists = $false
    foreach ($theme in $packageJson.contributes.themes) {
        if ($theme.label -eq "LabDev Dark") {
            $themeExists = $true
            break
        }
    }
    
    if (-not $themeExists) {
        $newTheme = @{
            label = "LabDev Dark"
            uiTheme = "vs-dark"
            path = "./themes/$themeFile"
        }
        
        $packageJson.contributes.themes += $newTheme
        $packageJson | ConvertTo-Json -Depth 100 | Set-Content $packageJsonPath -Encoding UTF8
        Write-Host "OK Tema registrado" -ForegroundColor Green
    } else {
        Write-Host "OK Tema ya estaba registrado" -ForegroundColor Green
    }
}

# Crear configuración por defecto
$settingsPath = "$editorPath\resources\app\out\vs\code\electron-sandbox\workbench"
$defaultSettings = @{
    "workbench.colorTheme" = "LabDev Dark"
    "workbench.iconTheme" = "vs-seti"
    "editor.fontFamily" = "Consolas, 'Courier New', monospace"
    "editor.fontSize" = 14
    "editor.lineHeight" = 22
    "editor.cursorBlinking" = "smooth"
    "editor.cursorSmoothCaretAnimation" = "on"
    "workbench.startupEditor" = "welcomePage"
}

Write-Host ""
Write-Host "=== Tema aplicado exitosamente ===" -ForegroundColor Magenta
Write-Host ""
Write-Host "Para activar el tema:" -ForegroundColor Yellow
Write-Host "1. Abre LabDev" -ForegroundColor White
Write-Host "2. Presiona Ctrl+K Ctrl+T" -ForegroundColor White
Write-Host "3. Selecciona 'LabDev Dark'" -ForegroundColor White
Write-Host ""
Write-Host "O desde el menú:" -ForegroundColor Yellow
Write-Host "File > Preferences > Color Theme > LabDev Dark" -ForegroundColor White
Write-Host ""
Write-Host "Colores principales:" -ForegroundColor Cyan
Write-Host "  - Fucsia: #ff00ff (acentos, keywords, cursores)" -ForegroundColor Magenta
Write-Host "  - Fondo oscuro: #1e1e1e" -ForegroundColor DarkGray
Write-Host "  - Texto: #d4d4d4" -ForegroundColor Gray
