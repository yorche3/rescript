/**
 * Árbol binario de búsqueda: raíz opcional y contador de valores distintos.
 *
 * Contrato del módulo `data_structures_advanced` — especificación
 * 07_Data_Structures_Advanced. Variante V2 (inmutable): `insert` devuelve el
 * árbol resultante; un duplicado también es éxito y no crece el tamaño.
 *
 * Cuerpos centinela sustituidos: `insert` reconstruye el camino hasta la hoja
 * y solo incrementa el contador cuando el valor es nuevo.
 */

type t = {root: option<TreeNode.t>, count: int}

/** Árbol vacío utilizable: sin raíz y contador a cero (`init`). */
let init = (): t => {root: None, count: 0}

let rec insertNode = (
  value: int,
  node: option<TreeNode.t>,
): (option<TreeNode.t>, bool) =>
  switch node {
  | None => (Some(TreeNode.make(value)), true)
  | Some(n) =>
    if value == TreeNode.value(n) {
      (Some(n), false)
    } else if value < TreeNode.value(n) {
      let (newLeft, inserted) = insertNode(value, TreeNode.left(n))
      (Some(TreeNode.withLeft(n, newLeft)), inserted)
    } else {
      let (newRight, inserted) = insertNode(value, TreeNode.right(n))
      (Some(TreeNode.withRight(n, newRight)), inserted)
    }
  }

/** Inserta el valor; un duplicado también es éxito y no crece el tamaño. */
let insert = (tree: t, value: int): t => {
  let (newRoot, inserted) = insertNode(value, tree.root)
  {
    root: newRoot,
    count: if inserted { tree.count + 1 } else { tree.count },
  }
}

let rec containsNode = (value: int, node: option<TreeNode.t>): bool =>
  switch node {
  | None => false
  | Some(n) =>
    if value == TreeNode.value(n) {
      true
    } else if value < TreeNode.value(n) {
      containsNode(value, TreeNode.left(n))
    } else {
      containsNode(value, TreeNode.right(n))
    }
  }

/** Pertenencia según la invariante del ABB. */
let contains = (tree: t, value: int): bool => containsNode(value, tree.root)

/** Verdadero cuando el árbol no guarda ningún valor. */
let isEmpty = (tree: t): bool => tree.count == 0

/** Número de valores distintos guardados. */
let size = (tree: t): int => tree.count
