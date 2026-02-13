import ProofsWithLean.Lib
setup_env

/-
# Sheet 11: Negation and limits of sequences

The 4 parts of Exercise 11.1 are special: there is nothing to prove!
You must instead complete the statement, writing only quantifiers
without negation and writing “tends to”.
On the other hand, you must use the rules of negation for composite
expressions (see Section 10.3 of the course).

Then check your answer by replacing the `sorry` in the proof
by `verify`.

We recall the definition of “u tends to l”:
∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - l| ≤ ε
-/

Exercise "11.1a Negation of « u tends to l »"
  Given: (u : ℕ → ℝ) (l : ℝ)
  Assume:
  Conclusion: (¬ u tends to l) ↔
  sorry
Proof:
  sorry
QED

Exercise "11.1b Negation of « f is continuous at x₀ »"
  Given: (f : ℝ → ℝ) (x₀ : ℝ)
  Assume:
  Conclusion:
    ¬ (∀ ε > 0, ∃ δ > 0, ∀ x, |x - x₀| ≤ δ ⇒ |f x - f x₀| ≤ ε) ↔
  sorry
Proof:
  sorry
QED

/-
In the following exercise, it is useful to remember that
“∀ x x', ...” is an abbreviation for “∀ x, ∀ x', ...”.
Similarly, “∃ x x', ...” is an abbreviation for
“∃ x, ∃ x', ...”.
-/
Exercise "11.1c Negation of « f is uniformly continuous on ℝ »"
  Given: (f : ℝ → ℝ)
  Assume:
  Conclusion:
    ¬ (∀ ε > 0, ∃ δ > 0, ∀ x x', |x' - x| ≤ δ ⇒ |f x' - f x| ≤ ε) ↔
  sorry
Proof:
  sorry
QED

Exercise "11.1d Negation of « f is sequentially continuous at x₀ »"
  Given: (f : ℝ → ℝ) (x₀ : ℝ)
  Assume:
  Conclusion:
    ¬ (∀ u : ℕ → ℝ, (u tends to x₀) ⇒ (f ∘ u) tends to (f x₀)) ↔
  sorry
Proof:
  sorry
QED

/-
The rest of this sheet explores elementary applications of negation
in the study of convergence of real sequences.

We recall that “we conclude that” can reveal easy contradictions,
as in the following example.
-/

Example "Inequalities and contradiction"
  Given: (a b : ℝ)
  Assume: (h : a < b) (h' : b < a)
  Conclusion: False
Proof:
  Fact H : a < a by
    Calc
      a < b by hypothesis
      _ < a by hypothesis
  Since a < a we conclude that False
QED

/-
The following variant is also possible.
-/

Example "Inequalities and contradiction, a variant"
  Given: (a b : ℝ)
  Assume: (h : a < b) (h' : b < a)
  Conclusion: False
Proof:
  It suffices to prove that a < a
  Calc
    a < b by hypothesis
    _ < a by hypothesis
QED

/-
Warning: if you want to use this method with concrete numbers
rather than variables like `a` or `b`, you must help Lean
understand whether you are talking about real numbers or integers.

For example, if the goal is `False`, you can write
`It suffices to show that (2 : ℝ) ≤ 1`.

Or write

Fact contradictory : (2 : ℝ) ≤ 1 because
  …
Since 2 ≤ 1 we conclude that False

We recall that the database of implicitly usable lemmas contains,
among others, the lemmas:

`∀ x y, |x| ≤ y ↔ -y ≤ x ∧ x ≤ y`

`∀ p q r, r ≥ max p q ↔ r ≥ p ∧ r ≥ q`

`∀ p q, p ≤ max p q`

`∀ p q, q ≤ max p q`

We also have the definition, for any real sequence `u`:

`u tends to +∞` if `∀ A, ∃ N, ∀ n ≥ N, u n ≥ A`.
-/

Exercise "11.2 If u tends to +∞ then u does not tend to any finite limit"
  Given: (u : ℕ → ℝ)
  Assume:
  Conclusion: u tends to +∞ ⇒ ∀ l, ¬ u tends to l
Proof:
  sorry
QED

Exercise "11.3 If u is non-decreasing and tends to l then all u n are less than l"
  Given: (u : ℕ → ℝ) (l : ℝ)
  Assume: (h : u tends to l) (h' : u is non-decreasing)
  Conclusion: ∀ n, u n ≤ l
Proof:
  sorry
QED

/-
In the following exercises, “A : Set ℝ” means that A is a set of
real numbers. We use the usual notation x ∈ A to say that a real
number x belongs to the set A.

The notation “∀ x ∈ A, ...” is an abbreviation for
“∀ x, x ∈ A ⇒ ...”.

Given a real number `x` and a set of real numbers `A`,
`x upper bounds A` means `∀ a ∈ A, a ≤ x`,
and
`x is the supremum of A` means
`x upper bounds A ∧ ∀ y, y upper bounds A ⇒ x ≤ y`.

Warning: the universal quantifier consumes everything to its right,
so parentheses are essential.
-/

-- Exercise "11.4 If x is the supremum of A, then for every y < x there exists
-- an element of A strictly greater than y"
--   Given: (A : Set ℝ) (x : ℝ)
--   Assume: (hx : x is the supremum of A)
--   Conclusion: ∀ y, y < x ⇒ ∃ a ∈ A, y < a
-- Proof:
--   sorry
-- QED

/-
The following exercise is a variant of Exercise 10.9.
The command Exercise-lemma ensures that this statement can be used
implicitly by the commands `Since` or `It suffices to show that`.
-/

Exercise-lemma inferior_if_inferior_plus_eps
  "Let x and y be real numbers. If y ≤ x + ε for all ε > 0, then y ≤ x."
  Given: (x y : ℝ)
  Assume:
  Conclusion: (∀ ε > 0, y ≤ x + ε) ⇒ y ≤ x
Proof:
  sorry
QED

Exercise "11.6 If u tends to x and u n ≤ y for all n, then x ≤ y"
  Given: {x y : ℝ} {u : ℕ → ℝ}
  Assume: (hu : u tends to x) (ineg : ∀ n, u n ≤ y)
  Conclusion: x ≤ y
Proof:
  sorry
QED
