/**
 * LIFO stack built from scratch over Node.
 * Immutable: every operation returns a new stack.
 * The empty stack is the value `empty`, which is the `init()` of the contract.
 *
 * Failure indicator: `pop` and `peek` of an empty stack are -1, and `pop` returns the pair
 * (value, new stack) because an immutable structure has to hand the new state back.
 * `push`, `pop` and `peek` are still skeletons: the algorithm is step 5.
 */
type t = {
  top: option<Node.t>,
  count: int,
}

let empty: t = {top: None, count: 0}

let isEmpty = (stack: t): bool => stack.count == 0
let size = (stack: t): int => stack.count

let push = (_stack: t, _value: int): t => {
  failwith("not implemented: push")
}

let pop = (_stack: t): (int, t) => {
  failwith("not implemented: pop")
}

let peek = (_stack: t): int => {
  failwith("not implemented: peek")
}
