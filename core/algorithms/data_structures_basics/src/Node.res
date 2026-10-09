/**
 * Shared linked cell used by LinkedList, Stack and Queue.
 * Mutable: `setNext` updates the link in place (the spec's `set_next`).
 * The absent link is `None`, ReScript's native absence, and it is the only
 * place where `option` appears: `value` is an `int` that never fails.
 *
 * `init(value)` of the contract is `make(value)`.
 */
type rec t = {
  mutable value: int,
  mutable next: option<t>,
}

let make = (value: int): t => {value, next: None}

let value = (node: t): int => node.value

let next = (node: t): option<t> => node.next

let setNext = (node: t, next: t): unit => {
  node.next = Some(next)
}
