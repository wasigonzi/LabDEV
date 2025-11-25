# LabDev Editor - Tu Editor Personalizado

## ✅ COMPLETADO

Has creado exitosamente **LabDev**, tu propio editor basado en VSCodium.

## 📁 Ubicación

Tu editor está en: `C:\Users\sylex\LabDEV\LabDev-Editor\`

## 🚀 Cómo ejecutar

```powershell
C:\Users\sylex\LabDEV\LabDev-Editor\LabDev.exe
```

O simplemente navega a la carpeta y haz doble clic en `LabDev.exe`

## 🎨 Cambios realizados

- ✅ Nombre cambiado a "LabDev"
- ✅ Ejecutable renombrado a `LabDev.exe`
- ✅ Identificadores internos actualizados
- ✅ URLs personalizadas apuntando a tu repositorio
- ✅ Configuración de datos en `.labdev` (no conflicta con VSCode/VSCodium)

## 📦 Crear instalador portable

Para distribuir LabDev, simplemente comprime la carpeta:

```powershell
Compress-Archive -Path "C:\Users\sylex\LabDEV\LabDev-Editor" -DestinationPath "C:\Users\sylex\LabDEV\LabDev-Portable.zip"
```

## 🎨 Personalización adicional

### Cambiar iconos

Los iconos están en:
- `C:\Users\sylex\LabDEV\LabDev-Editor\resources\app\resources\win32\code.ico`

Reemplaza este archivo con tu propio icono .ico

### Cambiar colores del tema

Edita: `C:\Users\sylex\LabDEV\LabDev-Editor\resources\app\extensions\theme-defaults\themes\`

### Agregar extensiones por defecto

Coloca las extensiones en:
`C:\Users\sylex\LabDEV\LabDev-Editor\resources\app\extensions\`

## 🔧 Próximos pasos opcionales

1. **Crear instalador con Inno Setup**
   - Descarga Inno Setup: https://jrsoftware.org/isdl.php
   - Crea un script .iss para generar un instalador .exe

2. **Firmar digitalmente**
   - Obtén un certificado de firma de código
   - Usa `signtool.exe` para firmar LabDev.exe

3. **Publicar en GitHub Releases**
   - Sube el ZIP a tu repositorio
   - Crea releases para diferentes versiones

## 📝 Notas

- LabDev usa la carpeta `.labdev` para configuración (no interfiere con VSCode)
- Todas las extensiones de Open VSX funcionan
- Compatible con todas las extensiones de VSCode (excepto las propietarias de Microsoft)

## 🆘 Soporte

Para reportar problemas: https://github.com/wasigonzi/LabDEV/issues
