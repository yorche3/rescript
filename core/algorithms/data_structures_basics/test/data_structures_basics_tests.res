open Jest
open Expect

// Casos de prueba de la especificación 06_Data_Structures_Basics.md
//
// Los casos de cada estructura son pasos sucesivos sobre el mismo estado lógico. La
// implementación es **inmutable**: cada operación devuelve la estructura nueva, así que la
// instancia vive en un `ref` por estructura y cada paso la vuelve a enlazar con lo que
// devuelve la operación, sin reiniciar el escenario. Cada paso es un `test` propio y el
// ejecutor compartido compara su observación con la salida esperada. El mensaje del contrato
// lo componen el `describe` y el nombre del `test` ("LinkedList should satisfy an empty
// state"), porque Jest no admite mensaje en `expect`.
//
// Indicadores de fallo: las lecturas enteras que pueden fallar (`head`, `peek`, `pop`,
// `dequeue`) devuelven -1; `delete` devuelve `None` si el valor no está y la lista nueva si lo
// estaba; los booleanos (`isEmpty`) son `true`/`false`. Solo los enlaces (`Node.next`,
// `LinkedList.head`/`tail`, `Stack.top`, `Queue.front`/`rear`) usan `None` como ausencia. Los
// valores de prueba son enteros positivos, así que no colisionan con el -1.
//
// Caso nulo: la especificación de este módulo no recibe una entrada nula —los valores son
// `int` no anulable y el único valor ausente posible es el enlace de un `Node`—, así que no
// hay caso nulo que añadir; la ausencia del enlace se verifica en los casos de `Node`.

// Ejecutor compartido: recibe la descripción del caso, la observación y la salida esperada.
let assert_case = (description, observe, expected) =>
  test(description, () => expect(observe())->toEqual(expected))

// Ayudantes de encadenado: la implementación devuelve estructuras nuevas, así que cada uno
// reenlaza el `ref` del escenario con el estado que devuelve la operación.
let apply_to = (structure, operation, argument) =>
  structure := operation(structure.contents, argument)

let delete_from = (list, value) => {
  let (deleted, updated) = switch list.contents->LinkedList.delete(value) {
  | None => (false, list.contents)
  | Some(updated) => (true, updated)
  }
  list := updated
  deleted
}

// Las lecturas que extraen (`pop`, `dequeue`) devuelven la pareja (valor, estructura nueva).
let pop_from = (structure, operation) => {
  let (value, updated) = operation(structure.contents)
  structure := updated
  value
}

// ---------------------------------------------------------------------------
// Node
// ---------------------------------------------------------------------------

// Fixtures: un nombre por valor del escenario.
let first_node_value = 10
let second_node_value = 20

let first_node = Node.make(first_node_value)
let second_node = Node.make(second_node_value)

describe("Node", () => {
  assert_case(
    "should expose the value and an absent link after make",
    () => (Node.value(first_node), first_node->Node.next->Belt.Option.isNone),
    (first_node_value, true),
  )

  assert_case(
    "should reach the linked node after withNext",
    () => {
      let linked = first_node->Node.withNext(second_node)
      (
        linked->Node.next->Belt.Option.map(Node.value)->Belt.Option.getWithDefault(-1),
        second_node->Node.next->Belt.Option.isNone,
      )
    },
    (second_node_value, true),
  )
})

// ---------------------------------------------------------------------------
// LinkedList
// ---------------------------------------------------------------------------

// Fixtures: un nombre por valor del escenario.
let inserted_tail_first = 10
let inserted_tail_second = 20
let inserted_head_value = 5
let repeated_value = 10
let absent_value = 99

let linked_list = ref(LinkedList.empty)

describe("LinkedList", () => {
  assert_case(
    "should satisfy an empty state",
    () => {
      let is_empty = linked_list.contents->LinkedList.isEmpty
      let list_size = linked_list.contents->LinkedList.size
      let list_head = linked_list.contents->LinkedList.head
      (is_empty, list_size, list_head)
    },
    (true, 0, -1),
  )

  // El contrato observa el valor de la cabeza (`head`), no la cadena de nodos, así que el
  // orden 5, 10, 20, 10 se comprueba por esa cabeza en cada paso.
  assert_case(
    "should satisfy insertion at both ends",
    () => {
      apply_to(linked_list, LinkedList.insertTail, inserted_tail_first)
      apply_to(linked_list, LinkedList.insertTail, inserted_tail_second)
      apply_to(linked_list, LinkedList.insertHead, inserted_head_value)
      apply_to(linked_list, LinkedList.insertTail, repeated_value)
      (linked_list.contents->LinkedList.size, linked_list.contents->LinkedList.head)
    },
    (4, inserted_head_value),
  )

  assert_case(
    "should satisfy deletion of the first occurrence",
    () => {
      let deleted = delete_from(linked_list, inserted_tail_first)
      (deleted, linked_list.contents->LinkedList.size, linked_list.contents->LinkedList.head)
    },
    (true, 3, inserted_head_value),
  )

  assert_case(
    "should satisfy deletion of an absent value",
    () => {
      let deleted = delete_from(linked_list, absent_value)
      (deleted, linked_list.contents->LinkedList.size, linked_list.contents->LinkedList.head)
    },
    (false, 3, inserted_head_value),
  )

  assert_case(
    "should satisfy emptying the list",
    () => {
      let first_deleted = delete_from(linked_list, inserted_head_value)
      let second_deleted = delete_from(linked_list, inserted_tail_second)
      let third_deleted = delete_from(linked_list, repeated_value)
      (
        first_deleted,
        second_deleted,
        third_deleted,
        linked_list.contents->LinkedList.isEmpty,
        linked_list.contents->LinkedList.size,
        linked_list.contents->LinkedList.head,
      )
    },
    (true, true, true, true, 0, -1),
  )
})

