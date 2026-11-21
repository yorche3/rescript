# Data Structures Advanced — ReScript

Implementación de la especificación [07_Data_Structures_Advanced](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) en **ReScript**, con un enfoque manual y minimalista.

**ES:** Implementación de nodo de árbol binario (`TreeNode`), árbol binario de búsqueda (`BinaryTree`) y grafo dirigido (`Graph`) con registro enlazado canónico de vértices y adyacencia ordenada manual, bajo la variante V2 inmutable y verificada con **@glennsl/rescript-jest + Jest**.

**EN:** Implementation of binary tree node (`TreeNode`), binary search tree (`BinaryTree`), and directed graph (`Graph`) with a canonical linked vertex registry and manual sorted adjacency, following the immutable V2 variant and verified using **@glennsl/rescript-jest + Jest**.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| `src/TreeNode.res` | Nodo inmutable del árbol binario con enlaces opcionales (`value`, `left`, `right`, `withLeft`, `withRight`) / Immutable binary tree node with optional links (`value`, `left`, `right`, `withLeft`, `withRight`) |
| `src/BinaryTree.res` | Árbol binario de búsqueda inmutable con raíz opcional y contador (`init`, `insert`, `contains`, `isEmpty`, `size`) / Immutable binary search tree with optional root and count (`init`, `insert`, `contains`, `isEmpty`, `size`) |
| `src/Graph.res` | Grafo dirigido inmutable con registro canónico enlazado y adyacencia ordenada (`init`, `addVertex`, `addEdge`, `hasEdge`, `getNeighbors`, `isEmpty`, `vertexCount`, `edgeCount`) / Immutable directed graph with canonical linked registry and sorted adjacency (`init`, `addVertex`, `addEdge`, `hasEdge`, `getNeighbors`, `isEmpty`, `vertexCount`, `edgeCount`) |
| `test/data_structures_advanced_tests.res` | Suite de pruebas unitarias cubriendo los 24 casos de la especificación / Unit test suite covering all 24 specification test cases |
| `rescript.json` | Configuración del compilador ReScript (ES modules, dependencias de pruebas) / ReScript compiler configuration (ES modules, test dependencies) |
| `jest.config.js` | Configuración de Jest para descubrir y ejecutar archivos `.res.mjs` / Jest configuration to discover and run `.res.mjs` files |
| `babel.config.js` | Configuración de Babel para transformación de módulos JS / Babel configuration for JS module transforms |
| `package.json` | Manifiesto de npm con scripts y dependencias de desarrollo / npm manifest with scripts and development dependencies |
| `.gitignore` | Archivos generados y artefactos de compilación excluidos / Ignored build artifacts and generated files |

**Nota de desviación en la estructura / Layout deviation note:**
- **ES:** La especificación propone un único archivo `src/data_structures_advanced.ext` y un script `run_tests.ext`. En ReScript, la modularidad canónica asigna un archivo por módulo de primer nivel (`TreeNode.res`, `BinaryTree.res`, `Graph.res`), facilitando la reutilización y el aislamiento de tipos. Jest actúa como runner nativo ejecutado mediante `npm test`, haciendo innecesario un script `run_tests` separado.
- **EN:** The specification proposes a single `src/data_structures_advanced.ext` file and a `run_tests.ext` runner. In ReScript, idiomatic modularity maps one file per top-level module (`TreeNode.res`, `BinaryTree.res`, `Graph.res`), facilitating reuse and type isolation. Jest acts as the native runner via `npm test`, making a separate `run_tests` script unnecessary.

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto sigue el flujo estándar de ReScript compilando a módulos JavaScript ES6 (`.res.mjs`) y ejecutando pruebas con Jest. Adopta la variante funcional e inmutable (V2): los nodos y estructuras se representan mediante registros (`record`), donde las modificaciones devuelven nuevas instancias reconstruyendo las rutas necesarias (*persistent path copying*) sin mutación *in-place*.

