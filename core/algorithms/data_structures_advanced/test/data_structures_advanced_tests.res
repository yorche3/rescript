open Jest
open Expect

// Casos de prueba de la especificación 07_Data_Structures_Advanced.md
// (TreeNode: 6 casos, BinaryTree: 7 casos, Graph: 10 casos; 23 en total).
//
// Variante V2 inmutable: cada operación devuelve la estructura resultante, así que cada caso
// parte de una instancia recién creada con `init()`/`make` y ejecuta sus pasos en orden; no se
// comparte estado entre casos. Cada caso es un `test` y el ejecutor compartido compara la
// observación (una tupla con todos los pasos) con la salida esperada. El mensaje del contrato
// lo componen el `describe` y el nombre del `test` ("BinaryTree should ..."), porque Jest no
// admite mensaje en `expect`.
//
// Indicadores de fallo: ausencia de enlace = `None`; `BinaryTree.insert` no falla (duplicado
// también es éxito, así que "éxito" se observa con `contains`/`size`); `contains` y `hasEdge`
// devuelven `bool`; `Graph.addEdge` devuelve `Some(grafo)` en éxito y `None` en fallo;
// `Graph.getNeighbors` devuelve `None` para un vértice no registrado y `Some([])` para uno
// aislado. Un `None` de `addEdge` no cambia el grafo: el escenario conserva el anterior.
//
// Caso nulo: los valores son `int` no anulable; la ausencia solo aparece en los enlaces y en
// los indicadores `option`, cubiertos por los casos de cada operación.

let assert_case = (description, observe, expected) =>
  test(description, () => expect(observe())->toEqual(expected))

// ---------------------------------------------------------------------------
// TreeNode
// ---------------------------------------------------------------------------

let parent_value = 10
let left_child_value = 20
let right_child_value = 30

let value_of = node => node->Belt.Option.map(TreeNode.value)

describe("TreeNode", () => {
  assert_case(
    "should expose the value after make",
    () => TreeNode.make(parent_value)->TreeNode.value,
    parent_value,
  )

  assert_case(
    "should have absent initial links",
    () => {
      let node = TreeNode.make(parent_value)
      (node->TreeNode.left, node->TreeNode.right)
    },
    (None, None),
  )

  assert_case(
    "should link two children",
    () => {
      let parent =
        TreeNode.make(parent_value)
        ->TreeNode.withLeft(Some(TreeNode.make(left_child_value)))
        ->TreeNode.withRight(Some(TreeNode.make(right_child_value)))
      (parent->TreeNode.left->value_of, parent->TreeNode.right->value_of)
    },
    (Some(left_child_value), Some(right_child_value)),
  )

  assert_case(
    "should traverse each link",
    () => {
      let parent =
        TreeNode.make(parent_value)
        ->TreeNode.withLeft(Some(TreeNode.make(left_child_value)))
        ->TreeNode.withRight(Some(TreeNode.make(right_child_value)))
      let leftChild = parent->TreeNode.left
      let rightChild = parent->TreeNode.right
      (
        leftChild->value_of,
        rightChild->value_of,
        leftChild->Belt.Option.flatMap(TreeNode.left),
        leftChild->Belt.Option.flatMap(TreeNode.right),
        rightChild->Belt.Option.flatMap(TreeNode.left),
        rightChild->Belt.Option.flatMap(TreeNode.right),
      )
    },
    (Some(left_child_value), Some(right_child_value), None, None, None, None),
  )

  assert_case(
    "should unlink children preserving the value and the other link",
    () => {
      let linked =
        TreeNode.make(parent_value)
        ->TreeNode.withLeft(Some(TreeNode.make(left_child_value)))
        ->TreeNode.withRight(Some(TreeNode.make(right_child_value)))
      let withoutLeft = linked->TreeNode.withLeft(None)
      let withoutBoth = withoutLeft->TreeNode.withRight(None)
      (
        (
          withoutLeft->TreeNode.value,
          withoutLeft->TreeNode.left,
          withoutLeft->TreeNode.right->value_of,
        ),
        (withoutBoth->TreeNode.value, withoutBoth->TreeNode.left, withoutBoth->TreeNode.right),
      )
    },
    ((parent_value, None, Some(right_child_value)), (parent_value, None, None)),
  )

  assert_case(
    "should return a new node on withLeft leaving the original unchanged",
    () => {
      let original = TreeNode.make(parent_value)
      let updated = original->TreeNode.withLeft(Some(TreeNode.make(left_child_value)))
      (
        original->TreeNode.left,
        updated->TreeNode.left->value_of,
        updated->TreeNode.value,
      )
    },
    (None, Some(left_child_value), parent_value),
  )
})

