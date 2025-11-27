# LabDev Editor

Editor de código personalizado basado en VSCodium con tema fucsia y asistente AI integrado.

## 🚀 Inicio Rápido

```powershell
# Ejecutar el editor
..\LabDev-Editor\LabDev.exe

# O navega a la carpeta LabDev-Editor y haz doble clic en LabDev.exe
```

## ✨ Características

- ✅ Editor basado en VSCodium (sin telemetría)
- ✅ Tema fucsia personalizado "LabDev Dark"
- ✅ Chat AI integrado con modelos gratuitos de HuggingFace
- ✅ Portable - no requiere instalación
- ✅ Compatible con extensiones de Open VSX

## 🎨 Tema LabDev Dark

Colores principales:
- **Fucsia**: `#ff00ff` - Keywords, cursores, acentos
- **Fondo**: `#1e1e1e` - Editor y paneles
- **Texto**: `#d4d4d4` - Código

Cambiar tema: `Ctrl+K` → `Ctrl+T` → "LabDev Dark"

## 🤖 Chat AI

Abrir chat: `Ctrl+Shift+L`

Modelos disponibles:
- Qwen 2.5 72B (principal)
- Llama 3.3 70B
- Mistral Nemo

Configurar API Key: Haz clic en ⚙️ en el chat

## 📁 Estructura del Proyecto

```
LabDEV/
├── extension/              # Código fuente de la extensión AI
│   └── labdev-ai-complete/
├── scripts/                # Scripts de utilidad
│   ├── crear-portable.ps1
│   └── instalar-extension.ps1
├── docs/                   # Documentación
│   ├── README.md
│   ├── TEMA.md
│   └── AI-ASSISTANT.md
└── theme/                  # Archivos del tema
    └── labdev-theme.json

LabDev-Editor/              # Editor listo para usar
├── LabDev.exe
└── resources/
    └── app/
        └── extensions/
            └── labdev-ai-complete/
```

## 📦 Distribución

```powershell
cd LabDEV\scripts
.\crear-portable.ps1
```

Esto crea `dist\LabDev-Portable-v1.0.zip`

## 📝 Licencia

MIT License - Basado en VSCodium y VSCode
