# 🚀 LabDev AI Complete v2.0

## Asistente AI Estilo Codex para LabDev Editor

Inspirado en **OpenAI Codex**, LabDev AI v2.0 trae características avanzadas de agente de código con control total sobre tus archivos.

---

## ✨ Características Principales

### 🎯 Modos de Aprobación
- **💬 Chat**: Solo conversación, sin modificar archivos
- **🤖 Agent**: Lee y edita archivos con tu aprobación (recomendado)
- **⚡ Full Access**: Acceso completo automático

### 📎 Referencias de Archivos
- Usa `@archivo.js` para referenciar archivos en tus mensajes
- Contexto automático del contenido
- Mensajes más cortos y precisos

### 🔍 Preview de Ediciones
- Ve los cambios antes de aplicarlos
- Botones Aplicar/Rechazar para cada edición
- Control total sobre modificaciones

---

## 🚀 Inicio Rápido

### 1. Instalar/Actualizar
```powershell
cd LabDEV
.\actualizar-extension-v2.ps1
```

### 2. Iniciar LabDev
```powershell
.\iniciar-labdev-con-ai.ps1
```

### 3. Abrir Chat
- Busca el **icono fucsia** en la barra lateral
- O presiona `Ctrl+Shift+L`

### 4. Configurar API Key
- Haz clic en **⚙️** (arriba derecha)
- Obtén tu API Key: https://huggingface.co/settings/tokens
- Pega y guarda

### 5. Empezar a Usar
```
Lee @package.json y explícamelo
```

---

## 💬 Ejemplos de Uso

### Modo Chat (Planificación)
```
[Selecciona modo 💬 Chat]

Usuario: ¿Cómo implemento autenticación JWT?

AI: Para implementar autenticación JWT necesitas:
    1. Instalar jsonwebtoken
    2. Crear middleware de verificación
    3. Generar tokens en login
    ...
```

### Modo Agent (Desarrollo)
```
[Selecciona modo 🤖 Agent]

Usuario: Lee @extension.js y agrega manejo de errores

AI: He agregado manejo de errores:

    📝 extension.js
    [Código con try-catch mejorado]
    [Rechazar] [Aplicar]

[Haces clic en Aplicar]

AI: ✓ Archivo actualizado: extension.js
```

### Referencias de Archivos
```
Usuario: Usa @webview.js para crear @nuevo-componente.js

AI: Basándome en webview.js, he creado:

    📝 nuevo-componente.js
    [Código del nuevo componente]
    [Rechazar] [Aplicar]
```

---

## 📚 Documentación

| Documento | Descripción |
|-----------|-------------|
| [ACTUALIZACION-V2-COMPLETADA.md](ACTUALIZACION-V2-COMPLETADA.md) | Estado de instalación y primeros pasos |
| [NUEVAS-CARACTERISTICAS-V2.md](NUEVAS-CARACTERISTICAS-V2.md) | Guía completa de características |
| [GUIA-VISUAL-V2.md](GUIA-VISUAL-V2.md) | Guía visual de la interfaz |
| [RESUMEN-EJECUTIVO.md](RESUMEN-EJECUTIVO.md) | Vista general rápida |
| [GUIA-USO-RAPIDO.md](GUIA-USO-RAPIDO.md) | Guía de inicio rápido |

---

## 🎯 Comandos Útiles

### Básicos
```
Hola, ¿qué puedes hacer?
Ayúdame con...
Explícame...
```

### Con Referencias
```
Lee @archivo.js
Explica @componente.tsx
Usa @config.json como referencia
Compara @file1.js con @file2.js
```

### Con Ediciones
```
Actualiza @package.json a versión 2.0.0
Agrega una función a @utils.js
Refactoriza @legacy-code.js
Corrige los errores en @buggy.ts
```

---

## 🔧 Scripts Disponibles

### Actualizar a v2.0
```powershell
.\actualizar-extension-v2.ps1
```

### Verificar Instalación
```powershell
.\verificar-instalacion-completa.ps1
```

### Iniciar LabDev
```powershell
.\iniciar-labdev-con-ai.ps1
```

---

## 🎨 Interfaz

