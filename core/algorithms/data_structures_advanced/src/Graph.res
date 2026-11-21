/**
 * Grafo dirigido: registro canónico enlazado de vértices y contadores propios.
 *
 * Contrato del módulo `data_structures_advanced` — especificación
 * 07_Data_Structures_Advanced. Variante V2 (inmutable): las altas devuelven el
 * grafo resultante y el fallo no muta ni crea vértices.
 *
 * Indicadores: `addEdge` devuelve `Some(graph)` cuando la arista se añade o ya
 * estaba y `None` cuando falta un extremo; `getNeighbors` devuelve
 * `option<array<int>>`, con `None` para un vértice no registrado y `Some([])`
 * para uno aislado, que es lo que exige la especificación. `graphNode` es
 * interno: no se expone su representación.
 *
 * Cuerpos centinela: la implementación llega en el paso siguiente; hasta
 * entonces las operaciones devuelven el valor neutro de su tipo.
 */

type rec graphNode = {
  label: int,
  neighbors: array<int>,
  nextVertex: option<graphNode>,
}

type t = {
  vertices: option<graphNode>,
  vertexCount: int,
  edgeCount: int,
}

/** Grafo vacío utilizable: sin vértices y ambos contadores a cero (`init`). */
let init = (): t => {vertices: None, vertexCount: 0, edgeCount: 0}

/** Registra el vértice; un duplicado también es éxito y conserva la
 * adyacencia. */
let addVertex = (graph: t, _label: int): t => graph

/** Arista dirigida `from -> to`; `None` cuando falta un extremo. */
let addEdge = (_graph: t, _from: int, _to: int): option<t> => None

/** Verdadero si existe la arista dirigida `from -> to`. */
let hasEdge = (_graph: t, _from: int, _to: int): bool => false

/** Vecinos ordenados: `None` si no está registrado, `Some([])` si está
 * aislado. */
let getNeighbors = (_graph: t, _label: int): option<array<int>> => None

/** Verdadero cuando no hay ningún vértice registrado. */
let isEmpty = (graph: t): bool => graph.vertexCount == 0

/** Número de vértices registrados. */
let vertexCount = (graph: t): int => graph.vertexCount

/** Número de aristas registradas. */
let edgeCount = (graph: t): int => graph.edgeCount
