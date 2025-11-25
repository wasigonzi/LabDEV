# 🎨 Tema LabDev Dark

## Colores Principales

### Color Fucsia (Acento Principal)
- **Hex**: `#ff00ff`
- **Uso**: Keywords, cursores, bordes activos, badges, botones

### Paleta de Colores

```
Fucsia Principal:    #ff00ff  ████████
Fucsia Hover:        #ff33ff  ████████
Fucsia Transparente: #ff00ff33 ████████

Fondos:
  Editor:            #1e1e1e  ████████
  Barra lateral:     #1e1e1e  ████████
  Barra actividad:   #1a1a1a  ████████
  Paneles:           #252525  ████████

Texto:
  Principal:         #d4d4d4  ████████
  Secundario:        #cccccc  ████████
  Inactivo:          #888888  ████████

Bordes:              #2d2d2d  ████████
```

## Elementos de la Interfaz

### Barra de Actividad (Izquierda)
- Fondo: Negro oscuro `#1a1a1a`
- Iconos activos: **Fucsia** `#ff00ff`
- Iconos inactivos: Gris `#888888`
- Badges: Fucsia con texto blanco

### Barra Lateral
- Fondo: `#1e1e1e`
- Títulos: **Fucsia** `#ff00ff`
- Texto: Gris claro `#cccccc`

### Editor
- Fondo: `#1e1e1e`
- Texto: `#d4d4d4`
- Cursor: **Fucsia** `#ff00ff`
- Línea actual: `#2a2a2a`
- Selección: Fucsia transparente `#ff00ff33`
- Números de línea activos: **Fucsia**

### Pestañas
- Pestaña activa: Borde superior **fucsia**
- Fondo activo: `#1e1e1e`
- Fondo inactivo: `#252525`

### Barra de Estado (Inferior)
- Fondo: `#1a1a1a`
- Texto: Blanco
- Modo debug: Fondo **fucsia**

### Botones
- Fondo: **Fucsia** `#ff00ff`
- Texto: Blanco
- Hover: Fucsia claro `#ff33ff`

### Terminal
- Fondo: `#1e1e1e`
- Magenta: **Fucsia** `#ff00ff`
- Magenta brillante: `#ff33ff`

## Sintaxis de Código

### Keywords y Control
```javascript
// Keywords en FUCSIA
const, let, var, function, class, if, else, return
```

### Strings
```javascript
// Strings en naranja suave
"texto", 'texto', `template`
```

### Variables
```javascript
// Variables en azul claro
myVariable, myFunction
```

### Funciones
```javascript
// Nombres de función en amarillo
function myFunction() {}
```

### Tipos y Clases
```javascript
// Tipos en verde azulado
class MyClass, interface MyInterface
```

### Comentarios
```javascript
// Comentarios en verde (itálica)
/* Comentario de bloque */
```

### Números
```javascript
// Números en verde claro
123, 45.67, 0xFF
```

### Llaves y Paréntesis
```javascript
// Llaves en FUCSIA
{ } [ ] ( )
```

## Activar el Tema

### Método 1: Atajo de teclado
1. Presiona `Ctrl+K` luego `Ctrl+T`
2. Selecciona **"LabDev Dark"**

### Método 2: Menú
1. File → Preferences → Color Theme
2. Selecciona **"LabDev Dark"**

### Método 3: Comando
1. Presiona `Ctrl+Shift+P`
2. Escribe "Color Theme"
3. Selecciona **"LabDev Dark"**

## Tema Predeterminado

El tema **LabDev Dark** está configurado como predeterminado.
Se activará automáticamente al abrir LabDev por primera vez.

## Personalización Adicional

Para modificar colores específicos, edita:
```
LabDev-Editor\resources\app\extensions\theme-defaults\themes\labdev-dark-color-theme.json
```

### Ejemplo: Cambiar el tono de fucsia

```json
{
  "colors": {
    "activityBar.foreground": "#ff00ff",  // Cambiar aquí
    "focusBorder": "#ff00ff"              // Y aquí
  }
}
```

## Comparación con Kiro

| Elemento | Kiro | LabDev |
|----------|------|--------|
| Color principal | Violeta | **Fucsia** |
| Fondo | Oscuro | Oscuro (igual) |
| Sintaxis | Similar | Similar |
| Acentos | Violeta | **Fucsia** |

## Vista Previa

```javascript
// Ejemplo de código con el tema LabDev Dark
import { Component } from 'react';

class MyComponent extends Component {
  constructor(props) {
    super(props);
    this.state = {
      count: 0,
      message: "Hello LabDev!"
    };
  }

  handleClick = () => {
    // Comentario: incrementar contador
    this.setState({ count: this.state.count + 1 });
  }

  render() {
    return (
      <div className="container">
        <h1>{this.state.message}</h1>
        <p>Count: {this.state.count}</p>
        <button onClick={this.handleClick}>
          Click me
        </button>
      </div>
    );
  }
}

export default MyComponent;
```

## Soporte

Si encuentras algún problema con el tema o quieres sugerir mejoras:
- GitHub Issues: https://github.com/wasigonzi/LabDEV/issues

---

**Disfruta tu tema LabDev Dark con colores fucsia!** 💜✨
