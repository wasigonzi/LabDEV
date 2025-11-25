# 🤖 Guía: LabDev AI Assistant

## ¿Qué es?

Una extensión para LabDev que te permite chatear con IA usando modelos **GRATUITOS** de HuggingFace.

## 🎯 Características

- 💬 Chat con IA integrado
- 🔍 Explicar código seleccionado
- 🔧 Corregir errores automáticamente
- 💡 Responder preguntas de programación
- 💜 Interfaz con colores fucsia de LabDev
- 🆓 **100% GRATIS** (con límites razonables)

## 📦 Instalación Rápida

### Paso 1: Ejecutar script de instalación

```powershell
cd C:\Users\sylex\LabDEV\LabDEV
.\instalar-ai-assistant.ps1
```

### Paso 2: Obtener API Key GRATIS

1. Ve a **https://huggingface.co/**
2. Crea una cuenta (gratis, solo email)
3. Ve a tu perfil → **Settings**
4. Click en **Access Tokens**
5. Click **New token**
   - Name: "LabDev"
   - Type: **Read**
6. Copia el token (empieza con `hf_...`)

### Paso 3: Instalar en LabDev

1. Abre **LabDev**
2. Presiona `Ctrl+Shift+P`
3. Escribe: **"Extensions: Install from VSIX"**
4. Selecciona el archivo `.vsix` generado
5. Click **Install**
6. Reinicia LabDev

### Paso 4: Configurar API Key

1. En LabDev: **File → Preferences → Settings**
2. Busca: **"LabDev AI"**
3. En **"Labdev-ai: Api Key"** pega tu token
4. Guarda (Ctrl+S)

## 🚀 Uso

### Abrir el Chat

**Opción 1:**
- Presiona `Ctrl+Shift+P`
- Escribe "LabDev: Abrir Chat con IA"

**Opción 2:**
- Click en el icono 🤖 en la barra lateral izquierda

### Ejemplos de Uso

#### 1. Preguntar algo
```
Tú: ¿Cómo crear una API REST en Node.js?
IA: Para crear una API REST en Node.js...
```

#### 2. Explicar código
```
1. Selecciona código en el editor
2. Click derecho
3. "LabDev: Explicar código seleccionado"
```

#### 3. Corregir errores
```
1. Selecciona código con error
2. Click derecho
3. "LabDev: Corregir código"
```

#### 4. Generar código
```
Tú: Crea una función para validar emails
IA: function validateEmail(email) { ... }
```

## 🤖 Modelos Disponibles

Por defecto usa **Mistral-7B** (recomendado), pero puedes cambiar en Settings:

- **mistralai/Mistral-7B-Instruct-v0.2** ⭐ Recomendado
- **meta-llama/Llama-2-7b-chat-hf** - Bueno para conversación
- **HuggingFaceH4/zephyr-7b-beta** - Rápido
- **microsoft/phi-2** - Ligero

## 💡 Tips

### Mejores Prácticas

1. **Sé específico** en tus preguntas
   - ❌ "Ayuda con mi código"
   - ✅ "¿Cómo ordenar un array de objetos por fecha en JavaScript?"

2. **Proporciona contexto**
   - ❌ "No funciona"
   - ✅ "Este código da error 'undefined is not a function' en la línea 10"

3. **Usa comandos de contexto**
   - Selecciona código antes de pedir explicación
   - Incluye el error completo al pedir ayuda

### Atajos de Teclado

- `Ctrl+Shift+P` → Abrir comandos
- `Ctrl+K Ctrl+I` → Explicar código (configurable)
- `Enter` → Enviar mensaje en chat
- `Shift+Enter` → Nueva línea en chat

## 🔒 Privacidad y Límites

### Privacidad
- ✅ Tu código se envía a HuggingFace (empresa confiable)
- ✅ No se almacena permanentemente
- ✅ API key se guarda solo en tu PC

### Límites Gratuitos
- ~1000 requests por día
- Si llegas al límite, espera 24 horas
- Para más: Upgrade a HuggingFace Pro ($9/mes)

## 🆘 Solución de Problemas

### "Error: API key no configurada"
**Solución:** Configura tu API key en Settings → LabDev AI

### "Error: Rate limit exceeded"
**Solución:** Has alcanzado el límite diario. Espera 24 horas o upgrade tu cuenta.

### "Error: Model not found"
**Solución:** El modelo no está disponible. Cambia a otro en Settings.

### La extensión no aparece
**Solución:** 
1. Verifica que instalaste el .vsix
2. Reinicia LabDev
3. Revisa Extensions → Installed

### El chat no responde
**Solución:**
1. Verifica tu conexión a internet
2. Verifica que la API key sea correcta
3. Revisa la consola (Help → Toggle Developer Tools)

## 📊 Comparación con Otras IAs

| Característica | LabDev AI | GitHub Copilot | ChatGPT |
|----------------|-----------|----------------|---------|
| Precio | **GRATIS** | $10/mes | $20/mes |
| Integrado | ✅ | ✅ | ❌ |
| Chat | ✅ | ❌ | ✅ |
| Código | ✅ | ✅ | ✅ |
| Offline | ❌ | ❌ | ❌ |

## 🔄 Actualizar

Para actualizar a una nueva versión:

```powershell
cd C:\Users\sylex\LabDEV\LabDEV\labdev-ai-assistant
git pull  # Si está en git
npm update
vsce package
```

Luego reinstala el .vsix en LabDev.

## 📚 Recursos

- **HuggingFace:** https://huggingface.co/
- **Documentación API:** https://huggingface.co/docs/api-inference
- **Modelos:** https://huggingface.co/models
- **Soporte:** https://github.com/wasigonzi/LabDEV/issues

## 🎨 Personalización

### Cambiar colores

Edita `extension.js` y busca `#ff00ff` para cambiar el fucsia.

### Agregar comandos

Edita `package.json` en la sección `contributes.commands`.

### Cambiar modelo por defecto

En Settings → LabDev AI → Model

## 💬 Ejemplos de Conversación

### Debugging
```
Tú: Este código da "Cannot read property 'map' of undefined"
IA: El error indica que estás intentando usar .map() en una 
    variable que es undefined. Verifica que la variable esté 
    inicializada antes de usar .map()...
```

### Aprendizaje
```
Tú: ¿Qué es async/await en JavaScript?
IA: async/await es una forma de escribir código asíncrono 
    de manera más legible. async marca una función como 
    asíncrona, y await pausa la ejecución hasta que una 
    promesa se resuelva...
```

### Generación de código
```
Tú: Crea una función que convierta Celsius a Fahrenheit
IA: function celsiusToFahrenheit(celsius) {
      return (celsius * 9/5) + 32;
    }
```

---

**¡Disfruta tu asistente de IA en LabDev!** 💜🤖
