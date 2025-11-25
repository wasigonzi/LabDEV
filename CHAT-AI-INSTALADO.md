# 💜 Chat con IA - Instalado en LabDev

## ✅ Configuración Completada

El chat con IA está instalado y configurado para abrirse en el **panel lateral derecho** como Kiro.

## 🚀 Cómo Usar

### Abrir el Chat

**Opción 1: Atajo de teclado (Recomendado)**
```
Ctrl + Shift + L
```

**Opción 2: Paleta de comandos**
1. Presiona `Ctrl+Shift+P`
2. Escribe "LabDev: Chat con IA"
3. Presiona Enter

**Opción 3: Click derecho en código**
1. Selecciona código
2. Click derecho
3. "LabDev: Explicar código seleccionado"

### Primera Vez - Configurar API Key

1. **Obtén tu API Key GRATIS:**
   - Ve a: https://huggingface.co/settings/tokens
   - Crea una cuenta (gratis)
   - Click en "New token"
   - Tipo: Read
   - Copia el token (empieza con `hf_...`)

2. **Configura en LabDev:**
   - File → Preferences → Settings
   - Busca: "LabDev AI"
   - En "Api Key" pega tu token
   - Guarda (Ctrl+S)

## 💬 Interfaz del Chat

El chat se abre en el **lado derecho** con:

- **Header fucsia** con título "💜 LabDev AI"
- **Área de mensajes** con scroll
- **Input de texto** en la parte inferior
- **Botón "Enviar"** fucsia
- **Colores fucsia** (#ff00ff) en toda la interfaz

## 🎯 Ejemplos de Uso

### Preguntar algo
```
Tú: ¿Cómo crear una API REST en Node.js?
IA: [Respuesta detallada]
```

### Explicar código
1. Selecciona código en el editor
2. `Ctrl+Shift+L` o click derecho → "Explicar código"
3. El chat se abre con tu código

### Debugging
```
Tú: Este código da error "undefined is not a function"
IA: [Análisis del error y solución]
```

### Generar código
```
Tú: Crea una función para validar emails
IA: [Código generado]
```

## ⚙️ Configuración

### Cambiar modelo de IA

En Settings → LabDev AI → Model:
- `mistralai/Mistral-7B-Instruct-v0.2` (predeterminado)
- `meta-llama/Llama-2-7b-chat-hf`
- `HuggingFaceH4/zephyr-7b-beta`
- `microsoft/phi-2`

### Atajos de teclado

- `Ctrl+Shift+L` - Abrir chat
- `Ctrl+Shift+P` - Paleta de comandos
- `Enter` - Enviar mensaje en el chat

## 🎨 Personalización

Los colores fucsia están en:
```
LabDev-Editor\resources\app\extensions\labdev-ai-assistant\extension.js
```

Busca `#ff00ff` para cambiar el color.

## 🔒 Privacidad

- Los mensajes se envían a HuggingFace
- No se almacenan permanentemente
- API key se guarda localmente en tu PC
- Sin telemetría

## 📊 Límites Gratuitos

- ~1000 requests por día
- Si llegas al límite, espera 24 horas
- Para más: HuggingFace Pro ($9/mes)

## 🆘 Solución de Problemas

### El chat no se abre
**Solución:** Reinicia LabDev completamente

### "Error: API key no configurada"
**Solución:** Configura tu API key en Settings

### "Error: Rate limit"
**Solución:** Has alcanzado el límite diario, espera 24 horas

### El chat se ve en blanco
**Solución:** 
1. Cierra el panel
2. Presiona `Ctrl+Shift+L` de nuevo
3. Si persiste, reinicia LabDev

## 📝 Comandos Disponibles

| Comando | Atajo | Descripción |
|---------|-------|-------------|
| LabDev: Chat con IA | `Ctrl+Shift+L` | Abre el chat |
| LabDev: Explicar código | - | Explica código seleccionado |
| LabDev: Corregir código | - | Corrige errores |
| LabDev: Preguntar a la IA | - | Pregunta rápida |

## 🎉 ¡Listo!

Tu chat con IA está configurado y listo para usar.

**Presiona `Ctrl+Shift+L` para abrir el chat ahora mismo.**

---

**Hecho con 💜 para LabDev**
