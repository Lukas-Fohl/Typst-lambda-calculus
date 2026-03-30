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
$(1 = 0)$
$equiv$ #IS_ZERO(SUCC(ZERO)) \
$(0 = 0)$
$equiv$ #IS_ZERO(ZERO) \

=== Equal
$(6 = 6)$
$equiv$ #EQ(SIX())(SIX()) \
$(1 = 6)$
$equiv$ #EQ(ONE())(SIX()) \

=== Less than
$(5 < 8)$
$equiv$ #LT(FIVE())(EIGHT()) \
$(5 < 5)$
$equiv$ #LT(FIVE())(FIVE()) \
$(8 < 5)$
$equiv$ #LT(EIGHT())(FIVE()) \

=== Less than equal
$(5 <= 5)$
$equiv$ #LTEQ(FIVE())(FIVE()) \
$(4 <= 5)$
$equiv$ #LTEQ(FOUR())(FIVE()) \
$(5 <= 4)$
$equiv$ #LTEQ(FIVE())(FOUR()) \

=== Greater than
$(8 > 7)$
$equiv$ #GT(EIGHT())(SEVEN()) \
$(2 > 3)$
$equiv$ #GT(TWO())(THREE()) \
$(3 > 3)$
$equiv$ #GT(THREE())(THREE()) \

=== Greater than equal
$(8 >= 8)$
$equiv$ #GTEQ(EIGHT())(EIGHT()) \
$(8 >= 6)$
$equiv$ #GTEQ(EIGHT())(SIX()) \
$(6 >= 8)$
$equiv$ #GTEQ(SIX())(EIGHT()) \

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
