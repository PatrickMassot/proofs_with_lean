import ProofsWithLean.Lib
setup_env

/-
# File 7: Convergent sequences.
-/

/-
A sequence u is a function of ℕ in ℝ, so Lean writes `u : ℕ → ℝ`.

`u tends to l` means `∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - l| ≤ ε`

Bear in mind that `∀ ε > 0, …` is short for `∀ ε, ε > 0 ⇒ …`.

To prove a statement that begins like this, the command `Fix` allows you
to use the abbreviation
`Fix ε > 0`
in place of the sequence of commands
`Fix ε : ℝ`
`Assume ε_pos : ε > 0`.

To use a statement that begins this way, we need to give the command `Since` the
statement and the fact that the number to which we want to specialize the
statement is strictly positive.

Let's look at an artificial example first.
-/

Example "Statements starting with ∀ ε > 0"
  Given: (u : ℕ → ℝ)
  Assume: (hu : ∀ δ > 0, ∃ n, u n < δ)
  Conclusion:  ∀ ε > 0, ∃ n, u n < ε/2
Proof:
  Fix ε > 0
  Since ∀ δ > 0, ∃ n, u n < δ and ε/2 > 0 we conclude that ∃ n, u n < ε/2
QED

/-
In the example above, note that the use of the letter `δ` in the hypothesis and
`ε` in the conclusion makes things clearer, because we can say that we have
“specialized the hypothesis to `δ = ε/2`”. But `ε` and `δ` are bound
variables so we can name both `ε` without changing anything.

Now let's look at an example that uses the limit definition.
-/

Example "An example to get started."
  Given: (u v : ℕ → ℝ) (l : ℝ)
  Assume: (hu : u tends to l) (hv : ∀ n, v n = u n - l)
  Conclusion: v tends to 0
Proof:
  Fix ε > 0
  Since u tends to l and ε > 0 we get N₁ such that hN₁ : ∀ n ≥ N₁, |u n - l| ≤ ε
  Let's prove that N₁ works
  Fix N ≥ N₁
  Since ∀ n ≥ N₁, |u n - l| ≤ ε and N ≥ N₁ we get hN₁' : |u N - l| ≤ ε
  Calc
    |v N - 0| = |u N - l - 0| since ∀ n, v n = u n - l
    _         = |u N - l|     by computation
    _         ≤ ε             by hypothesis
QED

Exercise "07.1 If u is constant with value l, then u tends to l"
  Given: (u : ℕ → ℝ) (l : ℝ)
  Assume:
  Conclusion: (∀ n, u n = l) ⇒ u tends to l
Proof:
  sorry
QED

/-
Concerning absolute values, the database of results usable without explicitly
mentioning them includes

`∀ x y, |x + y| ≤ |x| + |y|`

`∀ x y z, |x - y| ≤ |x - z| + |z - y|`

`∀ x y, |x - y| = |y - x|`

These three results are used by the `We compute` command (or `by computation` in `Calc`).

The commands `Since …` and `It suffices to prove that …` know that
`∀ x y, |x| ≤ y ⇔ -y ≤ x and x ≤ y`

It is advisable to note these lemmas on a sheet of paper as they can be useful
in every exercise.
-/

Exercise "07.2 If u tends to some strictly positive l, then u n ≥ l/2 for large enough n."
  Given: (u : ℕ → ℝ) (l : ℝ)
  Assume: (hl : l > 0)
  Conclusion: (u tends to l) ⇒ ∃ N, ∀ n ≥ N, u n ≥ l/2
Proof:
  sorry
QED

/-
The results database also contains results concerning the maximum of two numbers

`∀ p q, p ≤ max p q`

`∀ p q, q ≤ max p q`

It is advisable to note these lemmas on a sheet of paper as they may be useful
in each exercise.
-/

Exercise "07.3 If u tends to l and v tends to l', then u+v tends to l+l'"
  Given: (u v : ℕ → ℝ) (l l' : ℝ)
  Assume: (hu : u tends to l) (hv : v tends to l')
  Conclusion: (u + v) tends to (l + l')
Proof:
  sorry
QED

Exercise "07.4 The squeeze theorem"
  Given: (u v w : ℕ → ℝ) (l : ℝ)
  Assume: (hu : u tends to l) (hw : w tends to l)
               (h : ∀ n, u n ≤ v n) (h' : ∀ n, v n ≤ w n)
  Conclusion: v tends to l
Proof:
  sorry
QED

Exercise "07.5 The last inequality in the definition of limits can be replaced
          by a strict one."
  Given: (u : ℕ → ℝ) (l : ℝ)
  Assume:
  Conclusion: (u tends to l) ⇔ ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - l| < ε
Proof:
  sorry
QED

/-
In the following exercise we can use that the command
`It suffices to prove that`
knows the lemma
`∀ x y : ℝ, (∀ ε > 0, |x - y| ≤ ε) ⇒ x = y`

and the command `Since` knows the lemmas
`∀ a b, max a b ≥ a`
and
`∀ a b, max a b ≥ b`
-/


Exercise "07.6 A sequence u admits at most one limit."
  Given: (u : ℕ → ℝ) (l l' : ℝ)
  Assume: (hl : u tends to l) (hl' : u tends to l')
  Conclusion: l = l'
Proof:
  sorry
QED

/-
`M is supremum of u` means
  (∀ n, u n ≤ M) ∧ (∀ ε > 0, ∃ n₀, u n₀ ≥ M - ε)
-/
Exercise "07.7 Every non-decreasing sequence having a supremum tends to this supremum."
  Given: (u : ℕ → ℝ) (M : ℝ)
  Assume: (h : M is supremum of u) (h' : u is non-decreasing)
  Conclusion: u tends to M
Proof:
  sorry
QED

