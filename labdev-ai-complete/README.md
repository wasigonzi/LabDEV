# LabDev AI Complete

Asistente de IA completo para LabDev Editor, inspirado en Kiro.

## Características

✅ **Chat conversacional con IA**
- Respuestas en tiempo real usando HuggingFace
- Modelo Mistral-7B-Instruct
- Historial de conversación

✅ **Acceso a archivos del proyecto**
- Leer archivos
- Crear nuevos archivos
- Modificar archivos existentes
- Listar archivos del workspace

✅ **Ejecución de comandos**
- Ejecutar comandos en terminal integrada
- Ver output en tiempo real

✅ **Integración con el editor**
- Explicar código seleccionado
- Acceso desde menú contextual
- Atajo de teclado: Ctrl+Shift+L

## Instalación

1. Instalar dependencias:
```bash
cd labdev-ai-complete
npm install
```

2. Empaquetar extensión:
```bash
npx @vscode/vsce package --allow-missing-repository
```

3. Instalar en LabDev:
```bash
..\LabDev-Editor\LabDev.exe --install-extension labdev-ai-complete-1.0.0.vsix
```

## Configuración

1. Abre LabDev Editor
2. Ve a File → Preferences → Settings
3. Busca "LabDev AI"
4. Configura tu API Key de HuggingFace

O usa el botón ⚙️ en el panel del chat.

## Uso

### Abrir el chat
- Haz clic en el icono de LabDev AI en la barra de actividades
- O presiona Ctrl+Shift+L

### Comandos disponibles
- Pregunta cualquier cosa al AI
- Pide que lea archivos: "Lee el archivo src/index.js"
- Pide que cree archivos: "Crea un archivo test.js con..."
- Pide que ejecute comandos: "Ejecuta npm install"

## API Key

Obtén tu API Key gratuita de HuggingFace:
https://huggingface.co/settings/tokens

## Licencia

MIT