// ---------------------------------------------------------------------------
// BinaryTree
// ---------------------------------------------------------------------------

let root_value = 50
let lower_value = 30
let higher_value = 70
let deep_lower_value = 20
let deep_middle_value = 40
let absent_value = 99

let insert_all = values => values->Belt.Array.reduce(BinaryTree.init(), BinaryTree.insert)
let all_contained = (tree, values) => values->Belt.Array.every(BinaryTree.contains(tree, _))

describe("BinaryTree", () => {
  assert_case(
    "should be empty after init",
    () => {
      let tree = BinaryTree.init()
      (BinaryTree.isEmpty(tree), BinaryTree.size(tree), BinaryTree.contains(tree, root_value))
    },
    (true, 0, false),
  )

  assert_case(
    "should insert the root",
    () => {
      let tree = insert_all([root_value])
      (
        BinaryTree.size(tree),
        BinaryTree.isEmpty(tree),
        BinaryTree.contains(tree, root_value),
      )
    },
    (1, false, true),
  )

  assert_case(
    "should insert a lower and a higher value",
    () => {
      let values = [root_value, lower_value, higher_value]
      let tree = insert_all(values)
      (BinaryTree.size(tree), all_contained(tree, values))
    },
    (3, true),
  )

  assert_case(
    "should hold multilevel branches",
    () => {
      let values = [root_value, lower_value, higher_value, deep_lower_value, deep_middle_value]
      let tree = insert_all(values)
      (BinaryTree.size(tree), all_contained(tree, values))
    },
    (5, true),
  )

  assert_case(
    "should not contain a missing value in a nonempty tree",
    () => {
      let tree = insert_all([root_value])
      (
        BinaryTree.contains(tree, absent_value),
        BinaryTree.size(tree),
        BinaryTree.contains(tree, root_value),
      )
    },
    (false, 1, true),
  )

  assert_case(
    "should treat a duplicate insertion as idempotent",
    () => {
      let values = [root_value, lower_value, higher_value]
      let tree = insert_all(Belt.Array.concat(values, [lower_value]))
      (BinaryTree.size(tree), all_contained(tree, values))
    },
    (3, true),
  )

  assert_case(
    "should accept ordered insertions",
    () => {
      let values = [deep_lower_value, lower_value, deep_middle_value, root_value, higher_value]
      let tree = insert_all(values)
      (BinaryTree.size(tree), all_contained(tree, values), BinaryTree.contains(tree, absent_value))
    },
    (5, true, false),
  )
})

// ---------------------------------------------------------------------------
// Graph
// ---------------------------------------------------------------------------

let label_a = 10
let label_b = 30
let label_c = 50
let label_d = 70
let missing_label = 99
let other_missing_label = 98

let register_all = labels => labels->Belt.Array.reduce(Graph.init(), Graph.addVertex)

// Añade la arista y conserva el grafo previo si falla; devuelve (grafo, ¿éxito?).
let add_edge_step = (graph, (from, to)) =>
  switch Graph.addEdge(graph, from, to) {
  | Some(next) => (next, true)
  | None => (graph, false)
  }

// Encadena las aristas en orden y devuelve el grafo final con el éxito de cada una.
let add_edges = (graph, edges) =>
  edges->Belt.Array.reduce((graph, []), ((current, results), edge) => {
    let (next, ok) = add_edge_step(current, edge)
    (next, Belt.Array.concat(results, [ok]))
  })

let counts = graph => (Graph.vertexCount(graph), Graph.edgeCount(graph))

