let addition = (a, b) => a + b

let subtraction = (a, b) => a - b

let multiplication = (a, b) => {
  let result = ref(0)
  for _ in 1 to b {
    result := addition(result.contents, a)
  }
  result.contents
}

let division = (a, b) => {
  let quotient = ref(0)
  let rest = ref(a)
  while rest.contents >= b {
    rest := subtraction(rest.contents, b)
    quotient := addition(quotient.contents, 1)
  }
  quotient.contents
}

let modulus = (a, b) => {
  let q = division(a, b)
  let p = multiplication(q, b)
  subtraction(a, p)
}
