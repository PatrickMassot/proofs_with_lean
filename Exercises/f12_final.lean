import ProofsWithLean.LibBis
setup_env


open m154
/-
# Sheet 12: The grand finale
-/

/-
This sheet uses the entire MDD 154 course to prove several of the most
subtle theorems of the first-semester analysis course: the sequential
characterization of upper bounds, the equivalence between sequential
continuity and continuity, the fact that every function continuous on
a closed interval is bounded and attains its maximum, and finally the
Intermediate Value Theorem.

It is pointless to attempt this sheet without being comfortable with
the previous ones. Reviewing earlier sheets and asking questions is
always a good idea.

We begin with a preliminary warm-up: a variant of passing to the limit
in an inequality proved in Sheet 11, with the opposite inequality and
only from some rank onward. This result will be used in the proof of
the Intermediate Value Theorem (recall that any statement introduced
with the keyword `Exercise-lemma` becomes a lemma that can be used
implicitly in subsequent exercises).

We may use the usual lemmas:

  `∀ x y, |x| ≤ y ⇔ -y ≤ x ∧ x ≤ y`

  `∀ p q r, r ≥ max p q ⇔ r ≥ p ∧ r ≥ q`

  `∀ p q, p ≤ max p q`

  `∀ p q, q ≤ max p q`

as well as the lemma

  `∀ x y, (∀ ε > 0, y ≤ x + ε) ⇒ y ≤ x`

proved in Sheet 11.
-/

Exercise-lemma le_lim
  "12.01 If u tends to x and y ≤ u n for all sufficiently large n, then y ≤ x."
  Given: {x y : ℝ} {u : ℕ → ℝ}
  Assume: (hu : u tends to x)
          (ineg : ∃ N, ∀ n ≥ N, y ≤ u n)
  Conclusion: y ≤ x
Proof:
  sorry
QED

/-
The first serious objective of this sheet is to prove the sequential
characterization of upper bounds. For this, and for what follows, we
will need many results from the previous sheets, and a few extras.

In Sheet 8, we proved that a constant sequence converges to its value:

  `∀ (x : ℝ), (sequence n ↦ x) tends to x`

In Sheet 11, we introduced the following definitions:

A real number x is an upper bound of a set of real numbers A:
  `x upper bounds A` means `∀ a ∈ A, a ≤ x`

A real number x is the supremum of a set of real numbers A:
  `x is a supremum of A` means
  `x upper bounds A ∧ ∀ y, y upper bounds A ⇒ x ≤ y`

and showed that if x is the supremum of A, then for every y < x,
there exists an element of A strictly greater than y:

  `x is a supremum of A ⇒ (∀ y < x, ∃ a ∈ A, y < a)`

We also showed:
  `(u tends to x) ∧ (∀ n, u n ≤ y) ⇒ x ≤ y`

In the following exercises, one may also use the lemmas:

  `∀ n : ℕ, 1/(n + 1) > 0`

  `∀ ε > 0, ∃ N : ℕ, ∀ n ≥ N, 1/(n + 1 : ℝ) ≤ ε`

and the following easy consequences:

  `limit_if_bounded_by_inv (h : ∀ n, |u n - x| ≤ 1/(n+1)) : u tends to x`

  `∀ x : ℝ, (sequence n ↦ x + 1/(n+1)) tends to x`

  `∀ x : ℝ, (sequence n ↦ x - 1/(n+1)) tends to x`

Be careful with statements such as `∀ n : ℕ, 1/(n + 1) > 0`.
Without `: ℕ`, Lean cannot know whether the quantification is over
natural numbers or real numbers.

We will use the squeeze theorem proved earlier:

  `∀ u v w,
     (lim_u : u tends to l) ∧ (lim_w : w tends to l) ∧
     (hu : ∀ n, u n ≤ v n) ∧ (hw : ∀ n, v n ≤ w n)
     ⇒ v tends to l`

To apply it, we will write:

  By the squeeze theorem it suffices to show that
    u tends to l and
    w tends to l and
    ∀ n, u n ≤ v n and
    ∀ n, v n ≤ w n

Finally, note the appearance below of the command
`As ... we choose ... such that`, corresponding to the axiom of choice.
-/

