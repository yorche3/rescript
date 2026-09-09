open Jest
open Expect

describe("Iterative", () => {
  describe("sum_of_first_n_ite", () => {
    testAll("", list{
      (0, 0),
      (3, 6)
    }, ((n, expected)) => {
      expect(Numbers.sum_of_first_n_ite(n))->toBe(expected)
    })
  })

  describe("factorial_ite", () => {
    testAll("", list{
      (0, 1),
      (4, 24)
    }, ((n, expected)) => {
      expect(Numbers.factorial_ite(n))->toBe(expected)
    })
  })

  describe("fibonacci_ite", () => {
    testAll("", list{
      (0, 0),
      (1, 1),
      (6, 8)
    }, ((n, expected)) => {
      expect(Numbers.fibonacci_ite(n))->toBe(expected)
    })
  })

  describe("greatest_common_divisor_ite", () => {
    testAll("", list{
      (12, 8, 4),
      (7, 5, 1)
    }, ((a, b, expected)) => {
      expect(Numbers.greatest_common_divisor_ite(a, b))->toBe(expected)
    })
  })

  describe("least_common_multiple_ite", () => {
    testAll("", list{
      (4, 6, 12),
      (6, 8, 24)
    }, ((a, b, expected)) => {
      expect(Numbers.least_common_multiple_ite(a, b))->toBe(expected)
    })
  })
})
