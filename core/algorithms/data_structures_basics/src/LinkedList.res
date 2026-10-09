/**
 * Singly linked list built from scratch over Node.
 * Immutable: every operation returns a new list.
 * The empty list is the value `empty`, which is the `init()` of the contract.
 *
 * Failure indicator: `head` of an empty list is -1, and `delete` of an absent
 * value is `None` (with the list unchanged); on success `delete` returns the
 * new list, because an immutable structure has to hand it back.
 * `insertTail` and `delete` are still skeletons: the algorithm is step 5.
 */
type t = {
  head: option<Node.t>,
  tail: option<Node.t>,
  count: int,
}

let empty: t = {head: None, tail: None, count: 0}

let isEmpty = (list: t): bool => list.count == 0
let size = (list: t): int => list.count

let head = (list: t): int =>
  switch list.head {
  | None => -1
  | Some(node) => Node.value(node)
  }

let insertHead = (list: t, value: int): t => {
  let node = {Node.value: value, next: list.head}
  let newTail = switch list.tail {
  | None => Some(node)
  | Some(_) => list.tail
  }
  {head: Some(node), tail: newTail, count: list.count + 1}
}

let insertTail = (_list: t, _value: int): t => {
  failwith("not implemented: insertTail")
}

let delete = (_list: t, _value: int): option<t> => {
  failwith("not implemented: delete")
}
