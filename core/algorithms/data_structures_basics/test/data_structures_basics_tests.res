open Jest
open Expect

// Casos de prueba de la especificación 06_Data_Structures_Basics.md
//
// Los casos de cada estructura son pasos sucesivos sobre el mismo estado lógico: una sola
// instancia por estructura, creada una vez con `init()` y conservada (la implementación es
// mutable, muta en el sitio), sin reiniciar el escenario. Cada paso es un `test` propio y el
// ejecutor compartido compara su observación con la salida esperada. El mensaje del contrato
// lo componen el `describe` y el nombre del `test` ("LinkedList should satisfy an empty
// state"), porque Jest no admite mensaje en `expect`.
//
// Indicadores de fallo: las lecturas enteras que pueden fallar (`head`, `peek`, `pop`,
// `dequeue`) devuelven -1 y `delete` devuelve `false` si el valor no está; los booleanos
// (`isEmpty`) son `true`/`false`. Solo los enlaces (`Node.next`, `LinkedList.head`/`tail`,
// `Stack.top`, `Queue.front`/`rear`) usan `None` como ausencia. Los valores de prueba son
// enteros positivos, así que no colisionan con el -1.
//
// Caso nulo: la especificación de este módulo no recibe una entrada nula —los valores son
// `int` no anulable y el único valor ausente posible es el enlace de un `Node`—, así que no
// hay caso nulo que añadir; la ausencia del enlace se verifica en los casos de `Node`.

// Ejecutor compartido: recibe la descripción del caso, la observación y la salida esperada.
let assert_case = (description, observe, expected) =>
  test(description, () => expect(observe())->toEqual(expected))

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
    "should reach the linked node after setNext",
    () => {
      Node.setNext(first_node, second_node)
      (
        first_node->Node.next->Belt.Option.map(Node.value)->Belt.Option.getWithDefault(-1),
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

let linked_list = LinkedList.init()

describe("LinkedList", () => {
  assert_case(
    "should satisfy an empty state",
    () => {
      let is_empty = LinkedList.isEmpty(linked_list)
      let list_size = LinkedList.size(linked_list)
      let list_head = LinkedList.head(linked_list)
      (is_empty, list_size, list_head)
    },
    (true, 0, -1),
  )

  // El contrato observa el valor de la cabeza (`head`), no la cadena de nodos, así que el
  // orden 5, 10, 20, 10 se comprueba por esa cabeza en cada paso.
  assert_case(
    "should satisfy insertion at both ends",
    () => {
      LinkedList.insertTail(linked_list, inserted_tail_first)
      LinkedList.insertTail(linked_list, inserted_tail_second)
      LinkedList.insertHead(linked_list, inserted_head_value)
      LinkedList.insertTail(linked_list, repeated_value)
      (LinkedList.size(linked_list), LinkedList.head(linked_list))
    },
    (4, inserted_head_value),
  )

  assert_case(
    "should satisfy deletion of the first occurrence",
    () => {
      let deleted = LinkedList.delete(linked_list, inserted_tail_first)
      (deleted, LinkedList.size(linked_list), LinkedList.head(linked_list))
    },
    (true, 3, inserted_head_value),
  )

  assert_case(
    "should satisfy deletion of an absent value",
    () => {
      let deleted = LinkedList.delete(linked_list, absent_value)
      (deleted, LinkedList.size(linked_list), LinkedList.head(linked_list))
    },
    (false, 3, inserted_head_value),
  )

  assert_case(
    "should satisfy emptying the list",
    () => {
      let first_deleted = LinkedList.delete(linked_list, inserted_head_value)
      let second_deleted = LinkedList.delete(linked_list, inserted_tail_second)
      let third_deleted = LinkedList.delete(linked_list, repeated_value)
      (
        first_deleted,
        second_deleted,
        third_deleted,
        LinkedList.isEmpty(linked_list),
        LinkedList.size(linked_list),
        LinkedList.head(linked_list),
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

let stack = Stack.init()

describe("Stack", () => {
  assert_case(
    "should satisfy an empty state and a failed removal",
    () => {
      let is_empty = Stack.isEmpty(stack)
      let stack_size = Stack.size(stack)
      let peeked = Stack.peek(stack)
      let removed = Stack.pop(stack)
      (is_empty, stack_size, peeked, removed)
    },
    (true, 0, -1, -1),
  )

  assert_case(
    "should satisfy LIFO order and a non-mutating peek",
    () => {
      Stack.push(stack, pushed_first)
      Stack.push(stack, pushed_second)
      Stack.push(stack, pushed_third)
      (Stack.peek(stack), Stack.size(stack))
    },
    (pushed_third, 3),
  )

  assert_case(
    "should satisfy removal and reuse",
    () => {
      let first_removed = Stack.pop(stack)
      Stack.push(stack, pushed_after_pop)
      let second_removed = Stack.pop(stack)
      let third_removed = Stack.pop(stack)
      let fourth_removed = Stack.pop(stack)
      (
        first_removed,
        second_removed,
        third_removed,
        fourth_removed,
        Stack.isEmpty(stack),
        Stack.size(stack),
      )
    },
    (pushed_third, pushed_after_pop, pushed_second, pushed_first, true, 0),
  )

  assert_case(
    "should satisfy an empty state after removal",
    () => {
      let removed = Stack.pop(stack)
      (removed, Stack.isEmpty(stack))
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

let queue = Queue.init()

describe("Queue", () => {
  assert_case(
    "should satisfy an empty state and a failed removal",
    () => {
      let is_empty = Queue.isEmpty(queue)
      let queue_size = Queue.size(queue)
      let peeked = Queue.peek(queue)
      let removed = Queue.dequeue(queue)
      (is_empty, queue_size, peeked, removed)
    },
    (true, 0, -1, -1),
  )

  assert_case(
    "should satisfy FIFO order and a non-mutating peek",
    () => {
      Queue.enqueue(queue, enqueued_first)
      Queue.enqueue(queue, enqueued_second)
      Queue.enqueue(queue, enqueued_third)
      (Queue.peek(queue), Queue.size(queue))
    },
    (enqueued_first, 3),
  )

  assert_case(
    "should satisfy removal and reuse",
    () => {
      let first_removed = Queue.dequeue(queue)
      Queue.enqueue(queue, enqueued_after_dequeue)
      let second_removed = Queue.dequeue(queue)
      let third_removed = Queue.dequeue(queue)
      let fourth_removed = Queue.dequeue(queue)
      (
        first_removed,
        second_removed,
        third_removed,
        fourth_removed,
        Queue.isEmpty(queue),
        Queue.size(queue),
      )
    },
    (enqueued_first, enqueued_second, enqueued_third, enqueued_after_dequeue, true, 0),
  )

  assert_case(
    "should satisfy an empty state after removal",
    () => {
      let removed = Queue.dequeue(queue)
      (removed, Queue.isEmpty(queue))
    },
    (-1, true),
  )
})
