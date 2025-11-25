# 💬 Cómo Usar el Chat AI en LabDev

## 🎯 Paso a Paso Visual

### PASO 1: Abrir LabDev
```
Ejecuta: .\iniciar-labdev-con-ai.ps1
```
O abre manualmente: `LabDev-Editor\LabDev.exe`

---

### PASO 2: Buscar el Icono Fucsia

En la **barra lateral izquierda**, busca este icono:

```
┌─────┐
│  💬 │  ← Icono FUCSIA (color magenta/rosa)
└─────┘
```

**Ubicación**: Barra de actividades (izquierda)  
**Color**: Fucsia/Magenta  
**Nombre**: LabDev AI

---

### PASO 3: Abrir el Chat

**Opción A**: Haz clic en el icono fucsia

**Opción B**: Presiona `Ctrl+Shift+L`

Se abrirá un panel como este:

```
┌─────────────────────────────────────┐
│ 💬 Let's build              ⚙️     │ ← Botón de configuración
│ Plan, search, or build anything     │
├─────────────────────────────────────┤
│                                     │
│ 💜 Vibe                             │
│ Chat first, then build. Explore     │
│ ideas and iterate as you discover   │
│ needs.                              │
│                                     │
│ Great for:                          │
│ • Rapid exploration and testing     │
│ • Building when requirements are    │
│   unclear                           │
│ • Implementing a task               │
│                                     │
├─────────────────────────────────────┤
│ # 😊 Ask a question... ↑           │ ← Campo de entrada
└─────────────────────────────────────┘
```

---

### PASO 4: Configurar API Key (PRIMERA VEZ)

#### 4.1 Obtener API Key

1. Ve a: **https://huggingface.co/settings/tokens**
2. Crea una cuenta (gratis) si no tienes
3. Haz clic en **"New token"**
4. Configuración:
   - **Name**: `LabDev AI`
   - **Type**: `Read`
5. Haz clic en **"Generate token"**
6. **COPIA** el token (empieza con `hf_...`)

```
Ejemplo de token:
hf_AbCdEfGhIjKlMnOpQrStUvWxYz1234567890
```

#### 4.2 Configurar en LabDev

1. En el chat, haz clic en el botón **⚙️** (arriba derecha)
2. Se abrirá un modal:

```
┌─────────────────────────────────────┐
│ ⚙️ Configuración                    │
│                                     │
│ API Key de HuggingFace:             │
│ ┌─────────────────────────────────┐ │
│ │ hf_...                          │ │ ← Pega aquí
│ └─────────────────────────────────┘ │
│                                     │
│ Obtén tu API Key gratis en:         │
│ huggingface.co/settings/tokens      │
│                                     │
│         [Cancelar]  [Guardar]       │
└─────────────────────────────────────┘
```

3. Pega tu token
4. Haz clic en **"Guardar"**
5. Verás: `✓ Configuración guardada`

---

### PASO 5: Empezar a Chatear

Ahora puedes escribir en el campo de entrada:

#### Ejemplo 1: Saludo
```
Tú: Hola, ¿cómo estás?

AI: 💜 Pensando...

AI: ¡Hola! Estoy bien, gracias. Soy tu asistente 
AI en LabDev. ¿En qué puedo ayudarte hoy?
```

#### Ejemplo 2: Leer Archivo
```
Tú: Lee el archivo package.json

AI: 💜 Pensando...

AI: El archivo package.json contiene:
{
  "name": "labdev-ai-complete",
  "version": "1.0.0",
  ...
}
```

#### Ejemplo 3: Listar Archivos
```
Tú: Lista los archivos del proyecto

AI: 💜 Pensando...

AI: Archivos encontrados:
- extension.js
- webview.js
- package.json
...
```

---

## 🎨 Elementos de la Interfaz

### Barra Superior
```
┌─────────────────────────────────────┐
│ 💬 Let's build              ⚙️     │
│ Plan, search, or build anything     │
└─────────────────────────────────────┘
```

- **💬 Let's build**: Título del chat
- **⚙️**: Botón de configuración (API Key)

### Área de Mensajes
```
┌─────────────────────────────────────┐
│ [Usuario] Tu mensaje aquí           │ ← Fondo gris oscuro
│                                     │
│ [AI] Respuesta de la IA             │ ← Fondo negro
│                                     │
│ [Usuario] Otro mensaje              │
│                                     │
│ [AI] Otra respuesta                 │
└─────────────────────────────────────┘
```

