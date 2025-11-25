# 🚀 LabDev AI Complete v2.0 - Nuevas Características

## ✨ Inspirado en OpenAI Codex

Esta versión incluye características avanzadas inspiradas en OpenAI Codex para una experiencia de desarrollo más potente.

---

## 🎯 1. Modos de Aprobación

### 💬 Modo Chat
**Solo conversación, sin acciones**

- Ideal para: Planificación, preguntas, exploración de ideas
- No ejecuta acciones en archivos
- No requiere aprobaciones
- Respuestas rápidas

**Ejemplo:**
```
Usuario: ¿Cómo puedo optimizar este algoritmo?
AI: [Explicación y sugerencias sin modificar archivos]
```

---

### 🤖 Modo Agent (Recomendado)
**Lee y edita archivos con tu aprobación**

- Puede leer archivos del proyecto
- Puede sugerir ediciones de código
- Requiere tu aprobación para aplicar cambios
- Preview de cambios antes de aplicar

**Ejemplo:**
```
Usuario: Lee @package.json y actualiza la versión a 2.0.0

AI: [Muestra el código con preview]
    📝 package.json
    [Código actualizado]
    [Rechazar] [Aplicar] ← Tú decides
```

---

### ⚡ Modo Full Access
**Acceso completo automático (usar con precaución)**

- Aplica cambios automáticamente
- No requiere aprobación
- Ideal para tareas repetitivas
- **⚠️ Usa con cuidado**

**Ejemplo:**
```
Usuario: Crea 5 archivos de prueba

AI: ✓ Creando archivos...
    ✓ test1.js creado
    ✓ test2.js creado
    ...
```

---

## 📎 2. Referencias de Archivos con @

### Sintaxis
Usa `@nombre-archivo.ext` para referenciar archivos en tus mensajes.

### Ejemplos

#### Ejemplo 1: Leer y Analizar
```
Usuario: Lee @extension.js y explícame la función _callAI

AI: La función _callAI en extension.js hace lo siguiente:
    1. Crea una petición HTTPS a HuggingFace
    2. Envía el prompt con parámetros
    3. Procesa la respuesta JSON
    ...
```

#### Ejemplo 2: Usar como Referencia
```
Usuario: Usa @webview.js como referencia para crear un nuevo componente

AI: Basándome en webview.js, aquí está el nuevo componente:
    [Código generado siguiendo el estilo de webview.js]
```

#### Ejemplo 3: Comparar Archivos
```
Usuario: Compara @extension.js con @webview.js y dime las diferencias

AI: Diferencias principales:
    - extension.js: Backend, maneja lógica
    - webview.js: Frontend, maneja UI
    ...
```

#### Ejemplo 4: Múltiples Referencias
```
Usuario: Usa @package.json y @README.md para crear un nuevo proyecto similar

AI: Basándome en ambos archivos, aquí está la estructura:
    [Estructura del proyecto]
```

### Ventajas
- ✅ Contexto preciso sin copiar/pegar
- ✅ Mensajes más cortos
- ✅ Respuestas más relevantes
- ✅ Ahorro de tiempo

---

## 🔍 3. Preview de Ediciones de Código

### Cómo Funciona

Cuando la IA sugiere cambios en archivos, verás un **preview** antes de aplicarlos:

```
┌─────────────────────────────────────┐
│ [AI] Aquí está el código actualizado│
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 📝 package.json                 │ │
│ │                    [Rechazar] [Aplicar] │
│ ├─────────────────────────────────┤ │
│ │ {                               │ │
│ │   "name": "labdev-ai-complete", │ │
│ │   "version": "2.0.0",           │ │
│ │   ...                           │ │
│ │ }                               │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

### Acciones Disponibles

#### Aplicar
- Aplica los cambios al archivo
- Abre el archivo editado automáticamente
- Muestra confirmación

#### Rechazar
- Descarta los cambios
- Elimina el preview
- No modifica el archivo

### Ejemplo Completo

```
Usuario: Actualiza @package.json a versión 2.0.0

AI: 💜 Pensando...

AI: He actualizado el archivo package.json:

    ┌─────────────────────────────────┐
    │ 📝 package.json                 │
    │                [Rechazar] [Aplicar] │
    ├─────────────────────────────────┤
    │ {                               │
    │   "name": "labdev-ai-complete", │
    │   "version": "2.0.0",           │
    │   "description": "..."          │
    │ }                               │
    └─────────────────────────────────┘

[Haces clic en "Aplicar"]

