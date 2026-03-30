# Implementation of common lambda calculus functions in Typst

This is a small toy project to learn about Typst and functional programming concepts within its scripting language.

## Try it yourself
- You can import the `lambda.typ` file to use these functions
- You can compile the `test.typ` file with `typst compile test.typ` to see examples of all implemented functions, or just look at the pdf.

## Basic idea
The idea here is to represent lambda expressions as Typst functions, using nested functions (since Typst doesn't support currying).

A really nice feature of Typst is that an unresolved function just results in its name. This is really handy for debugging, as you can easily see if your expressions have the right structure by checking the output.

### Booleans
Boolean logic is implemented using Church encoding:
- $True = \lambda x. \lambda y. x$
- $False = \lambda x. \lambda y. y$

```typst
#let TRUE(x) = {
  let TRUE_INNER(y) = {
    return x
  }
  return TRUE_INNER
}

#let FALSE(x) = {
  let FALSE_INNER(y) = {
    return y
  }
  return FALSE_INNER
}
```

## Church Numerals
For basic church numerals you only really need the zero and successor function, like this:
```typst
#let ZERO(f) = {
  let ZERO_INNER(x) = {
    return x
  }
  return ZERO_INNER
}

#let SUCC(n) = {
  let SUCCC(f) = {
    let SUCCCC(x) = {
      f(n(f)(x))
    }
    return SUCCCC
  }
  return SUCCC
}
```
From here you can use a +1 function and 0 as an initial value to convert the functions to integers
```typst
#let PLUS_1_INT(x) = {
  return x + 1
}

#let CHURCH_TO_INT(x) = {
  return x(PLUS_1_INT)(0)
}
```

### Arithmetic
Building on `SUCC`, we can implement addition, multiplication, and even subtraction:
- **Addition:** `ADD(m)(n)`
- **Multiplication:** `TIMES(m)(n)`
- **Power:** `POWER(b)(e)`
- **Predecessor:** `PRED(n)`
- **Subtraction:** `MINUS(m)(n)`

## Comparisons
Numerical comparisons are also implemented:
- `IS_ZERO(n)`
- `EQ(m)(n)`, `LT(m)(n)`, `GT(m)(n)`, etc.

## Recursion
To support basic recursion I used a Z combinator to implement the factorial and Modulo function
```Typst
#let FACTORIAL_P(g) = {
  let FACTORIALC(n) = {
    let TRUE_B(v) = { return ONE() }
    let FALSE_B(v) = { return TIMES(n)(g(PRED_EFF(n))) }
    return IF(IS_ZERO(n))(TRUE_B)(FALSE_B)(ID)
  }
  return FACTORIALC
}

#let FACTORIAL = Z(FACTORIAL_P)
```

### Example: FizzBuzz
`test.typ` includes a FizzBuzz implementation:
```typst
#let FIZZBUZZ_STEP(n) = {
  let MOD3 = IS_ZERO(MODULO(n)(THREE()))
  let MOD5 = IS_ZERO(MODULO(n)(FIVE()))
  
  return IF(AND(MOD3)(MOD5))("FIZZBUZZ")(IF(MOD3)("FIZZ")(IF(MOD5)("BUZZ")(CHURCH_TO_INT(n))))
}
```
This is run using a loop since the printing would result in a side-effect. Therefore the functions are called separately for each number

## Known limitations
If you try to use this for some reason you may find that there is a recusion limit of 80 in the current version of typst. It is easy to change the limit within the compiler tho this might lead to some issues
