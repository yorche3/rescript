/**
 * Shared linked cell used by LinkedList, Stack and Queue.
 * Immutable: `withNext` returns a copy with a new link.
 * The absence of a link is `None`, ReScript's native absence; only links may
 * hold it. `value` is an `int` that never fails.
 *
 * `init(value)` of the contract is `make(value)`.
 */
type rec t = {
  value: int,
  next: option<t>,
}

let make = (value: int): t => {value, next: None}

let value = (node: t): int => node.value

let next = (node: t): option<t> => node.next

let withNext = (node: t, next: t): t => {...node, next: Some(next)}
