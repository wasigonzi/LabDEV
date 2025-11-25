# Botón AI Assistant en Barra de Título

## ✨ Descripción

Se ha agregado un **botón permanente** del AI Assistant en la barra de título superior de LabDev Editor, al lado del botón "Customize Layout".

## 🎯 Características

- **Icono fucsia con estrella** visible en la barra de título
- **Acceso rápido** con un solo clic
- **Hover effect** con fondo fucsia translúcido
- **Tooltip** que muestra "LabDev AI Assistant (Ctrl+Shift+L)"

## 📦 Instalación

### Opción 1: Script Automático
```powershell
cd LabDEV
.\instalar-boton-ai-completo.ps1
```

### Opción 2: Manual
1. Ejecutar `agregar-boton-ai-titlebar.ps1` para inyectar el botón
2. Instalar la extensión AI Assistant
3. Reiniciar LabDev Editor

## 🔧 Cómo Funciona

El script modifica el archivo `workbench.desktop.main.js` para:
1. Inyectar código JavaScript que crea el botón
2. Posicionar el botón en la barra de título
3. Conectar el botón con el comando `labdev-ai.openChat`

## 🎨 Personalización

El botón se puede personalizar editando el código inyectado en `agregar-boton-ai-titlebar.ps1`:

- **Tamaño**: Modificar `width` y `height` en `btn.style.cssText`
- **Color**: Cambiar el `fill` en el SVG
- **Posición**: Ajustar la lógica de `insertBefore`

## 🔄 Restaurar Original

Si deseas revertir los cambios:
```powershell
Copy-Item "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js.backup" "..\LabDev-Editor\resources\app\out\vs\workbench\workbench.desktop.main.js" -Force
```

## 📍 Ubicación del Botón

```
┌─────────────────────────────────────────────────┐
│ LabDev  File  Edit  ...  [✨AI] [⚙️Customize]  │ ← AQUÍ
├─────────────────────────────────────────────────┤
│                                                 │
│  Editor principal                               │
│                                                 │
└─────────────────────────────────────────────────┘
```

## ⌨️ Atajos de Teclado

- **Ctrl+Shift+L**: Abrir AI Assistant
- **Clic en el botón**: Abrir AI Assistant

## 🐛 Solución de Problemas

### El botón no aparece
1. Verifica que LabDev esté completamente cerrado antes de reiniciar
2. Ejecuta nuevamente `agregar-boton-ai-titlebar.ps1`
3. Verifica que la extensión esté instalada y habilitada

### El botón no responde
1. Verifica que la extensión AI Assistant esté activa
2. Usa Ctrl+Shift+L como alternativa
3. Revisa la consola de desarrollador (Help → Toggle Developer Tools)

## 📝 Notas Técnicas

- El código se inyecta al final de `workbench.desktop.main.js`
- Se crea un backup automático antes de modificar
- El botón se agrega mediante JavaScript en tiempo de ejecución
- Compatible con temas claros y oscuros
