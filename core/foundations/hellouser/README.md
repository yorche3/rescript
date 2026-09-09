# Hello, User! — ReScript

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **ReScript**, con un enfoque manual y minimalista.

Solicita un nombre al usuario por la entrada estándar (estilo prompt) y saluda, usando el módulo `readline` de Node.js mediante interop de ReScript.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/hello_user.res`](src/hello_user.res) | Código fuente: prompt interactivo con `readline` y saludo con `Js.log2`. |
| [`rescript.json`](rescript.json) | Configuración del compilador ReScript (entradas, salida ES module). |
| [`package.json`](package.json) | Dependencias (`rescript`, `@rescript/core`) y scripts de build. |

**Estructura de directorios esperada:**

```text
hellouser/
├── src/
│   ├── hello_user.res       # Código fuente
│   └── hello_user.res.js    # Generado por el compilador (in-source)
├── rescript.json            # Configuración del compilador
├── package.json             # Dependencias y scripts
├── node_modules/            # Dependencias instaladas (ignorado en git)
└── README.md                # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce tres conceptos nuevos respecto a `helloworld`:

1. **Interop con Node.js** — `@module("readline")` enlaza el módulo `readline` de Node; `createInterface` crea la interfaz de lectura sobre `stdin`/`stdout`.
2. **Entrada de usuario** — `question(rl, "Enter your name: ", ...)` muestra el prompt y pasa la línea leída al callback.
3. **Callback y salida** — el nombre llega como argumento a una función flecha, que saluda con `Js.log2` y cierra la interfaz con `close(rl)`.

**EN:** This program introduces three new concepts compared to `helloworld`:

1. **Node.js interop** — `@module("readline")` binds Node's `readline` module; `createInterface` creates the reading interface over `stdin`/`stdout`.
2. **User input** — `question(rl, "Enter your name: ", ...)` shows the prompt and passes the read line to the callback.
3. **Callback and output** — the name arrives as an argument to an arrow function, which greets with `Js.log2` and closes the interface with `close(rl)`.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p rescript/core/foundations/hellouser/src
   ```

2. Inicializar `package.json` e instalar las dependencias:

   ```bash
   cd rescript/core/foundations/hellouser
   npm init -y
   npm install --save-dev rescript @rescript/core
   ```

3. Crear `rescript.json` y escribir `src/hello_user.res`.

4. Compilar con `npm run res:build`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/hello_user.res` — Código fuente con interop

**ES:** El flujo del programa es:

1. Enlazar `stdin` y `stdout` de `node:process`.
2. Crear la interfaz `readline` con `createInterface`.
3. Lanzar `question` con el prompt; en el callback, saludar con `Js.log2` y cerrar la interfaz.

**EN:** Program flow:

1. Bind `stdin` and `stdout` from `node:process`.
2. Create the `readline` interface with `createInterface`.
3. Fire `question` with the prompt; in the callback, greet with `Js.log2` and close the interface.

```rescript
type readlineInterface

@module("readline") @new external createInterface: (
  ~input: Js.t<'a>,
  ~output: Js.t<'b>,
) => readlineInterface = "createInterface"

@send external on: (readlineInterface, @string [#line(string => unit) | #close(unit => unit)]) => unit = "on"
@send external question: (readlineInterface, string, string => unit) => unit = "question"
@send external close: readlineInterface => unit = "close"

@module("node:process")
external stdin: Js.t<{..}> = "stdin"

@module("node:process")
external stdout: Js.t<{..}> = "stdout"

let run = () => {
  let rl = createInterface(~input=stdin, ~output=stdout)

  question(rl,"Enter your name: ", name => {
    Js.log2("Hello, ", name)
    close(rl)
  })
}

run()
```

| Elemento | Propósito |
|----------|-----------|
| `type readlineInterface` | Tipo opaco que representa la interfaz de `readline` en ReScript. |
| `@module("readline") @new external createInterface` | Enlaza el constructor de `readline` de Node; recibe `input`/`output` con etiquetas. |
| `@send external question` | Enlaza `rl.question(prompt, callback)`; el callback recibe la línea leída. |
| `@send external close` | Enlaza `rl.close()` para cerrar la interfaz. |
| `@module("node:process") external stdin` | Enlaza `process.stdin` de Node. |
| `Js.log2("Hello, ", name)` | `console.log` con dos argumentos (añade un espacio entre ellos). |
| `let run = () => { ... }` | Función principal que orquesta el flujo; se invoca al final con `run()`. |

> **ES:** Los *externals* con `@module`/`@send` son la forma de ReScript de declarar bindings a JavaScript. El `@string` de `on` restringe el nombre del evento a literales válidos (`line`/`close`).
> **EN:** `@module`/`@send` externals are ReScript's way of declaring JavaScript bindings. `on`'s `@string` restricts the event name to valid literals (`line`/`close`).

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
cd rescript/core/foundations/hellouser
npm install
```

### Compilar y ejecutar / Build & Run

```bash
cd rescript/core/foundations/hellouser
npm run res:build
node src/hello_user.res.js
```

**ES:** El programa muestra el prompt y espera a que escribas tu nombre y presiones Enter.
**EN:** The program shows the prompt and waits for you to type your name and press Enter.

### Salida esperada / Expected output

```text
Enter your name: Ada
Hello,  Ada
```

> **ES:** `Js.log2` imprime sus dos argumentos separados por un espacio: `"Hello, "` + espacio + `Ada` → `Hello,  Ada` (dos espacios). También admite entrada redirigida: `printf 'Ada\n' | node src/hello_user.res.js`.
> **EN:** `Js.log2` prints its two arguments separated by a space: `"Hello, "` + space + `Ada` → `Hello,  Ada` (two spaces). It also accepts redirected input: `printf 'Ada\n' | node src/hello_user.res.js`.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El flujo principal vive en `run()` (convención, no obligación del lenguaje); ReScript no exige una función `main`.
- **EN:** The main flow lives in `run()` (a convention, not a language requirement); ReScript does not mandate a `main` function.
- **ES:** `readline` es el módulo de Node para leer entrada interactiva línea a línea; su API es asíncrona (callback), por eso el saludo vive dentro del callback de `question`.
- **EN:** `readline` is Node's module for reading interactive input line by line; its API is asynchronous (callback), so the greeting lives inside `question`'s callback.
- **ES:** El archivo `src/hello_user.res.js` es generado por el compilador; no se edita manualmente.
- **EN:** The file `src/hello_user.res.js` is generated by the compiler; it is not edited manually.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
