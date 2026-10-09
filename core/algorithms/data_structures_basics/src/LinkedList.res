/**
 * Singly linked list built from scratch over Node.
 * Mutable: the operations change the instance in place and return no structure;
 * `init()` builds the empty list, which is the `init()` of the contract.
 *
 * Failure indicator: `head` of an empty list is -1 and `delete` reports failure
 * with `false`; only links (`Node.next`, `head`, `tail`) use `None`.
 */
type t = {
  mutable head: option<Node.t>,
  mutable tail: option<Node.t>,
  mutable count: int,
}

let init = (): t => {head: None, tail: None, count: 0}

let isEmpty = (list: t): bool => list.count == 0
let size = (list: t): int => list.count

let head = (list: t): int =>
  switch list.head {
  | None => -1
  | Some(node) => Node.value(node)
  }

let insertHead = (list: t, value: int): unit => {
  let node: Node.t = {value, next: list.head}
  list.head = Some(node)
  switch list.tail {
  | None => list.tail = Some(node)
  | Some(_) => ()
  }
  list.count = list.count + 1
}

let insertTail = (list: t, value: int): unit => {
  let node: Node.t = {value, next: None}
  switch list.tail {
  | None => list.head = Some(node)
  | Some(tail_node) => tail_node.next = Some(node)
  }
  list.tail = Some(node)
  list.count = list.count + 1
}

let delete = (list: t, value: int): bool => {
  let rec find = (previous: option<Node.t>, current: option<Node.t>): bool =>
    switch current {
    | None => false
    | Some(node) =>
      if Node.value(node) == value {
        switch previous {
        | None => list.head = node.next
        | Some(previous_node) => previous_node.next = node.next
        }
        if list.tail === current {
          list.tail = previous
        }
        list.count = list.count - 1
        true
      } else {
        find(current, node.next)
      }
    }
  find(None, list.head)
}
