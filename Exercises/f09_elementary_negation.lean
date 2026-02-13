import ProofsWithLean.LibNeg
setup_env

open m154
/-
# File 9: Negations

## The statement `False`

This file introduces the study of negation. The main novelty is the
introduction of a statement called `False`, which represents a mathematical
contradiction. The fundamental principle governing this statement is the rule

“For any statement P, False ⇒ P”.

known as the explosion principle by its traditional name “ex falso quodlibet”
(from false, you can deduce whatever you like).
-/

Example "If False then 0 = 1"
  Given:
  Assume:
  Conclusion: False ⇒ 0 = 1
Proof:
  Assume h : False
  Since False we conclude that 0 = 1
QED

-- From False, we can also deduce true things.

Example "If False then 0 = 0"
  Given:
  Assume:
  Conclusion: False ⇒ 0 = 0
Proof:
  Assume h : False
  Since False we conclude that 0 = 0
QED

/-
To emphasize that *everything* follows from False, you can explicitly make the
goal disappear with `Let's prove it's contradictory`.

The following example also illustrates that the course library can recognize a
number of false statements, such as `1 > 2`.
-/
Example "From contradictory assumptions, we can prove any statement."
  Given: (x : ℝ) (P : Statement)
  Assume: (hx : x = 1) (hx' : x > 2)
  Conclusion: P
Proof:
  -- We want to prove P. Ex falso quodlibet, hence it is enough to prove False.
  Let's prove it's contradictory
  Since x = 1 and x > 2 we get H : 1 > 2
  Since 1 > 2 we conclude that False
QED

Exercise "9.01 From contradictory assumptions, we can prove any statement."
  Given: (x : ℝ) (P : Statement)
  Assume: (hx : x < 0) (hx' : x > 0)
  Conclusion: P
Proof:
  sorry
QED

/-
In the previous example, Lean deduced `False` from a false numerical inequality.
The course’s database of facts also contains the incompatibility of certain
facts, in other words implications of the form `(P ∧ Q) ⇒ False`. For example,
the fact that an integer cannot be both even and odd.

In this case, `Let's prove it's contradictory` is essential to ensure the expected
conclusion is `False` before mentioning those incompatible facts.
-/

Exercise "9.02 If some inteer is even and odd then 0 = 1."
  Given: (n : ℤ)
  Assume: (h_pair : n is even) (h_impair : n is odd)
  Conclusion: 0 = 1
Proof:
  sorry
QED

/-
## Negation

The False statement is used to define negation. By definition, the negation of
a statement `P` is the statement `P ⇒ False`, noted in general `¬ P`. We can
read `¬ P` as “P is false” (more on this later).

In particular, to directly prove a statement of the form `¬ P`, we must assume
`P` and show `False`. Let's see an example, knowing that the symbol `≠` is,
by definition, the negation of `=`.
-/

Example "Proving a negation"
  Given: (x : ℕ)
  Assume: (hyp : x^3 + x^2 - x + 3 = 0)
  Conclusion: x ≠ 1
Proof:
  Assume hyp' : x = 1
  Let's prove that False -- this line is optional but clarifies things
  It suffices to prove that 0 = 4
  Calc
    0 = x^3 + x^2 - x + 3 by hypothesis
    _ = 1^3 + 1^2 - 1 + 3 since x = 1
    _ = 4                 by computation
QED

Exercise "9.03 Proving a negation"
  Given: (x : ℕ)
  Assume: (hyp : x^4 + 2*x^2 + x - 2 = 0)
  Conclusion: x ≠ 1
Proof:
  sorry
QED

/-
Now here's the most famous example of negation in mathematics:
`¬ ∃ x ∈ ℚ, x^2 = 2`
which is often stated as `¬ √2 ∈ ℚ`, but the above writing has the advantage of
remaining entirely in the world of rational numbers.

To simplify the exercise just a little, we'll prove the equivalent
statement involving only a pair of relative integers (which would be the
numerator and denominator of a fraction of square 2):

`¬ ∃ p q : ℤ, p^2 = 2*q^2 ∧ q ≠ 0`.

There are several ways of showing this statement, depending on how much
arithmetic knowledge we assume. Here, we assume knowledge of the
fundamental theorem of arithmetic: every non-zero integer admits a unique decomposition
into a product of prime factors.
In particular, there exists a function `v₂ : ℤ → ℕ` such that, for any
non-zero integer `p`, `p = 2^(v₂ p) * m` with `m` odd.
Thus `v₂ p` is the exponent of 2 in the decomposition to product of prime
factors of `p` (the letter “v” is the initial of the word “valuation”).

In the following exercise, we won’t need the above formula, it will suffice to
use that the course library knows the following results:

`∀ n : ℤ, v₂ (n^2) is even`

`∀ n : ℤ, n ≠ 0 ⇒ v₂ (2*n) = v₂ n + 1`

`∀ n : ℤ, n ≠ 0 ⇒ n^2 ≠ 0`

Note that in this exercise, facts of the form `x ≠ 0` will be used
“atomically”: the fact that `≠` is defined via a negation will not play any role.
-/

Exercise "9.04 Irrationality of √2"
  Given: (p q : ℤ)
  Assume: (hq : q ≠ 0)
  Conclusion: p^2 ≠ 2*q^2
Proof:
  sorry
QED

/-
Let's take a look at how to *use* a negation.

The following example is written in a somewhat cumbersome way to show the
mechanism for using negation.
-/


Example "Using a negation"
  Given: (x : ℝ)
  Assume: (h : x ≠ 0) (h' : x*(x - 1) = 0)
  Conclusion: x = 1
Proof:
  Since x*(x - 1) = 0 we get H : x = 0 ∨ x - 1 = 0
  We discuss depending on whether x = 0 or x - 1 = 0
  Assume H : x = 0
  Let's prove it's contradictory
  Since x = 0 and x ≠ 0 we conclude that False
  Assume H : x - 1 = 0
  Since x - 1 = 0 we conclude that x = 1
QED

/-
The cumbersome part is the discussion of the two cases, when we already know
that one of them is impossible. It can be abbreviated to :
```
  Since x*(x - 1) = 0 we get H : x = 0 ∨ x - 1 = 0
  Since x = 0 ∨ x - 1 = 0 and x ≠ 0 we get H' : x - 1 = 0
```

Much more often, a hypothesis that is a negation is used to prove a goal
that is also a negation.
-/

Example "Deducing a negation from a negation."
  Given: (x y : ℝ)
  Assume: (h1 : x ≤ y) (h2 : x ≠ y)
  Conclusion: ¬ y ≤ x
Proof:
  Assume h' : y ≤ x
  Since y ≤ x and x ≤ y we get h3 : x = y
  Since x = y and x ≠ y we conclude that False
QED

/-
The last line of the previous example is an example of a much more general and
important fact: the definition of negation allows us to show immediately that,
for any statement `P`, if `P` is true then it is not false.
-/

Exercise "9.05 If a statement `P` is true then it’s not false."
  Given: (P : Statement)
  Assume: (h : P)
  Conclusion: ¬ (¬ P)
Proof:
  sorry
QED

/-
For logic enthusiasts, here's another exercise on the definition of negation.
You can skip this exercise if pure logic scares you, or if you're behind the
rest of the group.
-/

Exercise "9.06 If a statement implies its negation then it is false."
  Given: (P : Prop)
  Assume: (h : P ⇒ ¬ P)
  Conclusion: ¬ P
Proof:
  sorry
QED

/-
Another important theoretical remark is that the definition of negation and the
explosion principle ensure that, for any statement `P`, the negation of `P` is
true if and only if `P` is equivalent to `False`. This is why we can read `¬ P`
as “`P` is false”.

You can skip this exercise if pure logic scares you or if you're a bit behind
the rest of the group. The proof is longer than the previous exercise,
but not fundamentally more complicated.
-/

Exercise "9.07 A statement P is false if and only if it is equivalent to False."
  Given: (P : Statement)
  Assume:
  Conclusion: (¬ P) ⇔ (P ⇔ False)
Proof:
  sorry
QED


