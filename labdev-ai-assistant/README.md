# 💜 LabDev AI Assistant

Extensión de chat con IA para LabDev usando modelos gratuitos de HuggingFace.

## 🚀 Características

- ✅ Chat con IA integrado en LabDev
- ✅ Modelos gratuitos de HuggingFace
- ✅ Explicar código seleccionado
- ✅ Corregir errores en código
- ✅ Responder preguntas de programación
- ✅ Interfaz con colores fucsia de LabDev

## 📦 Instalación

### 1. Obtener API Key de HuggingFace (GRATIS)

1. Ve a https://huggingface.co/
2. Crea una cuenta gratuita
3. Ve a Settings → Access Tokens
4. Crea un nuevo token (Read access es suficiente)
5. Copia el token

### 2. Instalar la extensión

```powershell
# Desde el directorio labdev-ai-assistant
npm install
```

### 3. Empaquetar la extensión

```powershell
npm install -g @vscode/vsce
vsce package
```

Esto creará un archivo `.vsix`

### 4. Instalar en LabDev

1. Abre LabDev
2. Presiona `Ctrl+Shift+P`
3. Escribe "Extensions: Install from VSIX"
4. Selecciona el archivo `labdev-ai-assistant-1.0.0.vsix`

### 5. Configurar API Key

1. En LabDev: File → Preferences → Settings
2. Busca "LabDev AI"
3. Pega tu API key de HuggingFace

## 🎯 Uso

### Abrir Chat

- Presiona `Ctrl+Shift+P` → "LabDev: Abrir Chat con IA"
- O haz clic en el icono de robot en la barra lateral

### Explicar Código

1. Selecciona código
2. Click derecho → "LabDev: Explicar código seleccionado"

### Corregir Código

1. Selecciona código con errores
2. Click derecho → "LabDev: Corregir código"

### Preguntar

- `Ctrl+Shift+P` → "LabDev: Preguntar a la IA"

## 🤖 Modelos Disponibles

La extensión usa modelos gratuitos de HuggingFace:

- **Mistral-7B** (predeterminado) - Rápido y preciso
- **Llama-2-7b** - Bueno para conversación
- **Zephyr-7b** - Optimizado para instrucciones
- **Phi-2** - Ligero y rápido

## ⚙️ Configuración

```json
{
  "labdev-ai.model": "mistralai/Mistral-7B-Instruct-v0.2",
  "labdev-ai.apiKey": "tu_api_key_aqui"
}
```

## 🎨 Interfaz

La extensión usa los colores fucsia de LabDev:
- Bordes: `#ff00ff`
- Botones: `#ff00ff`
- Acentos: `#ff00ff`

## 📝 Ejemplos de Uso

### Explicar código
```
Selecciona: function fibonacci(n) { ... }
LabDev AI: "Esta función calcula..."
```

### Generar código
```
Tú: "Crea una función para validar email"
LabDev AI: "function validateEmail(email) { ... }"
```

### Debugging
```
Tú: "¿Por qué este código da error?"
LabDev AI: "El error es porque..."
```

## 🔒 Privacidad

- Los datos se envían a HuggingFace
- No se almacena historial permanente
- API key se guarda localmente en LabDev

## 🆘 Solución de Problemas

### "Error: API key no configurada"
→ Configura tu API key en Settings

### "Error: Rate limit"
→ Espera unos minutos, HuggingFace tiene límites gratuitos

### "Error: Model not found"
→ Verifica que el modelo esté disponible en HuggingFace

## 📚 Recursos

- HuggingFace: https://huggingface.co/
- Documentación API: https://huggingface.co/docs/api-inference
- Modelos disponibles: https://huggingface.co/models

## 🔄 Actualizar

```powershell
cd labdev-ai-assistant
npm update
vsce package
```

Luego reinstala el `.vsix` en LabDev

## 📄 Licencia

MIT License - Libre para usar y modificar

---

**Hecho con 💜 para LabDev**
