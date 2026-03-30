#let ID(x) = {
  return x
}

// BOOLEAN LOGIC

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

#let AND(p) = {
  let AND_INNER(q) = {
    return p(q)(p)
  }
  return AND_INNER
}

#let OR(p) = {
  let OR_INNER(q) = {
    return p(p)(q)
  }
  return OR_INNER
}

#let NOT(p) = {
  return p(FALSE)(TRUE)
}

#let IF(p) = {
  return p
}

//PAIRS

#let PAIR(x) = {
  let PAIR_INNER(y) = {
    let PAIRC(f) = {
      f(x)(y)
    }
    return PAIRC
  }
  return PAIR_INNER
}

#let FST(p) = {
  return p(TRUE)
}

#let SND(p) = {
  return p(FALSE)
}

// NUMBERS

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

#let ONE() = {
  return SUCC(ZERO)
}

#let TWO() = {
  return SUCC(ONE())
}

#let THREE() = {
  return SUCC(TWO())
}

#let FOUR() = {
  return SUCC(THREE())
}

#let FIVE() = {
  return SUCC(FOUR())
}

#let SIX() = {
  return SUCC(FIVE())
}

#let SEVEN() = {
  return SUCC(SIX())
}

#let EIGHT() = {
  return SUCC(SEVEN())
}

#let NINE() = {
  return SUCC(EIGHT())
}

#let TEN() = {
  return SUCC(NINE())
}

#let ADD(m) = {
  let ADD_INNER(n) = {
    m(SUCC)(n)
  }
  return ADD_INNER
}

#let TIMES(m) = {
  let TIMESC(n) = {
    let TIMESCC(f) = {
      m((n)(f))
    }
    return TIMESCC
  }
  return TIMESC
}

#let POWER(b) = {
  let POWERC(e) = {
    return e(b)
  }
  return POWERC
}

#let PRED(n) = {
  let PREDC(f) = {
    let PREDCC(x) = {
      let cl0(g) = {
        let cl00(h) = {
          h(g(f))
        }
        return cl00
      }
      let cl1(u) = {
        return x
      }
      let cl2(u) = {
        return u
      }
      n(cl0)(cl1)(cl2)
    }
    return PREDCC
  }
  return PREDC
}

#let PRED_EFF(n) = {
  let STEP(p) = {
    return PAIR(SND(p))(SUCC(SND(p)))
  }
  return FST(n(STEP)(PAIR(ZERO)(ZERO)))
}

#let MINUS(m) = {
  let MINUSC(n) = {
    n(PRED)(m)
  }
  return MINUSC
}

// COMPARISIONS

#let IS_ZERO(n) = {
  let ALWAYS_FALSE(ignore) = {
    return FALSE
  }
  return n(ALWAYS_FALSE)(TRUE)
}

#let LTEQ(m) = {
  let LESSC(n) = {
    return IS_ZERO(MINUS(m)(n))
  }
  return LESSC
}

#let EQ(m) = {
  let EQC(n) = {
    AND(LTEQ(m)(n))(LTEQ(n)(m))
  }
  return EQC
}

#let LT(m) = {
  let LTC(n) = {
    AND(NOT(EQ(m)(n)))(LTEQ(m)(n))
  }
  return LTC
}

#let GT(m) = {
  let GTC(n) = {
    NOT(LTEQ(m)(n))
  }
  return GTC
}

#let GTEQ(m) = {
  let GTC(n) = {
    NOT(LT(m)(n))
  }
  return GTC
}

// RECURSION

#let Y(f) = {
  let STEP(x) = {
    f(x(x))
  }
  return STEP(STEP)
}

#let Z(f) = {
  let STEP(x) = {
    let STEPC(v) = {
      let RECURSE = x(x)
      return f(RECURSE)(v)
    }
    return STEPC
  }

  let LEFT = STEP(STEP)
  return f(LEFT)
}

// SOME COOL FUNCTIONS

#let FACTORIAL_P(g) = {
  let FACTORIALC(n) = {
    let TRUE_B(v) = { return ONE() }
    let FALSE_B(v) = { return TIMES(n)(g(PRED_EFF(n))) }
    return IF(IS_ZERO(n))(TRUE_B)(FALSE_B)(ID)
  }
  return FACTORIALC
}

#let FACTORIAL = Z(FACTORIAL_P)

#let MOD_P(g) = {
  let MODC(a) = {
    let MODCC(b) = {
      let IS_LESS = LT(a)(b)

      let TRUE_BRANCH(v) = { return a }
      let FALSE_BRANCH(v) = { return g(MINUS(a)(b))(b) }

      return IF(IS_LESS)(TRUE_BRANCH)(FALSE_BRANCH)(ID)
    }
    return MODCC
  }
  return MODC
}

#let MODULO = Z(MOD_P)

// PRINT NUMS

#let PLUS_1_INT(x) = {
  return x + 1
}

#let CHURCH_TO_INT(x) = {
  return x(PLUS_1_INT)(0)
}