AI: ✓ Archivo actualizado: package.json
```

---

## 🎮 Flujo de Trabajo Completo

### Escenario 1: Exploración (Modo Chat)
```
1. Cambiar a modo 💬 Chat
2. "¿Qué arquitectura recomiendas para una API REST?"
3. [Conversación sin modificar archivos]
4. Planificar la implementación
```

### Escenario 2: Desarrollo (Modo Agent)
```
1. Cambiar a modo 🤖 Agent
2. "Lee @extension.js y agrega manejo de errores"
3. [AI muestra preview de cambios]
4. Revisar cambios
5. Hacer clic en "Aplicar"
6. ✓ Archivo actualizado
```

### Escenario 3: Automatización (Modo Full Access)
```
1. Cambiar a modo ⚡ Full Access
2. "Crea archivos de prueba para todos los módulos"
3. [AI crea archivos automáticamente]
4. ✓ Todos los archivos creados
```

---

## 📋 Comandos Útiles

### Con Referencias de Archivos
```
Lee @archivo.js
Explica @componente.tsx
Usa @config.json como referencia
Compara @file1.js con @file2.js
Actualiza @package.json
Optimiza @script.py
```

### Con Preview de Ediciones
```
Agrega una función a @utils.js
Refactoriza @legacy-code.js
Corrige los errores en @buggy.ts
Mejora el estilo de @component.css
```

### Combinados
```
Usa @template.js para crear @nuevo-modulo.js
Lee @config.json y actualiza @settings.js
Compara @v1.js con @v2.js y crea @v3.js
```

---

## ⚙️ Configuración

### Cambiar Modo por Defecto

El modo por defecto es **Agent**. Para cambiarlo:

1. Abre el chat AI
2. Haz clic en el modo deseado:
   - 💬 Chat
   - 🤖 Agent
   - ⚡ Full Access
3. El modo se mantiene durante la sesión

### Atajos de Teclado

| Atajo | Acción |
|-------|--------|
| `Ctrl+Shift+L` | Abrir chat AI |
| `Enter` | Enviar mensaje |
| `Shift+Enter` | Nueva línea |

---

## 🔒 Seguridad

### Modo Chat
- ✅ Totalmente seguro
- ✅ No modifica archivos
- ✅ Solo conversación

### Modo Agent
- ✅ Seguro con aprobación
- ⚠️ Revisa cambios antes de aplicar
- ✅ Control total sobre ediciones

### Modo Full Access
- ⚠️ Usar con precaución
- ⚠️ Aplica cambios automáticamente
- ⚠️ Solo para tareas confiables

---

## 💡 Consejos Pro

### 1. Usa Referencias Específicas
❌ "Lee el archivo de configuración"  
✅ "Lee @config.json"

### 2. Combina Modos
- Usa **Chat** para planificar
- Cambia a **Agent** para implementar
- Usa **Full Access** para tareas repetitivas

### 3. Revisa Previews
- Siempre revisa el código antes de aplicar
- Verifica que los cambios sean correctos
- Usa "Rechazar" si algo no está bien

### 4. Referencias Múltiples
```
Usa @style.css, @layout.html y @script.js para crear @new-page.html
```

---

## 🎯 Casos de Uso

### Caso 1: Refactorización
```
Usuario: Lee @legacy-code.js y refactorízalo usando ES6

AI: [Muestra código refactorizado con preview]
    📝 legacy-code.js
    [Código moderno con arrow functions, const/let, etc.]
    [Rechazar] [Aplicar]
```

### Caso 2: Documentación
```
Usuario: Lee @api.js y agrega JSDoc a todas las funciones

AI: [Muestra código con documentación]
    📝 api.js
    [Funciones con comentarios JSDoc completos]
    [Rechazar] [Aplicar]
```

### Caso 3: Testing
```
Usuario: Usa @calculator.js para crear @calculator.test.js

AI: [Genera archivo de pruebas]
    📝 calculator.test.js
    [Tests completos basados en calculator.js]
    [Rechazar] [Aplicar]
```

---

## 🐛 Solución de Problemas

### Las referencias @ no funcionan
**Solución**: Asegúrate de que el archivo existe en el proyecto

### Los previews no aparecen
**Solución**: Cambia a modo Agent o Full Access (no funciona en modo Chat)

### Los cambios no se aplican
**Solución**: Verifica que tienes permisos de escritura en el archivo

---

## 📊 Comparación con v1.0

| Característica | v1.0 | v2.0 |
|----------------|------|------|
| Chat básico | ✅ | ✅ |
| Leer archivos | ✅ | ✅ |
| Modos de aprobación | ❌ | ✅ |
| Referencias @ | ❌ | ✅ |
| Preview de ediciones | ❌ | ✅ |
| Edición de archivos | ❌ | ✅ |
| Control granular | ❌ | ✅ |

---

## 🎉 Resumen

### Lo Nuevo en v2.0

1. **3 Modos de Operación**
   - Chat, Agent, Full Access

2. **Referencias de Archivos**
   - Usa @archivo para contexto preciso

3. **Preview de Ediciones**
   - Ve y aprueba cambios antes de aplicar

### Beneficios

- ✅ Mayor control sobre las acciones
- ✅ Contexto más preciso con @
- ✅ Seguridad con previews
- ✅ Flujo de trabajo más eficiente
- ✅ Inspirado en OpenAI Codex

---

## 🚀 Empezar Ahora

1. Ejecuta: `.\actualizar-extension-v2.ps1`
2. Reinicia LabDev
3. Abre el chat (Ctrl+Shift+L)
4. Prueba: `Lee @package.json y explícamelo`

**¡Disfruta de las nuevas características!** 💜

---

**Versión**: 2.0.0  
**Fecha**: 2024  
**Inspirado en**: OpenAI Codex
