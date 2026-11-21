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
 * Cuerpos centinela: la implementación sigue en este archivo con búsqueda
 * manual en el registro enlazado, pertenencia propia e inserción ordenada de
 * vecinos, sin rutinas de búsqueda ni de ordenamiento de la biblioteca.
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

let rec findVertex = (label: int, node: option<graphNode>): option<graphNode> =>
  switch node {
  | None => None
  | Some(n) =>
    label == n.label ? Some(n) : findVertex(label, n.nextVertex)
  }

/** Pertenencia manual: la Fase 1 no admite rutinas de búsqueda de la
 * biblioteca para el paso interno. */
let hasNeighbor = (label: int, neighbors: array<int>): bool => {
  let rec loop = (index: int): bool =>
    if index >= Array.length(neighbors) {
      false
    } else {
      switch neighbors[index] {
      | Some(current) => current == label || loop(index + 1)
      | None => false
      }
    }
  loop(0)
}

/** Inserción ordenada y sin duplicados, construida a mano. */
let insertNeighbor = (label: int, neighbors: array<int>): array<int> => {
  let result = []
  let inserted = ref(false)
  neighbors->Array.forEach(current => {
    if !inserted.contents && label < current {
      result->Array.push(label)
      inserted := true
    }
    result->Array.push(current)
  })
  if !inserted.contents {
    result->Array.push(label)
  }
  result
}

/** Copia la cadena sustituyendo la adyacencia del vértice indicado. */
let rec setNeighbors = (
  label: int,
  neighbors: array<int>,
  node: option<graphNode>,
): option<graphNode> =>
  switch node {
  | None => None
  | Some(n) =>
    if label == n.label {
      Some({...n, neighbors})
    } else {
      switch setNeighbors(label, neighbors, n.nextVertex) {
      | None => Some(n)
      | Some(newNext) => Some({...n, nextVertex: Some(newNext)})
      }
    }
  }

/** Registra el vértice; un duplicado también es éxito y conserva la
 * adyacencia. */
let addVertex = (graph: t, label: int): t =>
  switch findVertex(label, graph.vertices) {
  | Some(_) => graph
  | None =>
    let newVertex = {label, neighbors: [], nextVertex: graph.vertices}
    {
      vertices: Some(newVertex),
      vertexCount: graph.vertexCount + 1,
      edgeCount: graph.edgeCount,
    }
  }

/** Arista dirigida `from -> to`; `None` cuando falta un extremo. */
let addEdge = (graph: t, from: int, to: int): option<t> =>
  switch findVertex(from, graph.vertices) {
  | None => None
  | Some(source) =>
    switch findVertex(to, graph.vertices) {
    | None => None
    | Some(_) =>
      if hasNeighbor(to, source.neighbors) {
        Some(graph)
      } else {
        Some({
          vertices: setNeighbors(
            from,
            insertNeighbor(to, source.neighbors),
            graph.vertices,
          ),
          vertexCount: graph.vertexCount,
          edgeCount: graph.edgeCount + 1,
        })
      }
    }
  }

/** Verdadero si existe la arista dirigida `from -> to`. */
let hasEdge = (graph: t, from: int, to: int): bool =>
  switch findVertex(from, graph.vertices) {
  | None => false
  | Some(source) => hasNeighbor(to, source.neighbors)
  }


/** Vecinos ordenados: `None` si no está registrado, `Some([])` si está
 * aislado. */
let getNeighbors = (graph: t, label: int): option<array<int>> =>
  switch findVertex(label, graph.vertices) {
  | None => None
  | Some(n) => Some(n.neighbors)
  }

/** Verdadero cuando no hay ningún vértice registrado. */
let isEmpty = (graph: t): bool => graph.vertexCount == 0

/** Número de vértices registrados. */
let vertexCount = (graph: t): int => graph.vertexCount

/** Número de aristas registradas. */
let edgeCount = (graph: t): int => graph.edgeCount