Exercise-lemma upper_bound_to_sequence
  "12.02a If x is the supremum of a set A, then there exists a sequence of
   elements of A that tends to x."
  Given: {A : Set ℝ} {x : ℝ}
  Assume: (h : x is supremum of A)
  Conclusion: ∃ u : ℕ → ℝ, (u tends to x) ∧ ∀ n, u n ∈ A
Proof:
  Fact F1 : ∀ n : ℕ, ∃ a ∈ A, x - 1/(n+1) < a by
    sorry
  Since ∀ n : ℕ, ∃ a ∈ A, x - 1/(n+1) < a
    we choose u such that
      hu : ∀ n, u n ∈ A
      and hu' : ∀ n : ℕ, x - 1/(n+1) < u n
  sorry
QED

/-
We now prove the converse, which is much easier.
To simplify the administrative part, instead of assuming the existence
of a sequence, we include it directly in the statement.
-/

Exercise-lemma supremum_if_upper_bound_and_sequence
  "12.02b If x is an upper bound of A and there exists a sequence of elements
   of A tending to x, then x is the supremum of A."
  Given: {A : Set ℝ} {x : ℝ} {u : ℕ → ℝ}
  Assume: (x_maj : x bounds above A)
          (u_x : u tends to x)
          (u_A : ∀ n, u n ∈ A)
  Conclusion: x is supremum of A
Proof:
  sorry
QED

/-
The following exercises use the definition of continuity of a function
from ℝ to ℝ at a point.

`f is continuous at x₀` means
`∀ ε > 0, ∃ δ > 0, ∀ x, |x - x₀| ≤ δ ⇒ |f x - f x₀| ≤ ε`
-/

Exercise-lemma seq_continuous_if_continuous
  "12.03 A function continuous at x₀ is sequentially continuous at x₀"
  Given: {f : ℝ → ℝ} {u : ℕ → ℝ}
  Assume: (hf : f is continuous at x₀) (hu : u tends to x₀)
  Conclusion: f ∘ u tends to f x₀
Proof:
  sorry
QED

Exercise "12.04 Sequential continuity at x₀ implies continuity at x₀."
  Given: (f : ℝ → ℝ) (x₀ : ℝ)
  Assume:
  Conclusion:
    (∀ u : ℕ → ℝ, (u tends to x₀) ⇒ f ∘ u tends to f x₀) ⇒
    f is continuous at x₀
Proof:
  sorry
QED

/-
We now use the usual notation [a, b] for a closed interval.
Recall:
  `x ∈ [a, b] ⇔ a ≤ x ∧ x ≤ b`
-/

Exercise-lemma extracted_infinite_limit
  "12.5 If u tends to +∞ then all extracted sequences also tend to +∞."
  Given: {u : ℕ → ℝ}
  Assume: (h : u tends to +∞) (hφ : φ is an extraction)
  Conclusion: u ∘ φ tends to +∞
Proof:
  sorry
QED

Exercise-lemma infinite_squeeze
  "12.06 The squeeze theorem for infinite limits."
  Given: {u v : ℕ → ℝ}
  Assume: (hu : u tends to +∞) (huv : ∀ n, u n ≤ v n)
  Conclusion: v tends to +∞
Proof:
  sorry
QED

Exercise-lemma bounded_segment
  "12.07 Every function continuous on a closed interval is bounded above."
  Given: {f : ℝ → ℝ} {a b : ℝ}
  Assume: (hf : ∀ x ∈ [a, b], f is continuous at x)
  Conclusion: ∃ M, ∀ x ∈ [a, b], f x ≤ M
Proof:
  Assume for contradiction H : ∀ M, ∃ x ∈ [a, b], M < f x
  Fact F : ∀ n : ℕ, ∃ x ∈ [a, b], f x > n by
    Fix n
    We conclude by hypothesis
  Since ∀ n : ℕ, ∃ x ∈ [a, b], f x > n
    we choose u : ℕ → ℝ
      such that hu : ∀ n, u n ∈ [a, b]
      and hu' : ∀ n, f (u n) > n
  By bolzano_weierstrass using that ∀ n : ℕ, u n ∈ [a, b]
    we get
      (c : ℝ) (c_mem : c ∈ [a, b])
      (φ : ℕ → ℕ) (φ_extr : φ is an extraction)
      (lim_uφ : u ∘ φ tends to c)
  sorry