describe("Graph", () => {
  assert_case(
    "should be empty after init",
    () => {
      let graph = Graph.init()
      (
        Graph.isEmpty(graph),
        counts(graph),
        Graph.hasEdge(graph, label_a, label_b),
        Graph.getNeighbors(graph, label_a),
      )
    },
    (true, (0, 0), false, None),
  )

  assert_case(
    "should hold an isolated vertex",
    () => {
      let graph = Graph.init()->Graph.addVertex(label_a)
      (Graph.isEmpty(graph), counts(graph), Graph.getNeighbors(graph, label_a))
    },
    (false, (1, 0), Some([])),
  )

  assert_case(
    "should add a directed edge between nonconsecutive labels",
    () => {
      let (graph, results) = add_edges(register_all([label_a, label_d]), [(label_a, label_d)])
      (
        results,
        Graph.hasEdge(graph, label_a, label_d),
        Graph.hasEdge(graph, label_d, label_a),
        counts(graph),
      )
    },
    ([true], true, false, (2, 1)),
  )

  assert_case(
    "should preserve adjacency on a duplicate vertex",
    () => {
      let (graph, results) = add_edges(register_all([label_a, label_b]), [(label_a, label_b)])
      let graph = graph->Graph.addVertex(label_a)
      (results, counts(graph), Graph.getNeighbors(graph, label_a))
    },
    ([true], (2, 1), Some([label_b])),
  )

  assert_case(
    "should treat a duplicate edge as idempotent",
    () => {
      let (graph, results) =
        add_edges(register_all([label_a, label_b]), [(label_a, label_b), (label_a, label_b)])
      (results, counts(graph), Graph.getNeighbors(graph, label_a))
    },
    ([true, true], (2, 1), Some([label_b])),
  )

  assert_case(
    "should reject missing endpoints without mutation",
    () => {
      let (base, _) = add_edges(register_all([label_a, label_b]), [(label_a, label_b)])
      let attempted = [
        (label_a, missing_label),
        (missing_label, label_a),
        (other_missing_label, missing_label),
        (missing_label, missing_label),
      ]
      let (graph, results) = add_edges(base, attempted)
      (
        results,
        counts(graph),
        Graph.getNeighbors(graph, label_a),
        Graph.getNeighbors(graph, label_b),
        attempted->Belt.Array.map(((from, to)) => Graph.hasEdge(graph, from, to)),
        Graph.getNeighbors(graph, other_missing_label),
        Graph.getNeighbors(graph, missing_label),
      )
    },
    (
      [false, false, false, false],
      (2, 1),
      Some([label_b]),
      Some([]),
      [false, false, false, false],
      None,
      None,
    ),
  )

  assert_case(
    "should list sorted neighbours and keep counts",
    () => {
      let (graph, results) =
        add_edges(
          register_all([label_a, label_b, label_c, label_d]),
          [(label_a, label_d), (label_a, label_b), (label_a, label_c), (label_b, label_c)],
        )
      (
        results,
        Graph.getNeighbors(graph, label_a),
        Graph.getNeighbors(graph, label_b),
        Graph.getNeighbors(graph, label_c),
        Graph.getNeighbors(graph, label_d),
        counts(graph),
      )
    },
    (
      [true, true, true, true],
      Some([label_b, label_c, label_d]),
      Some([label_c]),
      Some([]),
      Some([]),
      (4, 4),
    ),
  )

  assert_case(
    "should report a missing-edge query as failure",
    () => {
      let graph = register_all([label_a, label_b])
      (Graph.hasEdge(graph, label_a, label_b), counts(graph), Graph.isEmpty(graph))
    },
    (false, (2, 0), false),
  )

  assert_case(
    "should distinguish missing-vertex neighbours from empty neighbours",
    () => {
      let graph = Graph.init()->Graph.addVertex(label_a)
      (Graph.getNeighbors(graph, missing_label), Graph.getNeighbors(graph, label_a), counts(graph))
    },
    (None, Some([]), (1, 0)),
  )

  assert_case(
    "should accept a self-loop and its duplicate",
    () => {
      let (graph, results) =
        add_edges(register_all([label_a]), [(label_a, label_a), (label_a, label_a)])
      (
        results,
        Graph.hasEdge(graph, label_a, label_a),
        Graph.getNeighbors(graph, label_a),
        counts(graph),
      )
    },
    ([true, true], true, Some([label_a]), (1, 1)),
  )
})
