module Node = {
  type rec t = {
    mutable value: int,
    mutable next: Js.Nullable.t<t>,
  }

  let init = (value: int): t => {
    value,
    next: Js.Nullable.null,
  }

  let get_value = (_node: t): int => -1

  let get_next = (_node: t): Js.Nullable.t<t> => Js.Nullable.null

  let set_next = (node: t, _next: Js.Nullable.t<t>): t => node
}

module LinkedList = {
  type t = {
    mutable head: Js.Nullable.t<Node.t>,
    mutable tail: Js.Nullable.t<Node.t>,
    mutable count: int,
  }

  let init = (): t => {
    head: Js.Nullable.null,
    tail: Js.Nullable.null,
    count: 0,
  }

  let get_head = (_list: t): int => -1

  let insert_head = (_list: t, _value: int): unit => ()

  let insert_tail = (_list: t, _value: int): unit => ()

  let delete = (_list: t, _value: int): bool => false

  let is_empty = (_list: t): bool => false

  let size = (_list: t): int => -1
}

module Stack = {
  type t = {
    mutable top: Js.Nullable.t<Node.t>,
    mutable count: int,
  }

  let init = (): t => {
    top: Js.Nullable.null,
    count: 0,
  }

  let push = (_stack: t, _value: int): unit => ()

  let pop = (_stack: t): int => -1

  let peek = (_stack: t): int => -1

  let is_empty = (_stack: t): bool => false

  let size = (_stack: t): int => -1
}

module Queue = {
  type t = {
    mutable front: Js.Nullable.t<Node.t>,
    mutable rear: Js.Nullable.t<Node.t>,
    mutable count: int,
  }

  let init = (): t => {
    front: Js.Nullable.null,
    rear: Js.Nullable.null,
    count: 0,
  }

  let enqueue = (_queue: t, _value: int): unit => ()

  let dequeue = (_queue: t): int => -1

  let peek = (_queue: t): int => -1

  let is_empty = (_queue: t): bool => false

  let size = (_queue: t): int => -1
}
