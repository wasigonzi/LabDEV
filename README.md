# LabDev Editor

Editor de código personalizado basado en VSCodium con tema fucsia y asistente AI integrado.

![Version](https://img.shields.io/badge/version-1.0-blue)
![Based on](https://img.shields.io/badge/based%20on-VSCodium%201.106-green)

## 🚀 Inicio Rápido

```powershell
# Ejecutar el editor
..\LabDev-Editor\LabDev.exe
```

## 📁 Estructura del Proyecto

```
LabDEV/                     # Repositorio de desarrollo
├── extension/              # Código fuente de la extensión AI
│   └── labdev-ai-complete/
│       ├── extension.js
│       ├── webview.js
│       ├── package.json
│       └── resources/
├── scripts/                # Scripts de utilidad
│   ├── crear-portable.ps1
│   └── instalar-extension.ps1
├── docs/                   # Documentación
│   ├── README.md
│   ├── TEMA.md
│   └── AI-ASSISTANT.md
├── theme/                  # Archivos del tema
│   └── labdev-theme.json
├── README.md
├── LICENSE
└── CODE_OF_CONDUCT.md

LabDev-Editor/              # Editor listo para usar
├── LabDev.exe
└── resources/app/extensions/labdev-ai-complete/
```

## ✨ Características

- ✅ Editor basado en VSCodium (sin telemetría)
- ✅ Tema fucsia personalizado "LabDev Dark"
- ✅ Chat AI integrado con modelos gratuitos de HuggingFace
- ✅ Portable - no requiere instalación

## 🎨 Tema

Colores principales:
- **Fucsia**: `#ff00ff` - Keywords, cursores, acentos
- **Fondo**: `#1e1e1e` - Editor y paneles

Cambiar tema: `Ctrl+K` → `Ctrl+T` → "LabDev Dark"

## 🤖 Chat AI

Abrir chat: `Ctrl+Shift+L`

Modelos disponibles:
- Qwen 2.5 72B
- Llama 3.3 70B
- Mistral Nemo

Ver documentación: [docs/AI-ASSISTANT.md](docs/AI-ASSISTANT.md)

## 📦 Distribución

```powershell
cd scripts
.\crear-portable.ps1
```

Esto crea `dist\LabDev-Portable-v1.0.zip`

## 📝 Licencia

MIT License - Basado en VSCodium y VSCode

---

**Hecho con ❤️ por wasigonzi**