```
┌─────────────────────────────────────────────────┐
│ 💬 Let's build                          ⚙️     │
│ Plan, search, or build anything                 │
├─────────────────────────────────────────────────┤
│ [💬 Chat] [🤖 Agent] [⚡ Full Access]          │
├─────────────────────────────────────────────────┤
│                                                 │
│ 💜 LabDev AI Agent                              │
│ Chat, code, and build with AI                   │
│                                                 │
│ Modos disponibles:                              │
│ • 💬 Chat - Solo conversación                   │
│ • 🤖 Agent - Lee/edita con aprobación           │
│ • ⚡ Full Access - Acceso completo              │
│                                                 │
│ Características:                                │
│ • Usa @archivo.js para referenciar             │
│ • Preview de cambios antes de aplicar          │
│ • Edición de código con un clic                │
│                                                 │
├─────────────────────────────────────────────────┤
│ # 😊 Ask a question... ↑                       │
└─────────────────────────────────────────────────┘
```

---

## 🔒 Seguridad

### Modo Chat
- ✅ 100% seguro
- ✅ No modifica archivos
- ✅ Solo conversación

### Modo Agent (Recomendado)
- ✅ Seguro con control
- ✅ Requiere aprobación
- ✅ Preview antes de aplicar

### Modo Full Access
- ⚠️ Usar con precaución
- ⚠️ Cambios automáticos
- ⚠️ Solo para tareas confiables

---

## 📊 Comparación de Versiones

| Característica | v1.0 | v2.0 |
|----------------|------|------|
| Chat básico | ✅ | ✅ |
| Leer archivos | ✅ | ✅ |
| Modos de aprobación | ❌ | ✅ |
| Referencias @ | ❌ | ✅ |
| Preview de ediciones | ❌ | ✅ |
| Editar archivos | ❌ | ✅ |
| Control granular | ❌ | ✅ |

---

## 💡 Consejos Pro

### 1. Usa el Modo Correcto
- **Chat**: Preguntas y planificación
- **Agent**: Desarrollo normal (recomendado)
- **Full Access**: Solo tareas repetitivas

### 2. Referencias Específicas
```
❌ "Lee el archivo de configuración"
✅ "Lee @config.json"
```

### 3. Revisa Previews
- Siempre revisa el código antes de aplicar
- Usa "Rechazar" si algo no está bien
- Puedes pedir modificaciones

### 4. Combina Características
```
[Modo Agent]
Usa @template.js y @config.json para crear @nuevo-modulo.js
```

---

## 🐛 Solución de Problemas

### El chat no muestra los nuevos botones
**Solución**: Reinicia LabDev completamente

### Las referencias @ no funcionan
**Solución**: Verifica que el archivo existe en el proyecto

### Los previews no aparecen
**Solución**: Asegúrate de estar en modo Agent o Full Access

### Error al aplicar ediciones
**Solución**: Verifica permisos de escritura en el archivo

---

## 🌟 Características Técnicas

### Backend (extension.js)
- Procesamiento de referencias @archivo
- Detección de ediciones de código
- Aplicación de cambios con preview
- Manejo de modos de aprobación

### Frontend (webview.js)
- Selector de modos interactivo
- Preview de ediciones con botones
- Interfaz responsive
- Animaciones suaves

### API
- HuggingFace Inference API
- Modelo: Mistral-7B-Instruct-v0.2
- Streaming de respuestas
- Manejo de errores robusto

---

## 🎉 Resumen

### ✅ Instalado
- LabDev AI Complete v2.0.0
- Tamaño: 630.06 KB
- 564 archivos incluidos

### ✅ Características
1. Modos de aprobación (Chat/Agent/Full Access)
2. Referencias de archivos con @
3. Preview de ediciones de código

### ✅ Listo para Usar
1. Reinicia LabDev
2. Abre el chat (Ctrl+Shift+L)
3. Prueba: `Lee @package.json`

---

## 🔗 Enlaces Útiles

- **API Key**: https://huggingface.co/settings/tokens
- **Modelo**: https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.2
- **Docs HuggingFace**: https://huggingface.co/docs/api-inference
- **Inspiración**: https://developers.openai.com/codex/ide

---

## 📞 Soporte

**Documentación Completa**: Ver archivos .md en la carpeta LabDEV

**Verificar Estado**: `.\verificar-instalacion-completa.ps1`

**Reinstalar**: `.\actualizar-extension-v2.ps1`

---

## 🎯 Próximos Pasos

1. ✅ Reinicia LabDev
2. ✅ Abre el chat (Ctrl+Shift+L)
3. ✅ Configura tu API Key
4. ✅ Prueba: `Lee @package.json`

**¡Disfruta de tu asistente AI estilo Codex!** 💜

---

**Versión**: 2.0.0  
**Fecha**: 2024  
**Inspirado en**: OpenAI Codex  
**Estado**: ✅ Instalado y Funcional  
**Licencia**: MIT
