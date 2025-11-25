# Script para cambiar el branding de VSCodium a LabDev
$editorPath = "C:\Users\sylex\LabDEV\LabDev-Editor"
$productJsonPath = "$editorPath\resources\app\product.json"

Write-Host "=== Modificando branding a LabDev ===" -ForegroundColor Green

# Leer product.json
$productJson = Get-Content $productJsonPath -Raw | ConvertFrom-Json

# Modificar nombres
$productJson.nameShort = "LabDev"
$productJson.nameLong = "LabDev Editor"
$productJson.applicationName = "labdev"
$productJson.dataFolderName = ".labdev"
$productJson.win32MutexName = "labdev"
$productJson.win32DirName = "LabDev"
$productJson.win32NameVersion = "LabDev"
$productJson.win32RegValueName = "LabDev"
$productJson.win32AppUserModelId = "LabDev.LabDev"
$productJson.win32ShellNameShort = "LabDev"
$productJson.win32TunnelServiceMutex = "labdev-tunnelservice"
$productJson.win32TunnelMutex = "labdev-tunnel"
$productJson.darwinBundleIdentifier = "com.labdev"
$productJson.linuxIconName = "labdev"
$productJson.urlProtocol = "labdev"
$productJson.serverApplicationName = "labdev-server"
$productJson.serverDataFolderName = ".labdev-server"
$productJson.tunnelApplicationName = "labdev-tunnel"

# URLs personalizadas
$productJson.licenseUrl = "https://github.com/wasigonzi/LabDEV/blob/master/LICENSE"
$productJson.reportIssueUrl = "https://github.com/wasigonzi/LabDEV/issues/new"

# Guardar cambios
$productJson | ConvertTo-Json -Depth 100 | Set-Content $productJsonPath -Encoding UTF8

Write-Host "OK product.json modificado" -ForegroundColor Green

# Renombrar ejecutable
if (Test-Path "$editorPath\VSCodium.exe") {
    Rename-Item "$editorPath\VSCodium.exe" "LabDev.exe" -Force
    Write-Host "OK Ejecutable renombrado a LabDev.exe" -ForegroundColor Green
}

# Modificar package.json
$packageJsonPath = "$editorPath\resources\app\package.json"
if (Test-Path $packageJsonPath) {
    $packageJson = Get-Content $packageJsonPath -Raw | ConvertFrom-Json
    $packageJson.name = "labdev"
    $packageJson.productName = "LabDev"
    $packageJson | ConvertTo-Json -Depth 100 | Set-Content $packageJsonPath -Encoding UTF8
    Write-Host "OK package.json modificado" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Branding completado ===" -ForegroundColor Green
Write-Host "Ejecutable: $editorPath\LabDev.exe" -ForegroundColor Cyan
