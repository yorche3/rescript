# ReScript

Proyectos en **ReScript**, el lenguaje fuertemente tipado que compila a JavaScript.
Programas simples se compilan con `rescript` y se ejecutan con `node`; los proyectos
con pruebas unitarias usan **Jest** con los bindings **@glennsl/rescript-jest**.

---

## 📂 Módulos / Modules

| Módulo | Descripción |
| ------ | ----------- |
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `unit_test/calculator`, `numbers` |
| [`core/algorithms/`](core/algorithms/) | **Fase 1 — Algoritmos Puros**: `naive_sort` |

---

## ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
npm install
npm run res:build
node src/hello_world.res.js

# Hello, User!
cd core/foundations/hellouser
npm install
npm run res:build
node src/hello_user.res.js

# Calculator Tests
cd core/foundations/unit_test/calculator
npm install
npm test

# Numbers Tests
cd core/foundations/numbers
npm install
npm test

# Naive Sort Tests
cd core/algorithms/naive_sort
npm install
npm test
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
| ----------- | ----------- |
| [Node.js](https://nodejs.org/) (y npm) | `sudo apt install nodejs npm` (Linux) / [Descargar](https://nodejs.org/) |
| [ReScript](https://rescript-lang.org/) | `npm install --save-dev rescript` (devDependency por proyecto) |
| [Jest](https://jestjs.io/) + [rescript-jest](https://github.com/glennsl/rescript-jest) | `npm install --save-dev jest babel-jest @babel/core @babel/preset-env @glennsl/rescript-jest` |

```bash
# Verificar instalación
node --version
npm --version
npx rescript --version
```

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Programa simple (compilado a JS y ejecutado con `node`)

**ES:** Un único archivo `.res` en `src/`, compilado con `rescript` a un ES module
`.res.js` (modo `in-source`) y ejecutado con `node`. Ideal para `helloworld` y
`hellouser`.

**EN:** A single `.res` file in `src/`, compiled with `rescript` into an ES module
`.res.js` (`in-source` mode) and run with `node`. Ideal for `helloworld` and
`hellouser`.

```bash
npm run res:build        # compila (rescript)
node src/<File>.res.js   # ejecuta
```

### 2. Proyecto con pruebas unitarias (Jest + rescript-jest)

**ES:** Para proyectos que requieren pruebas unitarias, se usa **Jest** con los
bindings **@glennsl/rescript-jest**. El código fuente se organiza en `src/` y las
pruebas en `test/`; el compilador genera `.res.mjs` (ES modules) que Jest descubre
según `jest.config.js` y transforma con `babel-jest`. El punto de entrada es
`npm test` (`rescript && jest`).

**EN:** For projects that require unit tests, **Jest** is used with the
**@glennsl/rescript-jest** bindings. Source code goes in `src/` and tests in
`test/`; the compiler generates `.res.mjs` (ES modules) that Jest discovers via
`jest.config.js` and transforms with `babel-jest`. The entry point is `npm test`
(`rescript && jest`).

```bash
npm test                 # rescript && jest
```

> **ES:** Cada proyecto npm tiene su propio `.gitignore` (los patrones del
> `.gitignore` raíz están anclados a la raíz y no aplican en subdirectorios).
> **EN:** Each npm project has its own `.gitignore` (the root `.gitignore`
> patterns are root-anchored and do not apply in subdirectories).

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio
principal](https://github.com/yorche3/programming_languages) para ver todas las
versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*