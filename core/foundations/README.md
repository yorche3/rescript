# 🚀 Fundamentos / Foundations — ReScript

Implementación de los ejercicios de la sección [Fundamentos / Foundations](https://yorche3.github.io/programming_languages/core/foundations/) del repositorio principal en **ReScript**.

---

## 📖 Descripción / Description

**ES:** Esta sección reúne los conceptos esenciales para empezar a trabajar con **ReScript**. Cubre desde los programas más básicos (`Hello, World!` y `Hello, User!`) hasta la implementación de una calculadora con pruebas unitarias y algoritmos numéricos en tres enfoques progresivos (recursivo directo, recursivo con acumulador e iterativo).

**EN:** This section brings together the essential concepts to start working with **ReScript**. It covers everything from the most basic programs (`Hello, World!` and `Hello, User!`) to the implementation of a calculator with unit tests and numerical algorithms in three progressive approaches (direct recursion, accumulator recursion, and iterative).

---

## 📁 Estructura / Structure

```text
rescript/
└── core/
    └── foundations/
        ├── README.md              # Este archivo / This file
        ├── helloworld/            # 01_Hello_World — Primer programa
        │   ├── src/
        │   │   └── hello_world.res
        │   ├── rescript.json
        │   ├── package.json
        │   ├── .gitignore
        │   └── README.md
        ├── hellouser/             # 02_Hello_User — Entrada y salida
        │   ├── src/
        │   │   └── hello_user.res
        │   ├── rescript.json
        │   ├── package.json
        │   ├── .gitignore
        │   └── README.md
        ├── unit_test/
        │   └── calculator/        # 03_Unit_Test_Calculator — Pruebas unitarias
        │       ├── src/
        │       │   └── calculator.res
        │       ├── test/
        │       │   └── calculator_test.res
        │       ├── rescript.json
        │       ├── jest.config.js
        │       ├── babel.config.js
        │       ├── package.json
        │       ├── .gitignore
        │       └── README.md
        └── numbers/               # 04_Numbers — Algoritmos numéricos
            ├── src/
            │   └── numbers.res
            ├── test/
            │   ├── recursive_tests.res
            │   ├── recursive_with_acc_tests.res
            │   └── iterative_tests.res
            ├── rescript.json
            ├── jest.config.js
            ├── babel.config.js
            ├── package.json
            ├── .gitignore
            └── README.md
```

---

## 🔢 Progresión / Progression

| Especificación | Proyecto | Conceptos | Tests | Dependencias externas |
| -------------- | -------- | --------- | :---: | :-------------------: |
| [`01_Hello_World`](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | `Js.log`, compilación a JS, `node` | — | ✅ rescript (compilador) |
| [`02_Hello_User`](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | Interop con `readline`, callbacks, `Js.log2` | — | ✅ rescript (compilador) |
| [`03_Unit_Test_Calculator`](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | Jest, rescript-jest, `describe`/`test` | 5 | ✅ jest + rescript-jest (solo test) |
| [`04_Numbers`](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | Recursión, acumuladores, bucles, TCO, `testAll` | 33 | ✅ jest + rescript-jest (solo test) |

---

## 🛠️ Enfoque general / General Approach

**ES:** Los proyectos en esta sección siguen un patrón progresivo:

1. **Hello World** y **Hello User**: Programas de un solo archivo `.res`, compilados con `rescript` a JS y ejecutados con `node`. El código fuente solo usa el lenguaje; el compilador es la única herramienta.
2. **Calculator**: Primer proyecto con framework de pruebas (**Jest** con los bindings **@glennsl/rescript-jest**). Introduce la separación `src/` + `test/` y el script `test` (`rescript && jest`).
3. **Numbers**: Expande el patrón a tres suites con `testAll` (una por función, casos como tuplas). El **compilador de ReScript optimiza la auto-recursión de cola** en el JS generado (independiente del motor de JS), así que se prueban los tres enfoques: `_rec` + `_acc` + `_ite` = 33 pruebas.

**EN:** The projects in this section follow a progressive pattern:

1. **Hello World** and **Hello User**: Single-file `.res` programs, compiled with `rescript` to JS and run with `node`. The source code only uses the language; the compiler is the only tool.
2. **Calculator**: First project with a test framework (**Jest** with the **@glennsl/rescript-jest** bindings). Introduces the `src/` + `test/` separation and the `test` script (`rescript && jest`).
3. **Numbers**: Expands the pattern to three suites with `testAll` (one per function, cases as tuples). The **ReScript compiler optimizes self-tail-recursion** in the generated JS (independent of the JS engine), so all three approaches are tested: `_rec` + `_acc` + `_ite` = 33 tests.

---

## 🚀 Ejecución rápida / Quick Start

### Hello World

```bash
cd rescript/core/foundations/helloworld
npm install
npm run res:build
node src/hello_world.res.js
```

### Hello User

```bash
cd rescript/core/foundations/hellouser
npm install
npm run res:build
node src/hello_user.res.js
```

### Calculator (pruebas)

```bash
cd rescript/core/foundations/unit_test/calculator
npm install
npm test
```

### Numbers (pruebas)

```bash
cd rescript/core/foundations/numbers
npm install
npm test
```

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
