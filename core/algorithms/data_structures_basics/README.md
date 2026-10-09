# Data Structures Basics — ReScript

Implementación de la especificación [06_Data_Structures_Basics](../../../../docs/core/algorithms/06_Data_Structures_Basics.md) en **ReScript**, con un enfoque manual y minimalista.

**ES:** Implementación de celdas enlazadas mutables (`Node`) y estructuras de datos fundamentales (`LinkedList`, `Stack`, `Queue`) construidas directamente sobre nodos enlazados sin envoltorios de la biblioteca estándar, verificadas con **@glennsl/rescript-jest + Jest**.

**EN:** Implementation of mutable linked cells (`Node`) and fundamental data structures (`LinkedList`, `Stack`, `Queue`) built directly from scratch on linked nodes without standard library collection wrappers, verified using **@glennsl/rescript-jest + Jest**.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| `src/Node.res` | Tipo `Node` compartido y mutable (`make`, `value`, `next`, `setNext`) / Shared mutable `Node` type (`make`, `value`, `next`, `setNext`) |
| `src/LinkedList.res` | Lista enlazada simple sobre `Node` con punteros de cabeza y cola / Singly linked list over `Node` with head and tail pointers |
| `src/Stack.res` | Pila LIFO implementada directamente sobre `Node` con puntero `top` / LIFO stack implemented directly over `Node` with `top` pointer |
| `src/Queue.res` | Cola FIFO implementada directamente sobre `Node` con punteros `front` y `rear` / FIFO queue implemented directly over `Node` with `front` and `rear` pointers |
| `test/data_structures_basics_tests.res` | Suite de pruebas unitarias cubriendo los 15 pasos de verificación / Unit test suite covering all 15 verification steps |
| `rescript.json` | Configuración del compilador ReScript (ES modules, dependencias de pruebas) / ReScript compiler configuration (ES modules, test dependencies) |
| `jest.config.js` | Configuración de Jest para descubrir y ejecutar archivos `.res.mjs` / Jest configuration to discover and run `.res.mjs` files |
| `babel.config.js` | Configuración de Babel para transformación de módulos JS / Babel configuration for JS module transforms |
| `package.json` | Manifiesto de npm con scripts y dependencias de desarrollo / npm manifest with scripts and development dependencies |
| `.gitignore` | Archivos generados y artefactos de compilación excluidos / Ignored build artifacts and generated files |

**Nota de desviación en la estructura / Layout deviation note:**
- **ES:** La especificación sugiere un único archivo `src/data_structures_basics.ext` y un script `run_tests.ext`. En ReScript, los archivos corresponden a módulos individuales de primer nivel (`Node`, `LinkedList`, `Stack`, `Queue`), lo que mantiene un diseño desacoplado y modular. Asimismo, Jest actúa como test runner nativo invocado vía `npm test`, haciendo innecesario un script `run_tests` separado.
- **EN:** The specification suggests a single `src/data_structures_basics.ext` file and a `run_tests.ext` runner. In ReScript, filenames map to top-level modules (`Node`, `LinkedList`, `Stack`, `Queue`), enabling a modular and decoupled design. Additionally, Jest provides the test runner executed via `npm test`, eliminating the need for a separate `run_tests` script.

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se configuró siguiendo el patrón estándar de ReScript con compilación a JavaScript ES6 (`.res.mjs`) y ejecución mediante Jest. Cada estructura de datos manipula referencias mutables internas sobre registros (`record` con campos `mutable`), implementando los algoritmos directamente sobre punteros opcionales (`option<Node.t>`).

**EN:** The project was set up following the standard ReScript workflow compiling to ES6 JavaScript (`.res.mjs`) and executed with Jest. Each data structure operates on internal mutable record fields, implementing algorithms directly over optional node pointers (`option<Node.t>`).

### Comandos de inicialización y ejecución / Initialization and run commands

```bash
# Instalar dependencias / Install dependencies
npm install

# Compilar fuentes / Compile sources
npx rescript

# Ejecutar suite de pruebas / Run test suite
npm test
```

## 📄 Configuración clave / Key Configuration

- **`rescript.json`**: Define el paquete con dependencias `@rescript/core` y `@glennsl/rescript-jest`, compilando con sufijo `.res.mjs` y formato de módulo ES6.
- **`jest.config.js`**: Configurado con `testMatch: ["**/test/*_tests.res.mjs"]` y transformación de archivos JS con `babel-jest`.
- **`package.json`**: Declara el script `"test": "rescript && jest"` que asegura la compilación previa antes de ejecutar Jest.

