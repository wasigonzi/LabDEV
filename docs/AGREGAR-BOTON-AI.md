# Cómo agregar el botón AI en la barra de título

## Análisis de la estructura

La barra de título de VSCode/VSCodium tiene esta estructura:
```
.part.titlebar
  └── .titlebar-container
      ├── .titlebar-left
      ├── .titlebar-center
      └── .titlebar-right
          ├── .action-toolbar-container (iconos de acciones)
          └── .window-controls-container (minimizar, maximizar, cerrar)
```

## Solución: Agregar botón mediante CSS + JavaScript

### Paso 1: Agregar el botón en el workbench.desktop.main.js

El código debe:
1. Esperar a que el DOM esté listo
2. Encontrar `.titlebar-right` o `.action-toolbar-container`
3. Crear un div con clase `action-item`
4. Agregar el icono y el evento click
5. Insertar antes de `.window-controls-container`

### Paso 2: Código a inyectar

```javascript
(function() {
    function addAIButton() {
        // Verificar si ya existe
        if (document.getElementById('labdev-ai-btn')) return;
        
        // Buscar el contenedor
        const toolbar = document.querySelector('.titlebar-right .action-toolbar-container');
        const windowControls = document.querySelector('.window-controls-container');
        
        if (!toolbar && !windowControls) return;
        
        // Crear el botón
        const btn = document.createElement('div');
        btn.id = 'labdev-ai-btn';
        btn.className = 'action-item';
        btn.style.cssText = 'display:flex;align-items:center;justify-content:center;width:46px;height:100%;cursor:pointer;color:#ff00ff;font-size:18px;';
        btn.innerHTML = '✨';
        btn.title = 'LabDev AI';
        
        // Evento click
        btn.onclick = () => {
            const event = new KeyboardEvent('keydown', {
                key: 'l',
                code: 'KeyL',
                ctrlKey: true,
                shiftKey: true,
                bubbles: true
            });
            document.dispatchEvent(event);
        };
        
        // Insertar
        if (toolbar) {
            toolbar.appendChild(btn);
        } else if (windowControls && windowControls.parentElement) {
            windowControls.parentElement.insertBefore(btn, windowControls);
        }
    }
    
    // Ejecutar cuando el DOM esté listo
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', addAIButton);
    } else {
        addAIButton();
    }
    
    // Reintentar cada 2 segundos por si el DOM cambia
    setInterval(addAIButton, 2000);
})();
```

## Ejecución del script

```powershell
cd LabDEV/scripts
.\agregar-boton-ai-definitivo.ps1
```
