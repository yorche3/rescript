/**
 * Nodo del árbol binario de búsqueda: valor y dos enlaces opcionales.
 *
 * Contrato del módulo `data_structures_advanced` — especificación
 * 07_Data_Structures_Advanced. Variante V2 (inmutable): cada operación que
 * actualizaría el nodo devuelve un nodo nuevo, y `set_left`/`set_right` son
 * `withLeft`/`withRight` (actualización de registro con `...node`).
 *
 * Indicadores: la ausencia de enlace es `None`, el opcional nativo declarado
 * para ReScript en `docs/ruleset/data/canonical_names.tsv` (`absent = None`,
 * `present = Some(x)`, familia `func-option`).
 *
 * Cuerpos centinela: la implementación llega en el paso siguiente; hasta
 * entonces las operaciones devuelven el valor neutro de su tipo.
 */

type rec t = {value: int, left: option<t>, right: option<t>}

/** Nodo con el valor indicado y ambos enlaces ausentes (`init`). */
let make = (_value: int): t => {value: 0, left: None, right: None}

/** Observa el valor del nodo. */
let value = (node: t): int => node.value

/** Observa el enlace izquierdo, o `None` si está ausente. */
let left = (node: t): option<t> => node.left

/** Observa el enlace derecho, o `None` si está ausente. */
let right = (node: t): option<t> => node.right

/** Copia del nodo con el enlace izquierdo indicado (`set_left`). */
let withLeft = (node: t, _left: option<t>): t => node

/** Copia del nodo con el enlace derecho indicado (`set_right`). */
let withRight = (node: t, _right: option<t>): t => node
