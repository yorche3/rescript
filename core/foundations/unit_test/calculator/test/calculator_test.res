open Jest
open Expect

describe("Calculator", () => {
  test("addition", () => {
    expect(Calculator.addition(2, 3))->toBe(5)
  })

  test("subtraction", () => {
    expect(Calculator.subtraction(5, 2))->toBe(3)
  })

  test("multiplication", () => {
    expect(Calculator.multiplication(3, 4))->toBe(12)
  })

  test("division", () => {
    expect(Calculator.division(10, 3))->toBe(3)
  })

  test("modulus", () => {
    expect(Calculator.modulus(10, 3))->toBe(1)
  })
})
