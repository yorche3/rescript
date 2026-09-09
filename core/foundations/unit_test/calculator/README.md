# Calculator — ReScript

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **ReScript**, con **@glennsl/rescript-jest + Jest** como framework de pruebas unitarias — la combinación estándar para testear ReScript.

Operaciones aritméticas básicas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) con implementaciones intuitivas y educativas, validadas mediante pruebas unitarias.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/calculator.res`](src/calculator.res) | Código fuente: módulo `Calculator` con las 5 funciones. |
| [`test/calculator_test.res`](test/calculator_test.res) | Suite de pruebas: 5 `test` con `expect(...)->toBe(...)`. |
| [`rescript.json`](rescript.json) | Configuración del compilador (ES module, tests en modo dev). |
| [`jest.config.js`](jest.config.js) | Configuración de Jest (descubrimiento y transform de `.res.mjs`). |
| [`babel.config.js`](babel.config.js) | Babel para transformar el JS generado (preset-env). |
| [`package.json`](package.json) | Dependencias y script `test` (`rescript && jest`). |
| [`.gitignore`](.gitignore) | Ignora `node_modules/`, artefactos generados y lock. |

**Estructura de directorios esperada:**

```text
calculator/
├── src/
│   └── calculator.res            # Código fuente
├── test/
│   └── calculator_test.res       # Suite de pruebas
├── rescript.json                 # Configuración del compilador
├── jest.config.js                # Configuración de Jest
├── babel.config.js               # Configuración de Babel
├── package.json                  # Dependencias y scripts
├── .gitignore
└── README.md                     # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. El flujo de pruebas es: el compilador `rescript` traduce `src/calculator.res` y `test/calculator_test.res` a `.res.mjs` (ES modules, `in-source`), y **Jest** los descubre y ejecuta con la ayuda de **@glennsl/rescript-jest** (bindings de Jest para ReScript) y **babel-jest** para transformar el JS generado.

**EN:** The project was created manually, without scaffolding tools. The test flow: the `rescript` compiler translates `src/calculator.res` and `test/calculator_test.res` into `.res.mjs` (ES modules, `in-source`), and **Jest** discovers and runs them with the help of **@glennsl/rescript-jest** (Jest bindings for ReScript) and **babel-jest** to transform the generated JS.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p rescript/core/foundations/unit_test/calculator/{src,test}
   ```

2. Escribir `src/calculator.res`, `test/calculator_test.res` y las configuraciones.

3. Instalar dependencias y ejecutar:

   ```bash
   npm install
   npm test
   ```

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/calculator.res` — Implementaciones educativas

**ES:** Cada operación compleja se construye a partir de las simples (concepto que se explora a fondo en `04_Numbers`): `multiplication` suma repetidamente, `division` resta repetidamente y `modulus` reutiliza `division` y `multiplication`. Por eso **no** se usan los operadores `*`, `/` ni `mod`. Los bucles usan `ref` (mutación explícita de ReScript) y los operadores `:=`/`.contents`.

**EN:** Each complex operation is built from the simple ones (a concept explored in depth in `04_Numbers`): `multiplication` adds repeatedly, `division` subtracts repeatedly, and `modulus` reuses `division` and `multiplication`. That's why the operators `*`, `/` and `mod` are **not** used. Loops use `ref` (ReScript's explicit mutation) and the `:=`/`.contents` operators.

```rescript
let addition = (a, b) => a + b

let subtraction = (a, b) => a - b

let multiplication = (a, b) => {
  let result = ref(0)
  for _ in 1 to b {
    result := addition(result.contents, a)
  }
  result.contents
}

let division = (a, b) => {
  let quotient = ref(0)
  let rest = ref(a)
  while rest.contents >= b {
    rest := subtraction(rest.contents, b)
    quotient := addition(quotient.contents, 1)
  }
  quotient.contents
}

let modulus = (a, b) => {
  let q = division(a, b)
  let p = multiplication(q, b)
  subtraction(a, p)
}
```

| Función | Implementación educativa |
|---------|-------------------------|
| `addition(a, b)` | Suma directa (`+`) |
| `subtraction(a, b)` | Resta directa (`-`) |
| `multiplication(a, b)` | Suma repetitiva: `for 1 to b` suma `a` a `result` |
| `division(a, b)` | Resta repetitiva: `while rest >= b` resta `b` y cuenta |
| `modulus(a, b)` | `q = division(a, b)`; `p = multiplication(q, b)`; `subtraction(a, p)` |

