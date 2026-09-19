open Jest
open Expect

// Casos de prueba de la especificación 05_Naive_Sort.md
//
// Caso nulo omitido: el tipo `array<int>` de ReScript no admite `null` ni una
// entrada inválida, así que el caso no es representable en la firma y se
// conservan los 7 casos de la especificación.
//
// Aislamiento: los arrays de ReScript son mutables y los algoritmos pueden
// ordenar in-place, así que cada caso ordena una copia del fixture compartido.

let standard_input = [5, 2, 9, 1, 5, 6]
let standard_output = [1, 2, 5, 5, 6, 9]

let sorted_input = [1, 2, 3, 4, 5]
let sorted_output = [1, 2, 3, 4, 5]

let reverse_input = [5, 4, 3, 2, 1]
let reverse_output = [1, 2, 3, 4, 5]

let identical_input = [7, 7, 7, 7]
let identical_output = [7, 7, 7, 7]

let negative_input = [3, -1, 4, -5, 0]
let negative_output = [-5, -1, 0, 3, 4]

let single_input = [42]
let single_output = [42]

let empty_input = []
let empty_output = []

// Cada caso es una tupla de descripción, entrada y salida esperada.
let cases = [
  ("an unsorted array", standard_input, standard_output),
  ("an already sorted array", sorted_input, sorted_output),
  ("a reverse ordered array", reverse_input, reverse_output),
  ("an array of identical elements", identical_input, identical_output),
  ("an array with negative numbers", negative_input, negative_output),
  ("a single element array", single_input, single_output),
  ("an empty array", empty_input, empty_output),
]

// Helper compartido: recibe la función a probar y el nombre del algoritmo, y
// ejecuta todos los casos. El nombre del `describe` y el del `test` componen el
// mensaje del contrato ("{algoritmo} should sort {descripción}"), porque Jest no
// admite un mensaje como argumento de `expect`.
let assert_sorts_all_cases = (sort, algorithm) =>
  describe(algorithm, () => {
    cases->Belt.Array.forEach(((description, input, expected)) =>
      test("should sort " ++ description, () =>
        expect(sort(Belt.Array.copy(input)))->toEqual(expected)
      )
    )
  })

assert_sorts_all_cases(Naive_sort.selection_sort, "selection_sort")
assert_sorts_all_cases(Naive_sort.bubble_sort, "bubble_sort")
assert_sorts_all_cases(Naive_sort.insertion_sort, "insertion_sort")