### Campo de Entrada
```
┌─────────────────────────────────────┐
│ # 😊 Ask a question... ↑           │
└─────────────────────────────────────┘
```

- **#**: Botón de contexto (futuro)
- **😊**: Botón de emojis (futuro)
- **Campo de texto**: Escribe aquí tu mensaje
- **↑**: Botón de enviar

---

## 💡 Comandos Útiles

### Comandos Básicos
```
Hola
¿Cómo estás?
Ayúdame con...
Explícame...
```

### Comandos de Archivos
```
Lee el archivo [nombre]
Muestra el contenido de [archivo]
Lista los archivos
Lista archivos .js
```

### Comandos de Código
```
Explícame este código
¿Qué hace esta función?
Ayúdame a crear una función para...
¿Cómo puedo...?
```

---

## ⌨️ Atajos de Teclado

| Atajo | Acción |
|-------|--------|
| `Ctrl+Shift+L` | Abrir/cerrar chat |
| `Enter` | Enviar mensaje |
| `Shift+Enter` | Nueva línea |

---

## 🎯 Flujo de Trabajo Típico

### 1. Exploración
```
Tú: Lista los archivos del proyecto
AI: [Lista de archivos]

Tú: Lee el archivo extension.js
AI: [Contenido del archivo]
```

### 2. Análisis
```
Tú: Explícame qué hace este código
AI: [Explicación detallada]

Tú: ¿Cómo puedo mejorarlo?
AI: [Sugerencias]
```

### 3. Desarrollo
```
Tú: Ayúdame a crear una función para...
AI: [Código sugerido]

Tú: ¿Cómo la uso?
AI: [Ejemplos de uso]
```

---

## 🐛 Problemas Comunes

### "Por favor configura tu API Key"
**Solución**: Haz clic en ⚙️ y configura tu token de HuggingFace

### "El modelo está cargando"
**Solución**: Espera 20 segundos e intenta de nuevo (primera vez)

### "Error de conexión"
**Solución**: Verifica tu conexión a internet

### El icono no aparece
**Solución**: 
1. Cierra LabDev completamente
2. Ejecuta: `.\iniciar-labdev-con-ai.ps1`
3. Espera 10 segundos

---

## 📊 Estados del Chat

### Estado 1: Esperando
```
┌─────────────────────────────────────┐
│ # 😊 Ask a question... ↑           │
└─────────────────────────────────────┘
```
El chat está listo para recibir mensajes.

### Estado 2: Pensando
```
┌─────────────────────────────────────┐
│ [AI] 💜 Pensando...                 │
└─────────────────────────────────────┘
```
La IA está procesando tu mensaje.

### Estado 3: Respondiendo
```
┌─────────────────────────────────────┐
│ [AI] Aquí está mi respuesta...      │
└─────────────────────────────────────┘
```
La IA ha respondido.

---

## 🌟 Consejos Pro

### 1. Sé Específico
❌ "Ayúdame con código"  
✅ "Ayúdame a crear una función async que lea un archivo"

### 2. Usa Contexto
❌ "¿Qué hace esto?"  
✅ "Lee el archivo extension.js y explícame la función _callAI"

### 3. Divide Tareas
❌ "Crea una app completa"  
✅ "Ayúdame a crear la estructura básica de una app"

### 4. Itera
```
1. "Crea una función básica"
2. "Ahora agrégale manejo de errores"
3. "¿Cómo la puedo optimizar?"
```

---

## 🎉 ¡Listo para Usar!

Ahora que sabes cómo usar el chat AI:

1. ✅ Abre LabDev
2. ✅ Haz clic en el icono fucsia
3. ✅ Configura tu API Key
4. ✅ Empieza a chatear

**¡Disfruta de tu asistente AI!** 💜

---

## 📞 Ayuda Rápida

**¿No ves el icono?**  
→ Ejecuta: `.\iniciar-labdev-con-ai.ps1`

**¿No responde?**  
→ Verifica tu API Key en ⚙️

**¿Primera vez?**  
→ Lee: `GUIA-USO-RAPIDO.md`

**¿Problemas técnicos?**  
→ Ejecuta: `.\verificar-instalacion-completa.ps1`

---

**Versión**: 1.0.0  
**Última actualización**: 2024
