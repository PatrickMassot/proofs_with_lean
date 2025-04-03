import ProofsWithLean.Lib_en
setup_env

/-
# File 1 : Computations

The software knows the usual algebraic simplification rules.
This enables it to demonstrate equalities between expressions involving
arbitrary numbers, without any assumptions.

Let's start with an example where the result is clear to the naked eye.
-/

Example "Purely algebraic easy computation"
  Given: (a b : ℝ)
  Assume:
  Conclusion: a + b - a = b
Proof:
  We compute
QED

/-
The computer verifies this kind of result by patiently expanding everything.
The important thing is that the result requires no assumptions about the numbers
`a` and `b`. We'll call this “purely algebraic” calculation.
-/

Example "Purely algebraic computation that looks less easy"
  Given: (a b : ℝ)
  Assume:
  Conclusion: (a + b)^3 - (a - b)^3 = 6*a^2*b + 2*b^3
Proof:
  We compute
QED

/-
It’s your turn to play!
-/
Exercise "01.1 Purely algebraic computation that looks less easy"
  Given: (a b : ℝ)
  Assume:
  Conclusion: (a + b)^3 + (a - b)^3 = 6*a*b^2 + 2*a^3
Proof:
  sorry
QED

/-
The more interesting stuff starts when you make assumptions.
You can then alternate between steps involving these assumptions and purely
algebraic calculation steps.

Each hypothesis has a name, but it's not necessary to refer to it.
In the following example, we make the assumption that `b` is `2`, and we name
this assumption `hb`. The first line of the calculation invokes this
assumption, while the second is purely algebraic. The `by computation`
justification does exactly the same job as `We compute`.
-/

Example "A computation involving an assumption"
  Given: (a b : ℝ)
  Assume: (hb : b = 2)
  Conclusion: a + a*b = 3*a
Proof:
  Calc
    a + a*b = a + a*2 since b = 2
    a + a*2 = 3*a     by computation
QED

/-
It’s important to distinguish between the two types of calculation steps shown
above. The first involves a hypothesis, the second does not.

Indentation rules are a little subtle, especially when a
calculation doesn't complete the demonstration. The safest thing to do is
always to leave `Calc` alone on its line and then indent the following lines,
with the same level of indentation from one line to the next.

The alignment of equality signs and justifications is purely cosmetic.

Repeating the `a + a*2` is a pain. Since on paper, you can do without it. On
paper we write nothing, here we replace the repetition by `_`, still with the
same alignment rule.
-/

Example "The same calculation, without repeating the right-hand-side to left on
         the next line."
  Given: (a b : ℝ)
  Assume: (hb : b = 2)
  Conclusion: a + a*b = 3*a
Proof:
  Calc
    a + a*b = a + a*2 since b = 2
    _       = 3*a     by computation
QED

Exercise "01.2 Computation in two steps, using an assumption."
  Given: (a b : ℝ)
  Assume: (ha : a = -b)
  Conclusion: b + b*(a + b) = b
Proof:
  sorry
QED

Exercise "01.3 Computation in four steps, using an assumption."
  Given: (a b c : ℝ)
  Assume: (h : a = -b) (h' : b + c = 0)
  Conclusion: b*(a - c) = 0
Proof:
  sorry
QED

/-
Computations can also prove inequalities.
-/

Example "A first inequality"
  Given: (a b : ℝ)
  Assume: (h : a ≤ 2*b)
  Conclusion: a + b ≤ 3*b
Proof:
  Calc
    a + b ≤ 2*b + b since a ≤ 2*b
    _     = 3*b     by computation
QED

Exercise "01.4 Inequality"
  Given: (a b : ℝ)
  Assume: (h : b ≤ a)
  Conclusion: a + b ≤ 2*a
Proof:
  sorry
QED

Exercise "01.5 Inequality"
  Given: (a b : ℝ)
  Assume: (h : a + b ≤ 3)
  Conclusion: 2*a + b ≤ a + 3
Proof:
  sorry
QED

/-
Note that the `Calc` command handles the sequence of relationship symbols, in
this case an inequality followed by an equality. Let's look at an example
also involving a strict inequality. Note that linking an inequality with a
strict inequality results in a strict inequality.
-/

Example "Inequalities and strict inequalities"
  Given: (a b : ℝ)
  Assume: (h : a + b ≤ 3) (hb : a < 5)
  Conclusion: 2*a + b < 8
Proof:
  Calc
    2*a + b = a + a + b by computation
    _       ≤ a + 3     since a + b ≤ 3
    _       < 5 + 3     since a < 5
    _       = 8         by computation
QED

Exercise "01.6 Inequalities and strict inequalities"
  Given: (a b : ℝ)
  Assume: (h : 2*a + b ≤ 3) (hb : a < 5)
  Conclusion: 3*a + b < 8
Proof:
  sorry
QED


/-
A calculation step may involve two assumptions as justification. It is
important to understand that the aim is not to combine two lines of calculation
into one. In the following example, the inequality `b*(a + b) ≤ b*3` requires
both that `a + b ≤ 3` and that `b ≥ 0`, so it cannot be split into two steps.
-/

Example "Inequality with two justification items"
  Given: (a b : ℝ)
  Assume: (h : a + b ≤ 3) (h' : b ≥ 0)
  Conclusion: b*(a + b) ≤ 3*b
Proof:
  Calc
    b*(a + b) ≤ b*3 since a + b ≤ 3 and b ≥ 0
    _         = 3*b by computation
QED

Exercise "01.7 Inequality with two justification items"
  Given: (a b : ℝ)
  Assume: (h : a + b ≤ 2) (h' : a ≥ 0)
  Conclusion: a*(a + b) + a ≤ 3*a
Proof:
  sorry
QED

