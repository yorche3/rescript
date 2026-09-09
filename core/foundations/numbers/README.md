# Numbers — ReScript

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **ReScript**, con **@glennsl/rescript-jest + Jest** como framework de pruebas unitarias.

Tres enfoques de implementación para los mismos 5 algoritmos: **recursivo directo** (`_rec`), **recursivo con acumulador** (`_acc`) e **iterativo** (`_ite`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/numbers.res`](src/numbers.res) | Módulo `Numbers` — único archivo con las 15 funciones (3 enfoques × 5 algoritmos) + 4 helpers `_help`. |
| [`test/recursive_tests.res`](test/recursive_tests.res) | Suite recursiva: 11 casos con `testAll`. |
| [`test/recursive_with_acc_tests.res`](test/recursive_with_acc_tests.res) | Suite con acumulador: 11 casos con `testAll`. |
| [`test/iterative_tests.res`](test/iterative_tests.res) | Suite iterativa: 11 casos con `testAll`. |
| [`rescript.json`](rescript.json) | Configuración del compilador (ES module, tests en modo dev). |
| [`jest.config.js`](jest.config.js) | Configuración de Jest (descubrimiento y transform de `.res.mjs`). |
| [`babel.config.js`](babel.config.js) | Babel para transformar el JS generado (preset-env). |
| [`package.json`](package.json) | Dependencias y script `test` (`rescript && jest`). |
| [`.gitignore`](.gitignore) | Ignora `node_modules/`, artefactos generados y lock. |

**Estructura de directorios esperada:**

```text
numbers/
├── src/
│   └── numbers.res                 # Único archivo: 3 enfoques en 1
├── test/
│   ├── recursive_tests.res         # Tests: enfoque recursivo
│   ├── recursive_with_acc_tests.res# Tests: enfoque con acumulador
│   └── iterative_tests.res         # Tests: enfoque iterativo
├── rescript.json                   # Configuración del compilador
├── jest.config.js                  # Configuración de Jest
├── babel.config.js                 # Configuración de Babel
├── package.json                    # Dependencias y scripts
├── .gitignore
└── README.md                       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa el mismo patrón que `calculator`: el compilador `rescript` traduce `src/numbers.res` y las suites a `.res.mjs`, y **Jest** los ejecuta. Las 15 funciones se organizan en 3 grupos por enfoque:

**EN:** This project uses the same pattern as `calculator`: the `rescript` compiler translates `src/numbers.res` and the suites into `.res.mjs`, and **Jest** runs them. The 15 functions are organized into 3 groups by approach:

| Enfoque | Sufijo | Ejemplo | ¿Tiene tests directos? |
| ------- | ------ | ------- | :---------------------: |
| Recursivo directo | `_rec` | `fibonacci_rec` | ✅ Sí |
| Recursivo con acumulador | `_acc` | `fibonacci_acc` | ✅ Sí (TCO del compilador) |
| Iterativo | `_ite` | `fibonacci_ite` | ✅ Sí |

**Combinación aplicada:** TCO ✅ + iteración ✅ → `_rec` + `_acc` + `_ite` = **3 suites × 11 casos = 33 pruebas**.

**Applied combination:** TCO ✅ + iteration ✅ → `_rec` + `_acc` + `_ite` = **3 suites × 11 cases = 33 tests**.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p rescript/core/foundations/numbers/{src,test}
   ```

2. Escribir `src/numbers.res`, las suites y las configuraciones.

3. Instalar dependencias y ejecutar:

   ```bash
   npm install
   npm test
   ```

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/numbers.res` — Implementación (3 enfoques en 1 archivo)

**ES:** Cada algoritmo tiene 3 implementaciones con los sufijos `_rec`, `_acc` e `_ite`; los helpers `_help` son privados por convención. En ReScript las referencias hacia adelante requieren `let rec ... and ...`. Por ejemplo, `fibonacci`:

**EN:** Each algorithm has 3 implementations with the suffixes `_rec`, `_acc` and `_ite`; the `_help` helpers are private by convention. In ReScript, forward references require `let rec ... and ...`. For example, `fibonacci`:

```rescript
// Direct recursion (_rec)
let rec fibonacci_rec = n =>
  if n <= 1 {
    n
  } else {
    fibonacci_rec(n - 1) + fibonacci_rec(n - 2)
  }

// Accumulator recursion (_acc): tail calls, TCO by the compiler
let rec fibonacci_acc = n => fibonacci_acc_help(n, 0, 1)
and fibonacci_acc_help = (n, acc2, acc1) =>
  if n <= 0 {
    acc2
  } else if n <= 2 {
    acc1 + acc2
  } else {
    fibonacci_acc_help(n - 1, acc1, acc1 + acc2)
  }

// Iterative (_ite)
let fibonacci_ite = n =>
  if n <= 1 {
    n
  } else {
    let acc2 = ref(0)
    let acc1 = ref(1)
    for _ in 2 to n {
      let temp = acc1.contents + acc2.contents
      acc2 := acc1.contents
      acc1 := temp
    }
    acc1.contents
  }
```

| Algoritmo | `_rec` | `_acc` | `_ite` |
| --------- | ------ | ------ | ------ |
| `sum_of_first_n` | `n + sum_rec(n-1)` | helper con `n + acc` | `for 1 to n` con `ref` |
| `factorial` | `n * fact_rec(n-1)` | helper con `n * acc` | `for 2 to n` con `ref` |
| `fibonacci` | suma de dos llamadas | helper con `acc2, acc1` | `for 2 to n` con intercambio |
| `greatest_common_divisor` | Euclides recursivo | helper (Euclides) | `while b2 != 0` |
| `least_common_multiple` | `(a * b) / gcd` | `(a * b) / gcd` | `(a * b) / gcd` |

### Suites de pruebas — rescript-jest

**ES:** Tres suites, una por enfoque. Cada suite agrupa un `describe` por función con `testAll`: los 11 casos del pseudocódigo viven como tuplas en la lista y Jest ejecuta todos los casos, informando de cuál falla si alguno lo hace.

**EN:** Three suites, one per approach. Each suite groups one `describe` per function with `testAll`: the pseudocode's 11 cases live as tuples in the list and Jest runs every case, reporting which one fails if any does.

```rescript
open Jest
open Expect

describe("Recursive", () => {
  describe("sum_of_first_n_rec", () => {
    testAll("", list{
      (0, 0),
      (3, 6)
    }, ((n, expected)) => {
      expect(Numbers.sum_of_first_n_rec(n))->toBe(expected)
    })
  })

  describe("fibonacci_rec", () => {
    testAll("", list{
      (0, 0),
      (1, 1),
      (6, 8)
    }, ((n, expected)) => {
      expect(Numbers.fibonacci_rec(n))->toBe(expected)
    })
  })
})
```

> **ES:** Jest ya incluye su propio runner, así que no se crea el `run_tests` del pseudocódigo (la especificación lo pide solo si el framework no lo incluye); el punto de entrada es `npm test`.
> **EN:** Jest already includes its own runner, so the pseudocode's `run_tests` is not created (the specification asks for it only if the framework doesn't include one); the entry point is `npm test`.

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
cd rescript/core/foundations/numbers
npm install
```

### Ejecutar las pruebas / Run tests

```bash
cd rescript/core/foundations/numbers
npm test
```

### Salida esperada / Expected output

```text
Test Suites: 3 passed, 3 total
Tests:       33 passed, 33 total
Snapshots:   0 total
Time:        <tiempo>
Ran all test suites.
```

> **ES:** `Tests: 33 passed` — Jest cuenta cada caso de `testAll` como un test (11 por suite), equivalente al `tests runned 33 / passed 33 / failed 0` de la especificación.
> **EN:** `Tests: 33 passed` — Jest counts each `testAll` case as a test (11 per suite), equivalent to the specification's `tests runned 33 / passed 33 / failed 0`.

---

## 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO)

**ES:**
Tail recursion ocurre cuando la llamada recursiva es la última acción que ejecuta una función; después de la llamada no hay más instrucciones. La recursión con acumulador consigue esto pasando el estado previo como parámetro, sin dejar trabajo pendiente en la pila.

**El compilador de ReScript optimiza la auto-recursión de cola** directamente en el JS generado (convierte la llamada en un bucle), de forma **independiente del motor de JavaScript**: no depende de que V8 u otro motor soporte TCO. La optimización aplica solo a la auto-recursión (la función se llama a sí misma) y exige la forma correcta: la llamada recursiva debe ser el **último paso** y su resultado se retorna directamente. Los helpers `_help` de este proyecto cumplen ambos requisitos, por lo que **sí se les escriben pruebas unitarias propias** (suite `recursive_with_acc_tests.res`). Verificado empíricamente: `sum_of_first_n_rec(1000000)` lanza `RangeError` mientras que `sum_of_first_n_acc(1000000)` se ejecuta sin desbordar la pila.

**EN:**
Tail recursion occurs when the recursive call is the last action executed by a function; after the call there are no more instructions. Accumulator recursion achieves this by passing the previous state as a parameter, leaving no pending work on the stack.

**The ReScript compiler optimizes self-tail-recursion** directly in the generated JS (turning the call into a loop), **independently of the JavaScript engine**: it does not depend on V8 or any other engine supporting TCO. The optimization applies only to self-recursion (the function calls itself) and requires the correct form: the recursive call must be the **last step** and its result returned directly. This project's `_help` helpers meet both requirements, so **dedicated unit tests are written for them** (suite `recursive_with_acc_tests.res`). Empirically verified: `sum_of_first_n_rec(1000000)` throws `RangeError` while `sum_of_first_n_acc(1000000)` runs without overflowing the stack.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Las referencias hacia adelante (wrapper → helper) requieren agrupar las definiciones con `let rec ... and ...`; ReScript no resuelve funciones definidas después.
- **EN:** Forward references (wrapper → helper) require grouping the definitions with `let rec ... and ...`; ReScript does not resolve functions defined later.
- **ES:** Las suites usan `testAll` con una lista de tuplas por función: Jest ejecuta todos los casos y reporta cuál falla si alguno lo hace (patrón idiomático de rescript-jest para muchos casos).
- **EN:** Suites use `testAll` with a tuple list per function: Jest runs every case and reports which one fails if any does (rescript-jest's idiomatic pattern for many cases).
- **ES:** La división de enteros en ReScript es `/` (división entera, no flotante), así que el MCM `(a * b) / gcd` devuelve un entero exacto.
- **EN:** Integer division in ReScript is `/` (integer division, not float), so the LCM `(a * b) / gcd` returns an exact integer.
- **ES:** En `greatest_common_divisor` se usa `mod` (módulo entero de ReScript), legítimo en este algoritmo (la restricción de no usar operadores de módulo aplica solo al módulo `calculator` de la especificación 03).
- **EN:** `greatest_common_divisor` uses `mod` (ReScript's integer modulus), which is legitimate in this algorithm (the no-modulus-operator restriction applies only to the `calculator` module of specification 03).
- **ES:** Los bucles `for i in 1 to n` con `n = 0` no iteran (start > stop), como en el pseudocódigo.
- **EN:** Loops `for i in 1 to n` with `n = 0` do not iterate (start > stop), as in the pseudocode.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