// ---------------------------------------------------------------------------
// Stack
// ---------------------------------------------------------------------------

// Fixtures: un nombre por valor del escenario.
let pushed_first = 10
let pushed_second = 20
let pushed_third = 30
let pushed_after_pop = 40

let stack = ref(Stack.empty)

describe("Stack", () => {
  assert_case(
    "should satisfy an empty state and a failed removal",
    () => {
      let is_empty = stack.contents->Stack.isEmpty
      let stack_size = stack.contents->Stack.size
      let peeked = stack.contents->Stack.peek
      let removed = stack->pop_from(Stack.pop)
      (is_empty, stack_size, peeked, removed)
    },
    (true, 0, -1, -1),
  )

  assert_case(
    "should satisfy LIFO order and a non-mutating peek",
    () => {
      apply_to(stack, Stack.push, pushed_first)
      apply_to(stack, Stack.push, pushed_second)
      apply_to(stack, Stack.push, pushed_third)
      (stack.contents->Stack.peek, stack.contents->Stack.size)
    },
    (pushed_third, 3),
  )

  assert_case(
    "should satisfy removal and reuse",
    () => {
      let first_removed = stack->pop_from(Stack.pop)
      apply_to(stack, Stack.push, pushed_after_pop)
      let second_removed = stack->pop_from(Stack.pop)
      let third_removed = stack->pop_from(Stack.pop)
      let fourth_removed = stack->pop_from(Stack.pop)
      (
        first_removed,
        second_removed,
        third_removed,
        fourth_removed,
        stack.contents->Stack.isEmpty,
        stack.contents->Stack.size,
      )
    },
    (pushed_third, pushed_after_pop, pushed_second, pushed_first, true, 0),
  )

  assert_case(
    "should satisfy an empty state after removal",
    () => {
      let removed = stack->pop_from(Stack.pop)
      (removed, stack.contents->Stack.isEmpty)
    },
    (-1, true),
  )
})

// ---------------------------------------------------------------------------
// Queue
// ---------------------------------------------------------------------------

// Fixtures: un nombre por valor del escenario.
let enqueued_first = 10
let enqueued_second = 20
let enqueued_third = 30
let enqueued_after_dequeue = 40

let queue = ref(Queue.empty)

describe("Queue", () => {
  assert_case(
    "should satisfy an empty state and a failed removal",
    () => {
      let is_empty = queue.contents->Queue.isEmpty
      let queue_size = queue.contents->Queue.size
      let peeked = queue.contents->Queue.peek
      let removed = queue->pop_from(Queue.dequeue)
      (is_empty, queue_size, peeked, removed)
    },
    (true, 0, -1, -1),
  )

  assert_case(
    "should satisfy FIFO order and a non-mutating peek",
    () => {
      apply_to(queue, Queue.enqueue, enqueued_first)
      apply_to(queue, Queue.enqueue, enqueued_second)
      apply_to(queue, Queue.enqueue, enqueued_third)
      (queue.contents->Queue.peek, queue.contents->Queue.size)
    },
    (enqueued_first, 3),
  )

  assert_case(
    "should satisfy removal and reuse",
    () => {
      let first_removed = queue->pop_from(Queue.dequeue)
      apply_to(queue, Queue.enqueue, enqueued_after_dequeue)
      let second_removed = queue->pop_from(Queue.dequeue)
      let third_removed = queue->pop_from(Queue.dequeue)
      let fourth_removed = queue->pop_from(Queue.dequeue)
      (
        first_removed,
        second_removed,
        third_removed,
        fourth_removed,
        queue.contents->Queue.isEmpty,
        queue.contents->Queue.size,
      )
    },
    (enqueued_first, enqueued_second, enqueued_third, enqueued_after_dequeue, true, 0),
  )

  assert_case(
    "should satisfy an empty state after removal",
    () => {
      let removed = queue->pop_from(Queue.dequeue)
      (removed, queue.contents->Queue.isEmpty)
    },
    (-1, true),
  )
})