## 🚀 Compilación y ejecución / Build & Run

```bash
npx rescript
npm test
```

**Salida real / Actual output:**

```text
> data_structures_basics@1.0.0 test
> rescript && jest

>>>> Start compiling
Dependency on @rescript/core
Dependency on @glennsl/rescript-jest
Dependency Finished
>>>> Finish compiling 13 mseconds
PASS test/data_structures_basics_tests.res.mjs
  Node
    ✓ should expose the value and an absent link after make (2 ms)
    ✓ should reach the linked node after setNext
  LinkedList
    ✓ should satisfy an empty state (1 ms)
    ✓ should satisfy insertion at both ends
    ✓ should satisfy deletion of the first occurrence (1 ms)
    ✓ should satisfy deletion of an absent value
    ✓ should satisfy emptying the list
  Stack
    ✓ should satisfy an empty state and a failed removal
    ✓ should satisfy LIFO order and a non-mutating peek
    ✓ should satisfy removal and reuse
    ✓ should satisfy an empty state after removal
  Queue
    ✓ should satisfy an empty state and a failed removal (1 ms)
    ✓ should satisfy FIFO order and a non-mutating peek
    ✓ should satisfy removal and reuse
    ✓ should satisfy an empty state after removal (1 ms)

Test Suites: 1 passed, 1 total
Tests:       15 passed, 15 total
Snapshots:   0 total
Time:        0.31 s, estimated 1 s
Ran all test suites.
```

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node.make` | `int → Node.t` | `O(1)` | Inicializa nodo con valor y enlace ausente (`None`) / Initializes node with value and absent link (`None`) |
| `Node.value` | `Node.t → int` | `O(1)` | Observa el valor almacenado / Inspects the stored value |
| `Node.next` | `Node.t → option<Node.t>` | `O(1)` | Obtiene el enlace al siguiente nodo / Gets the link to the next node |
| `Node.setNext` | `(Node.t, Node.t) → unit` | `O(1)` | Actualiza el enlace en sitio (`mutable next`) / Updates link in place (`mutable next`) |
| `LinkedList.init` | `unit → LinkedList.t` | `O(1)` | Construye lista vacía (`head: None`, `tail: None`, `count: 0`) / Constructs empty list |
| `LinkedList.isEmpty` | `LinkedList.t → bool` | `O(1)` | Comprueba si `count == 0` / Checks if `count == 0` |
| `LinkedList.size` | `LinkedList.t → int` | `O(1)` | Devuelve `count` / Returns `count` |
| `LinkedList.head` | `LinkedList.t → int` | `O(1)` | Devuelve valor de la cabeza o `-1` si está vacía / Returns head value or `-1` if empty |
| `LinkedList.insertHead` | `(LinkedList.t, int) → unit` | `O(1)` | Inserta al inicio y actualiza `head` (y `tail` si vacía) / Inserts at head and updates `head` (and `tail` if empty) |
| `LinkedList.insertTail` | `(LinkedList.t, int) → unit` | `O(1)` | Inserta al final usando puntero `tail` / Inserts at end using `tail` pointer |
| `LinkedList.delete` | `(LinkedList.t, int) → bool` | `O(n)` | Elimina la primera aparición de `value` / Deletes first occurrence of `value` |
| `Stack.init` | `unit → Stack.t` | `O(1)` | Construye pila vacía (`top: None`, `count: 0`) / Constructs empty stack |
| `Stack.isEmpty` | `Stack.t → bool` | `O(1)` | Comprueba si `count == 0` / Checks if `count == 0` |
| `Stack.size` | `Stack.t → int` | `O(1)` | Devuelve `count` / Returns `count` |
| `Stack.push` | `(Stack.t, int) → unit` | `O(1)` | Enlaza nuevo nodo en `top` e incrementa contador / Links new node at `top` and increments counter |
| `Stack.pop` | `Stack.t → int` | `O(1)` | Extrae y desvincula `top`, devuelve valor o `-1` / Pops `top`, returns value or `-1` |
| `Stack.peek` | `Stack.t → int` | `O(1)` | Observa valor en `top` sin extraer, o `-1` / Inspects value at `top` without popping, or `-1` |
| `Queue.init` | `unit → Queue.t` | `O(1)` | Construye cola vacía (`front: None`, `rear: None`, `count: 0`) / Constructs empty queue |
| `Queue.isEmpty` | `Queue.t → bool` | `O(1)` | Comprueba si `count == 0` / Checks if `count == 0` |
| `Queue.size` | `Queue.t → int` | `O(1)` | Devuelve `count` / Returns `count` |
| `Queue.enqueue` | `(Queue.t, int) → unit` | `O(1)` | Enlaza nuevo nodo en `rear` / Links new node at `rear` |
| `Queue.dequeue` | `Queue.t → int` | `O(1)` | Extrae y desvincula `front`, devuelve valor o `-1` / Dequeues `front`, returns value or `-1` |
| `Queue.peek` | `Queue.t → int` | `O(1)` | Observa valor en `front` sin extraer, o `-1` / Inspects value at `front` without dequeuing, or `-1` |

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Registros mutables (`record` con campos `mutable`) / Mutable records | Estructuras puramente funcionales e inmutables / Purely functional immutable structures | Cumple directamente con el pseudocódigo imperativo del contrato (`O(1)` real en inserción al final y mutación in-place sin necesidad de clonar referencias). |
| Módulos ReScript independientes por estructura (`Node`, `LinkedList`, `Stack`, `Queue`) / Separate ReScript modules per structure | Todo en un único archivo `data_structures_basics.res` / All in a single `data_structures_basics.res` file | Convención idiomática de ReScript donde cada archivo `.res` es un módulo natural; permite reutilizar `Node` limpiamente sin colisiones de nombres. |
| Puntero `tail` en `LinkedList` / `tail` pointer in `LinkedList` | Recorrer la lista hasta el final en `insert_tail` / Traverse to end on `insert_tail` | Garantiza complejidad `O(1)` en `insert_tail` como exige la especificación. |

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `Node.init(value)` / `LinkedList.init()` | Funciones constructores `Node.make(value)` y `*.init()` en módulos / Constructor functions `Node.make(value)` and `*.init()` in modules | En ReScript no existen clases orientadas a objetos; los tipos abstractos y constructores se expresan como funciones asociadas al módulo del tipo `t`. Por convención idiomática, `Node` usa `make`. |
| `next = absent` | `next: option<Node.t> = None` | Ausencia nativa y segura en el sistema de tipos de ReScript; no existe `null` o puntero crudo no tipado. |
| `run_tests.ext` | `npm test` ejecutando `jest` / `npm test` running `jest` | El ecosistema JavaScript/ReScript utiliza Jest como ejecutor de pruebas estándar sin scripts wrapper adicionales. |
| Nomenclatura camelCase (`insertHead`, `isEmpty`, `setNext`) | Adaptación de nombres desde snake_case del pseudocódigo / camelCase naming adaptation from pseudocode | Convención de nombrado estándar de ReScript y el ecosistema OCaml/JS. |

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `LinkedList.head` | Lista vacía (`count == 0`) / Empty list | `-1` | `LinkedList.head(list) == -1` |
| `LinkedList.delete` | Elemento no encontrado / Element not found | `false` | `LinkedList.delete(list, 99) == false` |
| `Stack.pop` | Pila vacía (`count == 0`) / Empty stack | `-1` | `Stack.pop(stack) == -1` |
| `Stack.peek` | Pila vacía (`count == 0`) / Empty stack | `-1` | `Stack.peek(stack) == -1` |
| `Queue.dequeue` | Cola vacía (`count == 0`) / Empty queue | `-1` | `Queue.dequeue(queue) == -1` |
| `Queue.peek` | Cola vacía (`count == 0`) / Empty queue | `-1` | `Queue.peek(queue) == -1` |
| Entrada nula / Null input | No representable / Not representable | No aplica / Not applicable | En ReScript el tipo `int` no es nullable; no es posible pasar un valor nulo. |

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Node: Inicializar y observar valor/enlace / Node: Initialize and observe value/link | Sí / Yes | `test/data_structures_basics_tests.res:39` | Verifica `Node.value` y `Node.next == None` tras `Node.make(10)`. |
| Node: Inicializar otro nodo, enlazar y recorrer / Node: Initialize another node, link and traverse | Sí / Yes | `test/data_structures_basics_tests.res:45` | Verifica `Node.setNext` y la navegación a través del puntero `next`. |
| LinkedList: Estado vacío / LinkedList: Empty state | Sí / Yes | `test/data_structures_basics_tests.res:72` | Comprueba `isEmpty == true`, `size == 0`, `head == -1`. |
| LinkedList: Insertar por ambos extremos / LinkedList: Insert at both ends | Sí / Yes | `test/data_structures_basics_tests.res:86` | Inserta 10 (tail), 20 (tail), 5 (head), 10 (tail); verifica tamaño 4 y cabeza 5. |
| LinkedList: Eliminar primera aparición / LinkedList: Delete first occurrence | Sí / Yes | `test/data_structures_basics_tests.res:97` | Elimina 10, retorna `true`, tamaño 3, cabeza 5. |
| LinkedList: Valor ausente / LinkedList: Absent value | Sí / Yes | `test/data_structures_basics_tests.res:107` | Intenta eliminar 99, retorna `false`, tamaño 3, cabeza 5. |
| LinkedList: Vaciar / LinkedList: Empty the list | Sí / Yes | `test/data_structures_basics_tests.res:116` | Elimina 5, 20, 10 sucesivamente; verifica lista vacía y `head == -1`. |
| Stack: Estado vacío y extracción fallida / Stack: Empty state and failed removal | Sí / Yes | `test/data_structures_basics_tests.res:147` | Comprueba `isEmpty == true`, `size == 0`, `peek == -1`, `pop == -1`. |
| Stack: LIFO y `peek` no mutante / Stack: LIFO and non-mutating `peek` | Sí / Yes | `test/data_structures_basics_tests.res:160` | Inserta 10, 20, 30; `peek == 30`, `size == 3`. |
| Stack: Extracción y reutilización / Stack: Removal and reuse | Sí / Yes | `test/data_structures_basics_tests.res:171` | `pop(30)`, `push(40)`, `pop(40)`, `pop(20)`, `pop(10)`; vacía con tamaño 0. |
| Stack: Vacío tras extracción / Stack: Empty after removal | Sí / Yes | `test/data_structures_basics_tests.res:191` | `pop` sobre vacía retorna `-1` y mantiene `isEmpty == true`. |
| Queue: Estado vacío y extracción fallida / Queue: Empty state and failed removal | Sí / Yes | `test/data_structures_basics_tests.res:213` | Comprueba `isEmpty == true`, `size == 0`, `peek == -1`, `dequeue == -1`. |
| Queue: FIFO y `peek` no mutante / Queue: FIFO and non-mutating `peek` | Sí / Yes | `test/data_structures_basics_tests.res:226` | Encola 10, 20, 30; `peek == 10`, `size == 3`. |
| Queue: Extracción y reutilización / Queue: Removal and reuse | Sí / Yes | `test/data_structures_basics_tests.res:237` | `dequeue(10)`, `enqueue(40)`, `dequeue(20)`, `dequeue(30)`, `dequeue(40)`; vacía con tamaño 0. |
| Queue: Vacío tras extracción / Queue: Empty after removal | Sí / Yes | `test/data_structures_basics_tests.res:257` | `dequeue` sobre vacía retorna `-1` y mantiene `isEmpty == true`. |

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Dominio de valores limitado a enteros no negativos / Values domain restricted to non-negative integers | Al utilizar `-1` como indicador natural de fallo en `head`, `pop`, `peek`, `dequeue`, el valor `-1` no puede almacenarse como dato válido. | Fase 4 (Abstraction & Persistence) introducirá tipos de retorno explícitos `Option<T>` / `Result<T, E>`. |

## 📝 Notas de implementación / Implementation Notes

- **Mutabilidad y estado:** ReScript permite campos mutables mediante la palabra clave `mutable` en definiciones de tipos `record`. Tanto los punteros (`head`, `tail`, `top`, `front`, `rear`, `next`) como el contador `count` se mutan in-situ para cumplir con el contrato algorítmico y las cotas de complejidad `O(1)`.
- **Estructura compartida de `Node`:** `Stack` y `Queue` reutilizan de forma estricta el tipo `Node.t` definido en `src/Node.res`, sin delegar en `LinkedList` ni instanciar tipos de nodo duplicados.
- **Caso nulo:** En ReScript los enteros `int` son tipos de valor primitivos no anulables. Por tanto, no existe el concepto de pasar `null` como entero; la ausencia sólo se manifiesta a nivel de punteros opcionales (`option<Node.t>`), lo que garantiza seguridad de tipos en tiempo de compilación.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](../../../../docs/core/algorithms/06_Data_Structures_Basics.md) |
| Módulo homologado del lenguaje / Homologated module | [`rescript/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [https://rescript-lang.org/docs/manual/latest/overview](https://rescript-lang.org/docs/manual/latest/overview) |
