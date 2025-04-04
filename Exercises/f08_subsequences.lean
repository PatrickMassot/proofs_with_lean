import ProofsWithLean.Lib
setup_env

open m154
/-
# File 8: Subsequences, cluster points and Cauchy sequences.
-/

/-
This file continues the study of elementary real analysis, covering
subsequences, cluster points and Cauchy sequences. There are no new Lean commands
to learn. However, the exercises are on the whole a little more difficult
mathematically than in File 7. It is therefore pointless to work on this file
if file 7 is not firmly understood.

Some potentially useful lemmas are recalled. The commands `Since` and
`It suffices to prove that` and the justification `since` for computation steps
know the lemma

`∀ x y |x| ≤ y ↔ -y ≤ x ∧ x ≤ y`

The command `We compute` and the justification `by computation` know the lemmas

`∀ x y, |x + y| ≤ |x| + |y|`

`∀ x y z, |x - y| ≤ |x - z| + |z - y|`

`∀ x y, |x - y| = |y - x|`

`∀ p q r, r ≥ max p q  ⇒ r ≥ p ∧ r ≥ q`

`∀ p q, max p q ≥ p`

`∀ p q, max p q ≥ q`


We also recall the definition:

`u tends to l : ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - l| ≤ ε`

Given a function `φ : ℕ → ℕ`, we say that `φ is an extraction` if it is
increasing:
`∀ n m, n < m → φ n < φ m`

The commands `Since` and `It suffices to prove that` and the `since`
justification of the computation steps know the following lemma (its proof is
an immediate induction).

`φ is an extraction ⇒ ∀ n, n ≤ φ n`

as well as the result

`u tends to l ∧ u tends to l' ⇒ l = l `

proven in the previous file.

For the following exercise, it's also useful to remember that the notation
`∃ n ≥ N, P n` is short for `∃ n, n ≥ N ∧ P n`.
-/

Exercise-lemma extraction_superieur
  "08.1 If `φ` is an extraction then it takes arbitrarily large value
        for arbitrarily large indices."
  Given: {φ : ℕ → ℕ}
  Assume: (h : φ is an extraction)
  Conclusion: ∀ N N', ∃ n ≥ N', φ n ≥ N
Proof:
  sorry
QED

/-
The preceding exercise is an exercise-lemma, so you can invoke it implicitly in
the following proofs.

A real `a` is a cluster point of a sequence `u` if there exists a sequence
extracted from `u` that tends to `a`:

`a is a cluster point of u : ∃ φ, φ is an extraction ∧ (u ∘ φ) tends to a'
-/

Exercise-lemma valeur_proche_adherence
  "08.2 If `a` is a cluster point of `u` then there are values of
  `u` arbitrarily close to `a` for arbitrarily large indices."
  Given: {u : ℕ → ℝ} {a : ℝ}
  Assume: (hyp : a is a cluster point of u)
  Conclusion: ∀ ε > 0, ∀ N, ∃ n ≥ N, |u n - a| ≤ ε
Proof:
  sorry
QED

Exercise-lemma limit_extraction_of_limit
  "08.3 If `u` tends to `l` then all its subsequences tend to `l`."
  Given: {u : ℕ → ℝ} {φ : ℕ → ℕ} {l : ℝ}
  Assume: (h : u tends to l) (hφ : φ is an extraction)
  Conclusion:  u ∘ φ tends to l
Proof:
  sorry
QED

Exercise-lemma cluster_pt_lim
  "08.4 If a sequence `u` tends to `l` then it has no other cluster point."
  Given: {u : ℕ → ℝ} {l a : ℝ}
  Assume: (hl : u tends to l) (ha : a is a cluster point of u)
  Conclusion: a = l
Proof:
  sorry
QED

/-
A sequence `u` is Cauchy if its values are arbitrarily close to each other for
sufficiently large indices:

`u is Cauchy : ∀ ε > 0, ∃ N, ∀ p ≥ N, ∀ q ≥ N, |u p - u q| ≤ ε`
-/

Exercise-lemma cauchy_of_tendsto
  "08.5 If a sequence `u` converges then it is Cauchy."
  Given: {u : ℕ → ℝ}
  Assume:
  Conclusion: (∃ l, u tends to l) → u is Cauchy
Proof:
  sorry
QED

/-
In the following exercise, we can use the statement proven above:

`a is a cluster point of u ⇒ ∀ ε > 0, ∀ N, ∃ n ≥ N, |u n - a| ≤ ε`
-/

Exercise "08.6
  If a Cauchy sequence `u` admits a cluster point `l` then it tends to `l`."
  Given: (u : ℕ → ℝ) (l : ℝ)
  Assume: (hu : u is Cauchy) (hl :  l is a cluster point of u)
  Conclusion: u tends to l
Proof:
  sorry
QED

