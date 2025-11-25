# Script para agregar boton de AI Assistant en la barra de titulo de LabDev
Write-Host "=== Agregando boton AI Assistant a la barra de titulo ===" -ForegroundColor Magenta

$workbenchPath = "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js"
$backupPath = "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js.backup"

# Crear backup si no existe
if (-not (Test-Path $backupPath)) {
    Write-Host "Creando backup del workbench..." -ForegroundColor Yellow
    Copy-Item $workbenchPath $backupPath
}

# Leer el contenido del archivo
Write-Host "Leyendo workbench.desktop.main.js..." -ForegroundColor Yellow
$content = Get-Content $workbenchPath -Raw -Encoding UTF8

# Codigo JavaScript para inyectar el boton
$injectionCode = @'
(function(){
    if(window.labdevAIButtonInjected)return;
    window.labdevAIButtonInjected=true;
    
    function addAIButton(){
        const titleBar=document.querySelector('.titlebar-container, .window-title, .menubar');
        if(!titleBar||document.getElementById('labdev-ai-btn'))return;
        
        const btn=document.createElement('div');
        btn.id='labdev-ai-btn';
        btn.innerHTML='<svg width="16" height="16" viewBox="0 0 16 16"><path d="M8 2 L9 6 L13 7 L9 8 L8 12 L7 8 L3 7 L7 6 Z" fill="#ff00ff"/><circle cx="4" cy="4" r="0.8" fill="#ff00ff"/><circle cx="12" cy="4" r="0.8" fill="#ff00ff"/><circle cx="4" cy="12" r="0.8" fill="#ff00ff"/><circle cx="12" cy="12" r="0.8" fill="#ff00ff"/></svg>';
        btn.title='LabDev AI Assistant (Ctrl+Shift+L)';
        btn.style.cssText='display:inline-flex;align-items:center;justify-content:center;width:35px;height:35px;cursor:pointer;margin:0 4px;border-radius:5px;transition:background 0.2s;';
        
        btn.onmouseover=()=>btn.style.background='rgba(255,0,255,0.1)';
        btn.onmouseout=()=>btn.style.background='transparent';
        btn.onclick=()=>{
            try{
                if(typeof acquireVsCodeApi!=='undefined'){
                    const vscode=acquireVsCodeApi();
                    vscode.postMessage({command:'workbench.action.executeCommand',args:['labdev-ai.openChat']});
                }else{
                    const event=new CustomEvent('vscode:runCommand',{detail:{command:'labdev-ai.openChat'}});
                    window.dispatchEvent(event);
                }
            }catch(e){
                console.log('Opening AI Assistant...');
                window.postMessage({type:'executeCommand',command:'labdev-ai.openChat'},'*');
            }
        };
        
        const actions=titleBar.querySelector('.window-controls-container, .window-appicon, .menubar-menu-button');
        if(actions){
            actions.parentNode.insertBefore(btn,actions);
        }else{
            titleBar.appendChild(btn);
        }
    }
    
    if(document.readyState==='loading'){
        document.addEventListener('DOMContentLoaded',addAIButton);
    }else{
        addAIButton();
    }
    setTimeout(addAIButton,1000);
    setTimeout(addAIButton,3000);
})();
'@

# Verificar si ya esta inyectado
if ($content -match "labdevAIButtonInjected") {
    Write-Host "El boton AI ya esta inyectado en el workbench." -ForegroundColor Green
    exit 0
}

# Inyectar el codigo al final del archivo
Write-Host "Inyectando codigo del boton AI..." -ForegroundColor Yellow
$content = $content + "`n" + $injectionCode

# Guardar el archivo modificado
Write-Host "Guardando cambios..." -ForegroundColor Yellow
$content | Out-File -FilePath $workbenchPath -Encoding UTF8 -NoNewline

Write-Host ""
Write-Host "Boton AI Assistant agregado exitosamente!" -ForegroundColor Green
Write-Host ""
Write-Host "IMPORTANTE: Reinicia LabDev Editor para ver el boton" -ForegroundColor Cyan
Write-Host "El boton aparecera en la barra de titulo superior" -ForegroundColor Cyan
