// naive_sort — ordenamientos elementales O(n²).
//
// Especificación: 05_Naive_Sort
//
// Contrato: recibe un array de enteros y devuelve el array ordenado de menor a
// mayor (in-place o como copia ordenada), sin invocar `Array.sort`, `Belt.Sort`
// ni ninguna biblioteca de ordenamiento, y sin estructuras auxiliares complejas.
// El tipo `array<int>` no admite `null` ni una entrada inválida, así que el caso
// nulo no es representable y se conservan los 7 casos de la especificación. El
// array vacío se devuelve tal cual y no se lanza ninguna excepción.
//
// Implementación pendiente: la escribe el autor. Esta delegación solo genera el
// esqueleto y las pruebas unitarias.
let selection_sort = (array: array<int>) => {
  let n = Array.length(array);
  for i in 0 .. n - 2 {
    let mut min_index = i;
    for j in i + 1 .. n - 1 {
      if array[j] < array[min_index] {
        min_index = j;
      }
    }
    if min_index != i {
      let temp = array[i];
      array[i] = array[min_index];
      array[min_index] = temp;
    }
  }
  array;
};

let bubble_sort = (array: array<int>) => {
  let n = Array.length(array);
  for i in 0 .. n - 2 {
    let mut swapped = false;
    for j in 0 .. n - 2 - i {
      if array[j] > array[j + 1] {
        let temp = array[j];
        array[j] = array[j + 1];
        array[j + 1] = temp;
        swapped = true;
      }
    }
    if !swapped {
      break;
    }
  }
  array;
};

let insertion_sort = (array: array<int>) => {
  let n = Array.length(array);
  for i in 1 .. n - 1 {
    let key = array[i];
    let mut j = i - 1;
    while j >= 0 && array[j] > key {
      array[j + 1] = array[j];
      j = j - 1;
    }
    array[j + 1] = key;
  }
  array;
};