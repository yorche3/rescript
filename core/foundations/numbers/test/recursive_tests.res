open Jest
open Expect

describe("Recursive", () => {
  describe("sum_of_first_n_rec", () => {
    testAll("", list{
      (0, 0),
      (3, 6)
    }, ((n, expected)) => {
      expect(Numbers.sum_of_first_n_rec(n))->toBe(expected)
    })
  })

  describe("factorial_rec", () => {
    testAll("", list{
      (0, 1),
      (4, 24)
    }, ((n, expected)) => {
      expect(Numbers.factorial_rec(n))->toBe(expected)
    })
  })

  describe("fibonacci_rec", () => {
    testAll("", list{
      (0, 0),
      (1, 1),
      (6, 8)
    }, ((n, expected)) => {
      expect(Numbers.fibonacci_rec(n))->toBe(expected)
    })
  })

  describe("greatest_common_divisor_rec", () => {
    testAll("", list{
      (12, 8, 4),
      (7, 5, 1)
    }, ((a, b, expected)) => {
      expect(Numbers.greatest_common_divisor_rec(a, b))->toBe(expected)
    })
  })

  describe("least_common_multiple_rec", () => {
    testAll("", list{
      (4, 6, 12),
      (6, 8, 24)
    }, ((a, b, expected)) => {
      expect(Numbers.least_common_multiple_rec(a, b))->toBe(expected)
    })
  })
})
