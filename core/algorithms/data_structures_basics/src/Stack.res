/**
 * LIFO stack built from scratch over Node.
 * Mutable: the operations change the instance in place and return no structure;
 * `init()` builds the empty stack, which is the `init()` of the contract.
 *
 * Failure indicator: `pop` and `peek` of an empty stack are -1; only the link
 * (`top`) uses `None`.
 */
type t = {
  mutable top: option<Node.t>,
  mutable count: int,
}

let init = (): t => {top: None, count: 0}

let isEmpty = (stack: t): bool => stack.count == 0
let size = (stack: t): int => stack.count

let push = (stack: t, value: int): unit => {
  let node: Node.t = {value, next: stack.top}
  stack.top = Some(node)
  stack.count = stack.count + 1
}

let pop = (stack: t): int =>
  switch stack.top {
  | None => -1
  | Some(node) =>
    stack.top = node.next
    stack.count = stack.count - 1
    Node.value(node)
  }

let peek = (stack: t): int =>
  switch stack.top {
  | None => -1
  | Some(node) => Node.value(node)
  }
