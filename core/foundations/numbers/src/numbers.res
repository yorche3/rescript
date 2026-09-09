// Direct recursion (_rec)

let rec sum_of_first_n_rec = n =>
  if n == 0 {
    0
  } else {
    n + sum_of_first_n_rec(n - 1)
  }

let rec factorial_rec = n =>
  if n == 0 {
    1
  } else {
    n * factorial_rec(n - 1)
  }

let rec fibonacci_rec = n =>
  if n <= 1 {
    n
  } else {
    fibonacci_rec(n - 1) + fibonacci_rec(n - 2)
  }

let rec greatest_common_divisor_rec = (a, b) =>
  if b == 0 {
    a
  } else {
    greatest_common_divisor_rec(b, mod(a, b))
  }

let least_common_multiple_rec = (a, b) => (a * b) / greatest_common_divisor_rec(a, b)

// Accumulator recursion (_acc): tail calls, optimized by the ReScript compiler

let rec sum_of_first_n_acc = n => sum_of_first_n_acc_help(n, 0)
and sum_of_first_n_acc_help = (n, acc) =>
  if n <= 0 {
    acc
  } else {
    sum_of_first_n_acc_help(n - 1, n + acc)
  }

let rec factorial_acc = n => factorial_acc_help(n, 1)
and factorial_acc_help = (n, acc) =>
  if n <= 1 {
    acc
  } else {
    factorial_acc_help(n - 1, n * acc)
  }

let rec fibonacci_acc = n => fibonacci_acc_help(n, 0, 1)
and fibonacci_acc_help = (n, acc2, acc1) =>
  if n <= 0 {
    acc2
  } else if n <= 2 {
    acc1 + acc2
  } else {
    fibonacci_acc_help(n - 1, acc1, acc1 + acc2)
  }

let rec greatest_common_divisor_acc = (a, b) => greatest_common_divisor_acc_help(a, b)
and greatest_common_divisor_acc_help = (a, b) =>
  if b == 0 {
    a
  } else {
    greatest_common_divisor_acc_help(b, mod(a, b))
  }

let least_common_multiple_acc = (a, b) => (a * b) / greatest_common_divisor_acc(a, b)

// Iterative (_ite)

let sum_of_first_n_ite = n => {
  let result = ref(0)
  for i in 1 to n {
    result := result.contents + i
  }
  result.contents
}

let factorial_ite = n => {
  let result = ref(1)
  for i in 2 to n {
    result := result.contents * i
  }
  result.contents
}

let fibonacci_ite = n =>
  if n <= 1 {
    n
  } else {
    let acc2 = ref(0)
    let acc1 = ref(1)
    for _ in 2 to n {
      let temp = acc1.contents + acc2.contents
      acc2 := acc1.contents
      acc1 := temp
    }
    acc1.contents
  }

let greatest_common_divisor_ite = (a, b) => {
  let a2 = ref(a)
  let b2 = ref(b)
  while b2.contents != 0 {
    let temp = b2.contents
    b2 := mod(a2.contents, b2.contents)
    a2 := temp
  }
  a2.contents
}

let least_common_multiple_ite = (a, b) => (a * b) / greatest_common_divisor_ite(a, b)
