/**
 * Árbol binario de búsqueda: raíz opcional y contador de valores distintos.
 *
 * Contrato del módulo `data_structures_advanced` — especificación
 * 07_Data_Structures_Advanced. Variante V2 (inmutable): `insert` devuelve el
 * árbol resultante; un duplicado también es éxito y no crece el tamaño.
 *
 * Cuerpos centinela: la implementación llega en el paso siguiente; hasta
 * entonces las operaciones devuelven el valor neutro de su tipo.
 */

type t = {root: option<TreeNode.t>, count: int}

/** Árbol vacío utilizable: sin raíz y contador a cero (`init`). */
let init = (): t => {root: None, count: 0}

/** Inserta el valor; un duplicado también es éxito y no crece el tamaño. */
let insert = (tree: t, _value: int): t => tree

/** Pertenencia según la invariante del ABB. */
let contains = (_tree: t, _value: int): bool => false

/** Verdadero cuando el árbol no guarda ningún valor. */
let isEmpty = (tree: t): bool => tree.count == 0

/** Número de valores distintos guardados. */
let size = (tree: t): int => tree.count