QED

Exercise-lemma continuous_opposite
  "12.08 If f is continuous at x₀, then -f is also continuous at x₀."
  Given: {f : ℝ → ℝ} {x₀ : ℝ}
  Assume: (h : f is continuous at x₀)
  Conclusion: (fun x ↦ -f x) is continuous at x₀
Proof:
  sorry
QED

Exercise-lemma bounded_below_segment
  "12.09 Every function continuous on a closed interval is bounded below."
  Given: {f : ℝ → ℝ} {a b : ℝ}
  Assume: (hf : ∀ x ∈ [a, b], f is continuous at x)
  Conclusion: ∃ m, ∀ x ∈ [a, b], m ≤ f x
Proof:
  Fact key : ∃ M, ∀ x ∈ [a, b], -f x ≤ M by
    sorry
  sorry
QED

Exercise "12.10 Every continuous function on a nonempty closed interval
admits a maximum."
  Given: {a b : ℝ} {f : ℝ → ℝ}
  Assume: (hab : a ≤ b) (hf : ∀ x ∈ [a, b], f is continuous at x)
  Conclusion: ∃ x₀ ∈ [a, b], ∀ x ∈ [a, b], f x ≤ f x₀
Proof:
  Since ∀ x ∈ [a, b], f is continuous at x
    we get m such that hm : ∀ x ∈ [a, b], m ≤ f x
  Since ∀ x ∈ [a, b], f is continuous at x
    we get M such that hM : ∀ x ∈ [a, b], f x ≤ M
  Set A := {y | ∃ x ∈ [a, b], y = f x}
  Fact step1 : ∃ y₀ ∈ [m, M], y₀ is supremum of A by
    sorry
  Since ∃ y₀ ∈ [m, M], y₀ is supremum of A
    we get y₀ such that
      y_mem : y₀ ∈ [m, M]
      and y_sup : y₀ is supremum of A
  Since y₀ is supremum of A we get y_maj : y₀ bounds above A
  Since y₀ is supremum of A we get u : ℕ → ℝ such that
    lim_u : u tends to y₀
    and u_mem : ∀ n, u n ∈ A
  Since ∀ n, u n ∈ A
    we choose v : ℕ → ℝ such that
      v_mem : ∀ n, v n ∈ [a, b]
      and hufv : ∀ n, u n = f (v n)
  Since ∀ n, u n = f (v n) we get hu_eq : u = f ∘ v
  sorry
QED

Exercise "12.11 The Intermediate Value Theorem"
  Given: (f : ℝ → ℝ)
  Assume: (hf : ∀ x, f is continuous at x)
          (h₀ : f 0 < 0)
          (h₁ : f 1 > 0)
  Conclusion: ∃ x₀ ∈ [0, 1], f x₀ = 0
Proof:
  Set A := {x | x ∈ [0, 1] ∧ f x < 0}
  Fact ex_x₀ : ∃ x₀ ∈ [0, 1], x₀ is supremum of A by
    sorry
  Since ∃ x₀ ∈ [0, 1], x₀ is supremum of A
    we get x₀ such that
      x₀_mem : x₀ ∈ [0, 1]
      and x₀_sup : x₀ is supremum of A
  Let's prove that x₀ works
  Since x₀ ∈ [0, 1] it suffices to prove that f x₀ = 0
  Fact fx₀_le : f x₀ ≤ 0 by
    sorry
  Fact x₀_lt : x₀ < 1 by
    sorry
  Since f x₀ ≤ 0 it suffices to prove that f x₀ ≥ 0
  Fact inside' : ∃ N : ℕ, ∀ n ≥ N, x₀ + 1/(n+1) ∈ [0, 1] by
    Fact inside'' : ∃ N : ℕ, ∀ n ≥ N, 1/(n+1) ≤ 1 - x₀ by
      sorry
    sorry
  Since ∃ N : ℕ, ∀ n ≥ N, x₀ + 1/(n+1) ∈ [0, 1]
    we get N : ℕ such that
      hN : ∀ n ≥ N, x₀ + 1/(n+1) ∈ [0, 1]
  Fact not_in : ∀ n : ℕ, x₀ + 1/(n+1) ∉ A by
    sorry
  sorry
QED
