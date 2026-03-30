#import "lambda.typ": *
#outline(depth: 2)

= Function tests
== Booleans
=== AND
#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [$x$], [$y$], [$x and y$],
  ),
[False], [False], [#AND(FALSE)(FALSE)],
[False], [True], [#AND(FALSE)(TRUE)],
[True], [False], [#AND(TRUE)(FALSE)],
[True], [True], [#AND(TRUE)(TRUE)],
)

=== OR
#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [$x$], [$y$], [$x or y$],
  ),
[False], [False], [#OR(FALSE)(FALSE)],
[False], [True], [#OR(FALSE)(TRUE)],
[True], [False], [#OR(TRUE)(FALSE)],
[True], [True], [#OR(TRUE)(TRUE)],
)

=== NOT
#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [$x$], [$not x$],
  ),
[False], [#NOT(FALSE)],
[True], [#NOT(TRUE)],
)

#pagebreak()
== Pairs
FST (TRUE, FALSE)\
$=$ #FST(PAIR(TRUE)(FALSE)) \

SND (TRUE, FALSE)\
$=$ #SND(PAIR(TRUE)(FALSE)) \

#pagebreak()
== Arithmetic (Church numberals)
=== Addition
$6 + 7$
$=$ #CHURCH_TO_INT(ADD(SIX())(SEVEN())) \

=== Multiplication
$6 * 6$
$=$ #CHURCH_TO_INT(TIMES(SIX())(SIX())) \

=== Exponential
$6 ^ 3$
$=$ #CHURCH_TO_INT(POWER(SIX())(THREE())) \

=== Predecessor
$8 - 1$
$=$ #CHURCH_TO_INT(PRED(EIGHT())) \

=== Subtraction
$7 - 1$
$=$ #CHURCH_TO_INT(MINUS(SEVEN())(ONE())) \

=== Factorial
$5!$
$=$ #CHURCH_TO_INT(FACTORIAL(FIVE())) \

=== Modulo
11 mod 5
$=$ #CHURCH_TO_INT(MODULO(ADD(NINE())(TWO()))(FIVE())) \

#pagebreak()
== Comparisons (Numerical)
=== Is zero
$(0 = 0)$
$equiv$ #IS_ZERO(ZERO) \
$(1 = 0)$
$equiv$ #IS_ZERO(ONE()) \

=== Equal
$(6 = 6)$
$equiv$ #EQ(SIX())(SIX()) \
$(6 = 5)$
$equiv$ #EQ(SIX())(FIVE()) \
$(5 = 6)$
$equiv$ #EQ(FIVE())(SIX()) \

=== Less than
$(5 < 6)$
$equiv$ #LT(FIVE())(SIX()) \
$(6 < 6)$
$equiv$ #LT(SIX())(SIX()) \
$(6 < 5)$
$equiv$ #LT(SIX())(FIVE()) \

=== Less than equal
$(5 <= 6)$
$equiv$ #LTEQ(FIVE())(SIX()) \
$(6 <= 6)$
$equiv$ #LTEQ(SIX())(SIX()) \
$(6 <= 5)$
$equiv$ #LTEQ(SIX())(FIVE()) \

=== Greater than
$(6 > 5)$
$equiv$ #GT(SIX())(FIVE()) \
$(6 > 6)$
$equiv$ #GT(SIX())(SIX()) \
$(5 > 6)$
$equiv$ #GT(FIVE())(SIX()) \

=== Greater than equal
$(6 >= 5)$
$equiv$ #GTEQ(SIX())(FIVE()) \
$(6 >= 6)$
$equiv$ #GTEQ(SIX())(SIX()) \
$(5 >= 6)$
$equiv$ #GTEQ(FIVE())(SIX()) \

#pagebreak()
== Fizz Buzz (1 to 20)
#let FIZZBUZZ_STEP(n) = {
  let MOD3 = IS_ZERO(MODULO(n)(THREE()))
  let MOD5 = IS_ZERO(MODULO(n)(FIVE()))
  
  return IF(AND(MOD3)(MOD5))("FIZZBUZZ")(IF(MOD3)("FIZZ")(IF(MOD5)("BUZZ")(CHURCH_TO_INT(n))))
}

#let num = ONE()
#for i in range(1,21) {
  [#FIZZBUZZ_STEP(num) \ ]
  num = SUCC(num)
}
