# Algorithms Pure — ReScript

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **ReScript**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre **arrays mutables**, que se ordenan *in-place* y se devuelven, y no necesitan ningún tipo opcional: `array<int>` no admite `null`, así que el caso nulo no es representable.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `npm test` (rescript + Jest) | 21 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                      # 05_Naive_Sort
    ├── src/
    │   └── naive_sort.res           # 3 funciones del contrato
    ├── test/
    │   └── naive_sort_tests.res     # 3 describe × 7 casos
    ├── rescript.json                # Fuentes, salida ESM in-source y deps dev
    ├── jest.config.js               # testMatch de los *_tests.res.mjs
    ├── babel.config.js              # preset-env para el JS generado
    ├── package.json                 # npm test = rescript && jest
    ├── .gitignore                   # Ignora node_modules/, lib/ y *.res.mjs
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | ReScript 11 compilado a JavaScript ESM y ejecutado por Node.js |
| **CLI** | `npm test` (script `rescript && jest`) |
| **Andamiaje** | ✅ Estructura manual (`mkdir -p src test` + `rescript.json`/`package.json`/`jest.config.js`), la que ya usa [`foundations/numbers/`](../foundations/numbers/); `npm install` instala las devDependencies |
| **Framework de tests** | Jest con los bindings `@glennsl/rescript-jest` (`open Jest`, `open Expect`, `describe`/`test`/`testAll`) |
| **Runner** | Jest: descubre `test/**/*_tests.res.mjs`; no hay archivo `run_tests` |
| **Separación** | `src/` (módulo) ↔ `test/` (suites, en modo `dev` para el compilador) |
| **Salida del compilador** | `package-specs` esmodule + `in-source: true` + sufijo `.res.mjs` (el JS generado queda junto al `.res` y está ignorado) |
| **Iteración** | Bucles `for i in a to b { … }` y `while … { … }`; el compilador optimiza la auto-recursión de cola |
| **Mutabilidad** | Los arrays son mutables (`array[i] = v`) → los algoritmos ordenan *in-place*; los acumuladores usan `ref` + `:=` + `.contents` |
| **API** | Una función por algoritmo, con el array recibido y devuelto |
| **Naming** | `snake_case` idéntico al de la especificación (`selection_sort`); el módulo derivado del fichero es `Naive_sort` |
| **Nulabilidad** | `array<int>` no admite `null`: el caso nulo no es representable y se omite |
| **Mensajes de aserción** | `expect` de Jest no admite mensaje: el mensaje del contrato se compone con el nombre del `describe` y el del `test` (`selection_sort › should sort an unsorted array`) |
| **Verificación estática** | `npm run res:build` (`rescript`): compila módulo y suite sin errores ni avisos |
| **Artefactos** | `node_modules/`, `lib/`, `.bsb.lock`, `*.res.mjs`, `*.bs.js` y `package-lock.json` — ignorados por el `.gitignore` del módulo |
| **Sintaxis de la versión fijada** | `rescript ^11.1.4`: `for … to` (no `..`), `ref`/`:=` (no `let mut`) y sin `break` (la salida temprana va en la condición del `while`) |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
npm install
npm test
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
