/**
 * FIFO queue built from scratch over Node.
 * Immutable: every operation returns a new queue.
 * The empty queue is the value `empty`, which is the `init()` of the contract.
 *
 * Failure indicator: `dequeue` and `peek` of an empty queue are -1, and `dequeue` returns the
 * pair (value, new queue) because an immutable structure has to hand the new state back.
 * `enqueue`, `dequeue` and `peek` are still skeletons: the algorithm is step 5.
 */
type t = {
  front: option<Node.t>,
  rear: option<Node.t>,
  count: int,
}

let empty: t = {front: None, rear: None, count: 0}

let isEmpty = (queue: t): bool => queue.count == 0
let size = (queue: t): int => queue.count

let enqueue = (_queue: t, _value: int): t => {
  failwith("not implemented: enqueue")
}

let dequeue = (_queue: t): (int, t) => {
  failwith("not implemented: dequeue")
}

let peek = (_queue: t): int => {
  failwith("not implemented: peek")
}