### `test/calculator_test.res` — Suite con rescript-jest

**ES:** Un `test` por operación (5 tests, uno por función), cada uno con su `expect(...)->toBe(...)`. Los módulos `Jest` y `Expect` vienen de los bindings `@glennsl/rescript-jest`.

**EN:** One `test` per operation (5 tests, one per function), each with its `expect(...)->toBe(...)`. The `Jest` and `Expect` modules come from the `@glennsl/rescript-jest` bindings.

```rescript
open Jest
open Expect

describe("Calculator", () => {
  test("addition", () => {
    expect(Calculator.addition(2, 3))->toBe(5)
  })

  test("subtraction", () => {
    expect(Calculator.subtraction(5, 2))->toBe(3)
  })

  test("multiplication", () => {
    expect(Calculator.multiplication(3, 4))->toBe(12)
  })

  test("division", () => {
    expect(Calculator.division(10, 3))->toBe(3)
  })

  test("modulus", () => {
    expect(Calculator.modulus(10, 3))->toBe(1)
  })
})
```

### `rescript.json` — Compilador

```json
{
  "name": "calculator",
  "sources": [
    { "dir": "src", "subdirs": true },
    { "dir": "test", "type": "dev" }
  ],
  "package-specs": { "module": "esmodule", "in-source": true },
  "suffix": ".res.mjs",
  "bs-dependencies": [],
  "bs-dev-dependencies": ["@glennsl/rescript-jest"]
}
```

| Campo | Propósito |
|-------|-----------|
| `sources` | Compila `src/` y, en modo dev, `test/`. |
| `package-specs` | Salida ES module `in-source` (los `.res.mjs` junto a los `.res`). |
| `bs-dev-dependencies` | `@glennsl/rescript-jest` disponible solo para los tests. |

### `jest.config.js` — Runner

```js
module.exports = {
  moduleFileExtensions: ["js", "mjs"],
  testMatch: ["<rootDir>/test/**/*_test.res.mjs"],
  transform: { "^.+\\.m?js$": "babel-jest" },
  transformIgnorePatterns: [
    "node_modules/(?!(rescript|@glennsl/rescript-jest)/)"
  ],
};
```

> **ES:** Jest ya incluye su propio runner, así que no se crea el `run_tests` del pseudocódigo (la especificación lo pide solo si el framework no lo incluye); el punto de entrada es `npm test` (`rescript && jest`).
> **EN:** Jest already includes its own runner, so the pseudocode's `run_tests` is not created (the specification asks for it only if the framework doesn't include one); the entry point is `npm test` (`rescript && jest`).

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Node.js** y **npm**.
- **ReScript** y **jest** + **@glennsl/rescript-jest** (devDependencies del proyecto).

```bash
# Verificar instalación
node --version
npm --version

# Instalar dependencias (primera vez)
cd rescript/core/foundations/unit_test/calculator
npm install
```

### Ejecutar las pruebas / Run tests

```bash
cd rescript/core/foundations/unit_test/calculator
npm test
```

### Salida esperada / Expected output

```text
Test Suites: 1 passed, 1 total
Tests:       5 passed, 5 total
Snapshots:   0 total
Time:        <tiempo>
Ran all test suites.
```

> **ES:** `Tests: 5 passed` confirma que las 5 operaciones se verificaron correctamente (equivale al `Tests run: 5, Passed: 5, Failed: 0` de la especificación).
> **EN:** `Tests: 5 passed` confirms that all 5 operations were verified correctly (equivalent to the specification's `Tests run: 5, Passed: 5, Failed: 0`).

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** `ref` crea una celda mutable; se lee con `.contents` y se asigna con `:=` — es la forma explícita de mutación en ReScript.
- **EN:** `ref` creates a mutable cell; it is read with `.contents` and assigned with `:=` — ReScript's explicit way to mutate.
- **ES:** La división por cero no se maneja en este ejemplo educativo (según el pseudocódigo de la especificación); las pruebas usan valores válidos.
- **EN:** Division by zero is not handled in this educational example (per the specification's pseudocode); tests use valid values.
- **ES:** El código fuente solo usa el lenguaje; `@glennsl/rescript-jest` y `jest` son dependencias exclusivas de pruebas.
- **EN:** The source code uses only the language; `@glennsl/rescript-jest` and `jest` are test-only dependencies.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