**EN:** The project follows the standard ReScript workflow compiling to ES6 JavaScript modules (`.res.mjs`) and running tests with Jest. It adopts the functional immutable variant (V2): nodes and structures are represented as records, where updates return new instances by reconstructing paths (*persistent path copying*) without *in-place* mutation.

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

- **`rescript.json`**: Especifica `"package-specs": [{"module": "es6", "in-source": true, "suffix": ".res.mjs"}]`, con dependencias `@rescript/core` y `@glennsl/rescript-jest`.
- **`jest.config.js`**: Patrón `testMatch: ["**/test/*_tests.res.mjs"]`, utilizando `babel-jest` para transformar sintaxis ES6 generada.
- **`package.json`**: Declara el script `"test": "rescript && jest"` que asegura la compilación previa antes de ejecutar Jest.

## 🚀 Compilación y ejecución / Build & Run

```bash
npx rescript
npm test
```

**Salida real / Actual output:**

```text
>>>> Start compiling
Dependency on @rescript/core
Dependency on @glennsl/rescript-jest
Dependency Finished
>>>> Finish compiling 12 mseconds

> data_structures_advanced@1.0.0 test
> rescript && jest

>>>> Start compiling
Dependency on @rescript/core
Dependency on @glennsl/rescript-jest
Dependency Finished
>>>> Finish compiling 11 mseconds
PASS test/data_structures_advanced_tests.res.mjs
  TreeNode
    ✓ should expose the value after make (2 ms)
    ✓ should have absent initial links (1 ms)
    ✓ should link two children
    ✓ should traverse each link (1 ms)
    ✓ should unlink children preserving the value and the other link
    ✓ should return a new node on withLeft leaving the original unchanged
  BinaryTree
    ✓ should be empty after init
    ✓ should insert the root
    ✓ should insert a lower and a higher value (1 ms)
    ✓ should hold multilevel branches
    ✓ should not contain a missing value in a nonempty tree (1 ms)
    ✓ should treat a duplicate insertion as idempotent
    ✓ should accept ordered insertions
  Graph
    ✓ should be empty after init (1 ms)
    ✓ should hold an isolated vertex
    ✓ should add a directed edge between nonconsecutive labels
    ✓ should preserve adjacency on a duplicate vertex (1 ms)
    ✓ should treat a duplicate edge as idempotent
    ✓ should reject missing endpoints without mutation
    ✓ should list sorted neighbours and keep counts (1 ms)
    ✓ should report a missing-edge query as failure
    ✓ should distinguish missing-vertex neighbours from empty neighbours
    ✓ should accept a self-loop and its duplicate
    ✓ should isolate the neighbour result from the graph

Test Suites: 1 passed, 1 total
Tests:       24 passed, 24 total
Snapshots:   0 total
Time:        0.27 s, estimated 1 s
Ran all test suites.
```

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `TreeNode.make` | `int → TreeNode.t` | `O(1)` | Inicializa nodo inmutable con valor y enlaces ausentes (`None`) / Initializes immutable node with value and absent links (`None`) |
| `TreeNode.value` | `TreeNode.t → int` | `O(1)` | Observa el valor almacenado / Inspects the stored value |
| `TreeNode.left` | `TreeNode.t → option<TreeNode.t>` | `O(1)` | Observa enlace izquierdo / Inspects left link |
| `TreeNode.right` | `TreeNode.t → option<TreeNode.t>` | `O(1)` | Observa enlace derecho / Inspects right link |
| `TreeNode.withLeft` | `(TreeNode.t, option<TreeNode.t>) → TreeNode.t` | `O(1)` | Copia funcional con nuevo hijo izquierdo / Functional copy with new left child |
| `TreeNode.withRight` | `(TreeNode.t, option<TreeNode.t>) → TreeNode.t` | `O(1)` | Copia funcional con nuevo hijo derecho / Functional copy with new right child |
| `BinaryTree.init` | `unit → BinaryTree.t` | `O(1)` | Árbol vacío (`root: None`, `count: 0`) / Empty tree (`root: None`, `count: 0`) |
| `BinaryTree.isEmpty` | `BinaryTree.t → bool` | `O(1)` | Comprueba si `count == 0` / Checks if `count == 0` |
| `BinaryTree.size` | `BinaryTree.t → int` | `O(1)` | Devuelve `count` / Returns `count` |
| `BinaryTree.insert` | `(BinaryTree.t, int) → BinaryTree.t` | `O(h)` | Inserción funcional en ABB; duplicado no altera tamaño / Functional BST insertion; duplicates do not increase size |
| `BinaryTree.contains` | `(BinaryTree.t, int) → bool` | `O(h)` | Búsqueda según invariante ABB / Search following BST invariant |
| `Graph.init` | `unit → Graph.t` | `O(1)` | Grafo vacío (`vertices: None`, `vertexCount: 0`, `edgeCount: 0`) / Empty graph |
| `Graph.isEmpty` | `Graph.t → bool` | `O(1)` | Comprueba si `vertexCount == 0` / Checks if `vertexCount == 0` |
| `Graph.vertexCount` | `Graph.t → int` | `O(1)` | Devuelve `vertexCount` / Returns `vertexCount` |
| `Graph.edgeCount` | `Graph.t → int` | `O(1)` | Devuelve `edgeCount` / Returns `edgeCount` |
| `Graph.addVertex` | `(Graph.t, int) → Graph.t` | `O(V)` | Registra vértice en registro canónico si no existe / Registers vertex in canonical registry if absent |
| `Graph.addEdge` | `(Graph.t, int, int) → option<Graph.t>` | `O(V + d(u))` | Añade arista dirigida ordenada; `None` si falta un extremo / Adds sorted directed edge; `None` if endpoint missing |
| `Graph.hasEdge` | `(Graph.t, int, int) → bool` | `O(V + d(u))` | Comprueba si existe arista dirigida `from -> to` / Checks if directed edge `from -> to` exists |
| `Graph.getNeighbors` | `(Graph.t, int) → option<array<int>>` | `O(V)` | Devuelve copia de vecinos ordenados o `None` si vértice ausente / Returns copy of sorted neighbours or `None` if vertex missing |

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Inmutabilidad funcional (Variante V2) / Functional immutability (Variant V2) | Mutabilidad *in-place* mediante registros con campos `mutable` (como en `data_structures_basics`) | La especificación autoriza expresamente la variante inmutable V2 (`withLeft`, `withRight`, `insertNode` funcional y `addEdge` devolviendo `option<t>`). Facilita el razonamiento puro, la seguridad de concurrencia y la reutilización sin efectos colaterales. |
| Valor embebido en `TreeNode` y `graphNode` / Embedded value in `TreeNode` and `graphNode` | Tipo `Node` base abstracto con subtipado o simulación de herencia | ReScript carece de clases y herencia tradicional orientada a objetos. La especificación permite explícitamente «valor embebido» (composición directa del campo `value` / `label` en el registro hijo) como alternativa válida a la herencia. |
| Registro canónico enlazado manual en `Graph` / Manual linked canonical registry in `Graph` | Uso de `Map`, `Dict` o tablas hash de la biblioteca estándar | Cumplimiento estricto del mandato de la especificación: el registro de vértices debe construirse y recorrerse manualmente con enlaces (`nextVertex`), garantizando cotas `O(V)` sin delegar en índices optimizados. |
| Almacenamiento y ordenación manual de adyacencias / Manual storage and sorted insertion of adjacencies | `Belt.List.sort` o colecciones ordenadas automáticas | La especificación exige inserción ordenada y comprobación de duplicados manual (`hasNeighbor`, `insertNeighbor`) sin delegar la ordenación en algoritmos de biblioteca. |

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `Node(value)` como tipo base con herencia / `Node(value)` base type with inheritance | Valor embebido (`value: int` en `TreeNode.t` y `label: int` en `graphNode`) sin tipo base `Node` separado / Embedded value (`value: int` in `TreeNode.t` and `label: int` in `graphNode`) without separate base type | ReScript no admite herencia de clases orientada a objetos; la especificación permite expresamente la forma de valor embebido. |
| `set_left(node)`, `set_right(node)` imperativos / Imperative `set_left(node)`, `set_right(node)` | `withLeft(node, left)`, `withRight(node, right)` funcionales devolviendo una nueva instancia con `...node` / Functional `withLeft(node, left)`, `withRight(node, right)` returning new instance with `...node` | Variante inmutable V2 autorizada por la especificación para lenguajes funcionales o configuraciones inmutables. |
| `absent` como indicador de enlace ausente / `absent` as missing link indicator | `option<TreeNode.t> = None` y `option<graphNode> = None` | Sistema de tipos algebraicos nativo de ReScript; no existen punteros nulos sin tipar. |
| `Graph.addEdge(u, v)` con fallo booleano o mutación in-place / `Graph.addEdge(u, v)` with boolean failure or in-place mutation | Devuelve `option<Graph.t>` (`Some(nuevoGrafo)` en éxito, `None` si falta un extremo) / Returns `option<Graph.t>` (`Some(newGraph)` on success, `None` if endpoint missing) | En la variante inmutable, la función debe devolver el grafo resultante preservando pureza; `None` modela el fallo de extremo inexistente sin alterar el grafo. |
| `Graph.get_neighbors(u)` devolviendo secuencia o fallo / `Graph.get_neighbors(u)` returning sequence or failure | Devuelve `option<array<int>>` (`None` si el vértice no existe, `Some([])` si está aislado) / Returns `option<array<int>>` (`None` if vertex missing, `Some([])` if isolated) | Distingue formalmente un vértice inexistente (`None`) de un vértice aislado con 0 vecinos (`Some([])`), tal como exige el contrato. |
| Nomenclatura camelCase (`withLeft`, `addVertex`, `isEmpty`) / camelCase naming | Adaptación desde snake_case del pseudocódigo / Adaptation from pseudocode snake_case | Convención de nombrado estándar de ReScript y el ecosistema OCaml/JS. |
| `run_tests.ext` | `npm test` ejecutando Jest / `npm test` running Jest | El ecosistema ReScript/JavaScript utiliza Jest como ejecutor estándar integrado. |

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `TreeNode.left` / `TreeNode.right` | Enlace ausente / Absent link | `None` | `TreeNode.left(node) == None` |
| `BinaryTree.contains` | Valor no encontrado en el árbol / Value not in tree | `false` | `BinaryTree.contains(tree, 99) == false` |
| `BinaryTree.insert` | Capacidad o límite contractual / Contractual limit | Sin fallo (éxito idempotente) / No failure (idempotent success) | `BinaryTree.insert(tree, 30)` conserva tamaño si ya existe |
| `Graph.addEdge` | Extremo de arista inexistente / Missing endpoint | `None` | `Graph.addEdge(graph, 10, 99) == None` |
| `Graph.hasEdge` | Arista inexistente o extremo no registrado / Missing edge or vertex | `false` | `Graph.hasEdge(graph, 10, 30) == false` |
| `Graph.getNeighbors` | Vértice no registrado / Missing vertex | `None` | `Graph.getNeighbors(graph, 99) == None` |
| Entrada nula / Null input | No representable / Not representable | No aplica / Not applicable | En ReScript los tipos `int` son primitivos no anulables en tiempo de compilación. |

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| TreeNode: Crear un nodo de árbol / Create a tree node | Sí / Yes | `test/data_structures_advanced_tests.res:37` | Verifica `TreeNode.value(node) == 10` tras `make(10)`. |
| TreeNode: Enlaces iniciales ausentes / Absent initial links | Sí / Yes | `test/data_structures_advanced_tests.res:43` | Comprueba `left == None` y `right == None`. |
| TreeNode: Enlazar dos hijos / Link two children | Sí / Yes | `test/data_structures_advanced_tests.res:52` | Enlaza hijos 20 y 30 con `withLeft` y `withRight`; observa valores hijos. |
| TreeNode: Recorrer cada enlace / Traverse each link | Sí / Yes | `test/data_structures_advanced_tests.res:64` | Sigue `left` y `right` hacia hijos y verifica que sus subenlaces sean `None`. |
| TreeNode: Desenlazar hijos / Unlink children | Sí / Yes | `test/data_structures_advanced_tests.res:85` | `withLeft(None)` conserva valor 10 e hijo derecho 30; `withRight(None)` deja ambos ausentes. |
| TreeNode: Adaptación inmutable (si aplica) / Immutable adaptation | Sí / Yes | `test/data_structures_advanced_tests.res:106` | Comprueba que `withLeft` devuelva un nodo nuevo sin mutar el original. |
| BinaryTree: Crear vacío / Create empty | Sí / Yes | `test/data_structures_advanced_tests.res:136` | `isEmpty == true`, `size == 0`, `contains(50) == false`. |
| BinaryTree: Insertar la raíz / Insert the root | Sí / Yes | `test/data_structures_advanced_tests.res:145` | Inserta 50; `size == 1`, `isEmpty == false`, `contains(50) == true`. |
| BinaryTree: Insertar menor y mayor / Insert lower and higher | Sí / Yes | `test/data_structures_advanced_tests.res:158` | Inserta 50, 30, 70; tamaño 3 y los tres valores presentes. |
| BinaryTree: Ramas de varios niveles / Multilevel branches | Sí / Yes | `test/data_structures_advanced_tests.res:168` | Inserta 50, 30, 70, 20, 40; tamaño 5 y pertenencia de todos. |
| BinaryTree: Valor ausente en árbol no vacío / Missing value in nonempty tree | Sí / Yes | `test/data_structures_advanced_tests.res:178` | `contains(99) == false` sobre árbol con 50; conserva tamaño 1. |
| BinaryTree: Duplicado idempotente / Idempotent duplicate | Sí / Yes | `test/data_structures_advanced_tests.res:191` | Inserta 50, 30, 70, 30; tamaño 3 y pertenencia preservada. |
| BinaryTree: Inserciones ordenadas / Ordered insertions | Sí / Yes | `test/data_structures_advanced_tests.res:201` | Inserta 20, 30, 40, 50, 70; tamaño 5, pertenencia de todos y `contains(99) == false`. |
| Graph: Crear vacío / Create empty | Sí / Yes | `test/data_structures_advanced_tests.res:242` | `isEmpty == true`, `vertexCount == 0`, `edgeCount == 0`, `hasEdge == false`, `getNeighbors == None`. |
| Graph: Vértice aislado / Isolated vertex | Sí / Yes | `test/data_structures_advanced_tests.res:256` | Inserta vértice 10; `isEmpty == false`, 1 vértice, 0 aristas, `getNeighbors == Some([])`. |
| Graph: Etiquetas no consecutivas y arista dirigida / Nonconsecutive labels and directed edge | Sí / Yes | `test/data_structures_advanced_tests.res:265` | Vértices 10, 70; `addEdge(10, 70)`; `hasEdge(10, 70) == true`, `hasEdge(70, 10) == false`, 2 vértices, 1 arista. |
| Graph: Vértice duplicado conserva adyacencia / Duplicate vertex preserves adjacency | Sí / Yes | `test/data_structures_advanced_tests.res:279` | Vértices 10, 30; arista `(10, 30)`; `addVertex(10)`; conserva 2 vértices, 1 arista y vecinos `[30]`. |
| Graph: Arista duplicada / Duplicate edge | Sí / Yes | `test/data_structures_advanced_tests.res:289` | Arista `(10, 30)` añadida dos veces; idempotente, 2 vértices, 1 arista y vecinos `[30]`. |
| Graph: Extremo inexistente sin mutación / Missing endpoint without mutation | Sí / Yes | `test/data_structures_advanced_tests.res:299` | Cuatro intentos fallidos con vértices inexistentes devuelven `None`; no mutan el grafo (2 vértices, 1 arista). |
| Graph: Vecinos ordenados y contadores / Sorted neighbours and counts | Sí / Yes | `test/data_structures_advanced_tests.res:331` | Inserta aristas desordenadas en 10; vecinos resultan `[30, 50, 70]`; contadores (4, 4). |
| Graph: Consulta de arista ausente / Missing-edge query | Sí / Yes | `test/data_structures_advanced_tests.res:358` | `hasEdge(10, 30) == false` en grafo sin aristas; (2 vértices, 0 aristas). |
| Graph: Vecinos de vértice inexistente / Neighbours of missing vertex | Sí / Yes | `test/data_structures_advanced_tests.res:367` | `getNeighbors(99) == None`, distinto de `getNeighbors(10) == Some([])`. |
| Graph: Bucle y duplicado / Self-loop and duplicate | Sí / Yes | `test/data_structures_advanced_tests.res:376` | `addEdge(10, 10)` dos veces; `hasEdge(10, 10) == true`, vecinos `[10]`, (1 vértice, 1 arista). |
| Graph: Aislamiento del resultado de vecinos / Neighbour-result isolation | Sí / Yes | `test/data_structures_advanced_tests.res:391` | Vecinos guardados de 10 permanecen inmutables tras añadir arista `(10, 50)` posterior. |

