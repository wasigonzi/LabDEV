# LabDev Editor

**Tu editor de código personalizado basado en VSCodium**

![Version](https://img.shields.io/badge/version-1.0-blue)
![Based on](https://img.shields.io/badge/based%20on-VSCodium%201.106-green)

## 🚀 Inicio Rápido

### Ejecutar LabDev

```powershell
C:\Users\sylex\LabDEV\LabDev-Editor\LabDev.exe
```

O navega a la carpeta `LabDev-Editor` y haz doble clic en `LabDev.exe`

### Crear versión portable para distribuir

```powershell
cd C:\Users\sylex\LabDEV\LabDEV
.\crear-instalador-portable.ps1
```

Esto creará `LabDev-Portable-v1.0.zip` listo para distribuir.

## 📁 Estructura del Proyecto

```
LabDEV/
├── LabDev-Editor/          # Editor completo listo para usar
│   ├── LabDev.exe          # Ejecutable principal
│   └── resources/          # Recursos y configuración
├── rebrand-to-labdev.ps1   # Script de personalización
├── crear-instalador-portable.ps1  # Script para crear ZIP
└── LABDEV-README.md        # Documentación completa
```

## ✨ Características

- ✅ Editor completo basado en VSCodium
- ✅ Sin telemetría de Microsoft
- ✅ Compatible con extensiones de Open VSX
- ✅ Configuración independiente (carpeta `.labdev`)
- ✅ **Tema personalizado con colores fucsia** 💜
- ✅ **AI Assistant integrado** 🤖 (modelos gratuitos de HuggingFace)
- ✅ Totalmente personalizable
- ✅ Portable - no requiere instalación

## 🎨 Tema LabDev Dark

LabDev incluye un tema personalizado con **colores fucsia** inspirado en Kiro.

### Activar el tema

El tema se activa automáticamente. Si necesitas cambiarlo manualmente:

1. Presiona `Ctrl+K` luego `Ctrl+T`
2. Selecciona **"LabDev Dark"**

### Colores principales

- **Fucsia**: `#ff00ff` - Keywords, cursores, acentos
- **Fondo oscuro**: `#1e1e1e` - Editor y paneles
- **Texto**: `#d4d4d4` - Código

Ver documentación completa: [TEMA-LABDEV.md](TEMA-LABDEV.md)

## 🤖 AI Assistant (Opcional)

LabDev incluye una extensión de chat con IA usando modelos **GRATUITOS** de HuggingFace.

### Instalar AI Assistant

```powershell
cd C:\Users\sylex\LabDEV\LabDEV
.\instalar-ai-assistant.ps1
```

### Características

- 💬 Chat con IA integrado
- 🔍 Explicar código seleccionado
- 🔧 Corregir errores automáticamente
- 💡 Responder preguntas de programación
- 🆓 **100% GRATIS** (con límites razonables)

Ver guía completa: [AI-ASSISTANT-GUIA.md](AI-ASSISTANT-GUIA.md)

## 🎨 Personalización Adicional

### Cambiar el icono

Reemplaza el archivo:
```
LabDev-Editor\resources\app\resources\win32\code.ico
```

### Modificar el tema

Edita:
```
LabDev-Editor\resources\app\extensions\theme-defaults\themes\labdev-dark-color-theme.json
```

### Agregar extensiones por defecto

Coloca las extensiones en:
```
LabDev-Editor\resources\app\extensions\
```

## 📦 Distribución

### Opción 1: ZIP Portable (Recomendado)

Ejecuta `crear-instalador-portable.ps1` y distribuye el ZIP generado.

### Opción 2: Crear instalador con Inno Setup

1. Descarga [Inno Setup](https://jrsoftware.org/isdl.php)
2. Crea un script `.iss` apuntando a `LabDev-Editor`
3. Compila el instalador

### Opción 3: Subir a GitHub Releases

```bash
git tag v1.0.0
git push origin v1.0.0
```

Luego sube el ZIP en GitHub Releases.

## 🔧 Desarrollo

Si quieres modificar el código fuente de VSCode:

1. Clona el repositorio original de VSCodium
2. Aplica tus cambios
3. Compila con `npm run compile`
4. Usa el script `rebrand-to-labdev.ps1` para aplicar el branding

## 📝 Licencia

Este proyecto está basado en VSCodium, que es un fork de VSCode.

- VSCode: [MIT License](https://github.com/microsoft/vscode/blob/main/LICENSE.txt)
- VSCodium: [MIT License](https://github.com/VSCodium/vscodium/blob/master/LICENSE)
- LabDev: MIT License

## 🆘 Soporte

Para reportar problemas o sugerencias:
- Issues: https://github.com/wasigonzi/LabDEV/issues
- Discussions: https://github.com/wasigonzi/LabDEV/discussions

## 🙏 Agradecimientos

- [VSCodium](https://github.com/VSCodium/vscodium) - Por crear una versión libre de telemetría de VSCode
- [Microsoft VSCode](https://github.com/microsoft/vscode) - Por el editor base

---

**Hecho con ❤️ por wasigonzi**
