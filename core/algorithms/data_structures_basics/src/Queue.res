/**
 * FIFO queue built from scratch over Node.
 * Mutable: the operations change the instance in place and return no structure;
 * `init()` builds the empty queue, which is the `init()` of the contract.
 *
 * Failure indicator: `dequeue` and `peek` of an empty queue are -1; only the
 * links (`front`, `rear`) use `None`.
 */
type t = {
  mutable front: option<Node.t>,
  mutable rear: option<Node.t>,
  mutable count: int,
}

let init = (): t => {front: None, rear: None, count: 0}

let isEmpty = (queue: t): bool => queue.count == 0
let size = (queue: t): int => queue.count

let enqueue = (queue: t, value: int): unit => {
  let node: Node.t = {value, next: None}
  switch queue.rear {
  | None => queue.front = Some(node)
  | Some(rear_node) => rear_node.next = Some(node)
  }
  queue.rear = Some(node)
  queue.count = queue.count + 1
}

let dequeue = (queue: t): int =>
  switch queue.front {
  | None => -1
  | Some(node) =>
    queue.front = node.next
    switch queue.front {
    | None => queue.rear = None
    | Some(_) => ()
    }
    queue.count = queue.count - 1
    Node.value(node)
  }

let peek = (queue: t): int =>
  switch queue.front {
  | None => -1
  | Some(node) => Node.value(node)
  }