**Trazabilidad del agrupamiento / Grouping traceability:**
- `TreeNode / BinaryTree / Graph (Variante V2 inmutable) → 24 casos aplicables → 3 bloques lógicos (describe) → test/data_structures_advanced_tests.res → Jest (@glennsl/rescript-jest)`.

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Ausencia de balanceo automático en ABB / No self-balancing in BST | Inserciones estrictamente ordenadas producen árboles degenerados con altura `O(n)`. | El contrato contractual especifica explícitamente complejidad `O(h)` sin exigir balanceo (árboles balanceados tipo AVL o Red-Black corresponden a fases posteriores). |

## 📝 Notas de implementación / Implementation Notes

- **Variante V2 inmutable y persistencia estructural:** ReScript es un lenguaje funcional fuertemente tipado. La variante inmutable V2 utiliza reconstrucción funcional de rutas (*persistent path copying*) en registros (`record`). En `TreeNode`, `withLeft` y `withRight` utilizan `{ ...node, left }` creando copias superficiales en `O(1)`. En `BinaryTree`, `insertNode` reconstruye únicamente el camino desde la raíz hasta la hoja insertada en `O(h)`.
- **Registro de vértices y adyacencia manual:** `Graph` modela el registro canónico de vértices como una lista enlazada funcional (`nextVertex: option<graphNode>`), asegurando la complejidad requerida sin depender de mapas o diccionarios (`Map`/`Dict`). La pertenencia en adyacencia (`hasNeighbor`) y la inserción ordenada (`insertNeighbor`) se implementan mediante algoritmos directos sin algoritmos de ordenamiento de biblioteca estándar.
- **Manejo del caso nulo:** ReScript garantiza seguridad de tipos en tiempo de compilación. Los enteros `int` son tipos primitivos no anulables. La ausencia sólo existe explícitamente a través del constructor `None` del tipo `option<'a>`.

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
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`rescript/core/algorithms/data_structures_basics/`](../data_structures_basics/) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`rescript/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [https://rescript-lang.org/docs/manual/latest/overview](https://rescript-lang.org/docs/manual/latest/overview) |
