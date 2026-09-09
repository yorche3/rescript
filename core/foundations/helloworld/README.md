# Hello, World! — ReScript

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **ReScript**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/hello_world.res`](src/hello_world.res) | Código fuente: imprime `"Hello, World! from ReScript"` en la consola. |
| [`rescript.json`](rescript.json) | Configuración del compilador ReScript (entradas, salida ES module). |
| [`package.json`](package.json) | Dependencias (`rescript`, `@rescript/core`) y scripts de build. |

**Estructura de directorios esperada:**

```text
helloworld/
├── src/
│   ├── hello_world.res      # Código fuente
│   └── hello_world.res.js   # Generado por el compilador (in-source)
├── rescript.json            # Configuración del compilador
├── package.json             # Dependencias y scripts
├── node_modules/            # Dependencias instaladas (ignorado en git)
├── .gitignore               # Ignora artefactos (node_modules, .res.js, ...)
└── README.md                # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. ReScript es un lenguaje que **compila a JavaScript**: el compilador `rescript` lee `src/hello_world.res` y genera `src/hello_world.res.js` (modo `in-source`, ES module), que se ejecuta con `node`.

**EN:** The project was created manually, without scaffolding tools. ReScript is a language that **compiles to JavaScript**: the `rescript` compiler reads `src/hello_world.res` and generates `src/hello_world.res.js` (`in-source` mode, ES module), which runs with `node`.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p rescript/core/foundations/helloworld/src
   ```

2. Inicializar `package.json` e instalar las dependencias:

   ```bash
   cd rescript/core/foundations/helloworld
   npm init -y
   npm install --save-dev rescript @rescript/core
   ```

3. Crear `rescript.json` y escribir `src/hello_world.res`.

4. Compilar con `npm run res:build`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/hello_world.res` — Código fuente

```rescript
Js.log("Hello, World! from ReScript")
```

| Elemento | Propósito |
|----------|-----------|
| `Js.log(...)` | Función de la API JS de ReScript: escribe en `console.log` con salto de línea. |
| `"Hello, World! from ReScript"` | Argumento: la cadena a imprimir. |

> **ES:** `Js.log` compila a `console.log`. La API `Js.*` es de bajo nivel; `@rescript/core` (incluido) ofrece `Console.log` con inferencia de tipos más rica.
> **EN:** `Js.log` compiles to `console.log`. The `Js.*` API is low-level; `@rescript/core` (included) offers `Console.log` with richer type inference.

### `rescript.json` — Configuración del compilador

```json
{
  "name": "helloworld",
  "sources": [
    {
      "dir": "src",
      "subdirs": true
    }
  ],
  "package-specs": [
    {
      "module": "esmodule",
      "in-source": true
    }
  ],
  "suffix": ".res.js",
  "bs-dependencies": [
    "@rescript/core"
  ],
  "bsc-flags": [
    "-open RescriptCore"
  ]
}
```

| Campo | Propósito |
|-------|-----------|
| `name` | Nombre del proyecto de compilación. |
| `sources` | Directorios de entrada: compila todo `src/` (con subdirectorios). |
| `package-specs` | Salida: `esmodule` genera módulos ES; `in-source: true` coloca los `.res.js` junto a los `.res`. |
| `suffix` | Extensión de los archivos generados (`.res.js`). |
| `bs-dependencies` | Dependencias compiladas con ReScript (`@rescript/core`). |
| `bsc-flags` | Flags del compilador: `-open RescriptCore` abre el módulo `RescriptCore` en todos los archivos. |

### `package.json` — Scripts

```json
"scripts": {
  "res:build": "rescript",
  "res:dev": "rescript -w"
}
```

| Script | Propósito |
|--------|-----------|
| `npm run res:build` | Compila el proyecto una vez. |
| `npm run res:dev` | Compila en modo watch (recompila al guardar). |

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Node.js** y **npm**.
- **ReScript** y **@rescript/core** (devDependencies del proyecto).

```bash
# Verificar instalación
node --version
npm --version

# Instalar dependencias (primera vez)
cd rescript/core/foundations/helloworld
npm install
```

### Compilar y ejecutar / Build & Run

```bash
cd rescript/core/foundations/helloworld
npm run res:build
node src/hello_world.res.js
```

### Salida esperada / Expected output

```text
Hello, World! from ReScript
```

> **ES:** `package.json` ya declara `"type": "module"` (la salida es ES module), por lo que `node` no muestra el aviso `MODULE_TYPELESS_PACKAGE_JSON`.
> **EN:** `package.json` already declares `"type": "module"` (the output is an ES module), so `node` does not show the `MODULE_TYPELESS_PACKAGE_JSON` warning.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** ReScript no requiere una función `main`: el script se ejecuta de arriba a abajo.
- **EN:** ReScript does not require a `main` function: the script executes top to bottom.
- **ES:** El archivo `src/hello_world.res.js` es generado por el compilador; no se edita manualmente.
- **EN:** The file `src/hello_world.res.js` is generated by the compiler; it is not edited manually.
- **ES:** `Js.log` escribe en `stdout` (vía `console.log`) con salto de línea.
- **EN:** `Js.log` writes to `stdout` (via `console.log`) with a newline.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
