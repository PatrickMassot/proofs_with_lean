import ProofsWithLean.LibNeg
setup_env

example (f : ℝ → ℝ) (u : ℕ → ℝ) (x₀ : ℝ)
    (hf : continuous_function_at f x₀) (hu : sequence_tendsto u x₀) :
    sequence_tendsto (f ∘ u) (f x₀) :=
  fun ε ε_pos ↦ (hf ε ε_pos).elim
   fun δ ⟨δ_pos, hδ⟩ ↦ (hu δ δ_pos).elim
     fun N hN ↦ ⟨N, fun n n_ge ↦ hδ (u n) <| hN n n_ge⟩


example (f : ℝ → ℝ) (u : ℕ → ℝ) (x₀ : ℝ)
    (hf : continuous_function_at f x₀) (hu : sequence_tendsto u x₀) :
    sequence_tendsto (f ∘ u) (f x₀) := by
  intro ε ε_pos
  rcases hf ε ε_pos with ⟨δ, δ_pos, hδ⟩
  rcases hu δ δ_pos with ⟨N, hN⟩
  use N
  intro n n_ge
  apply hδ
  apply hN
  exact n_ge

-- Using controlled natural language but almost same level of help from Lean
-- (difference: specify what `intro` means)

Exercise "Continuity implies sequential continuity"
  Given: (f : ℝ → ℝ) (u : ℕ → ℝ) (x₀ : ℝ)
  Assume: (hu : u tends to x₀) (hf : f is continuous at x₀)
  Conclusion: (f ∘ u) tends to f x₀
Proof:
  Fix ε > 0
  By hf applied to ε using ε_pos we get δ such that δ_pos and Hf
  By hu applied to δ using δ_pos we get N such that Hu
  Let's prove that N works
  Fix n ≥ N
  We apply Hf
  We apply Hu
  We conclude by n_ge
QED

-- Now using controlled natural language and less help from computer
-- (no `We apply` without stating the new goal, and announce more intermediate goals).

Exercise "Continuity implies sequential continuity"
  Given: (f : ℝ → ℝ) (u : ℕ → ℝ) (x₀ : ℝ)
  Assume: (hu : u tends to x₀) (hf : f is continuous at x₀)
  Conclusion: (f ∘ u) tends to f x₀
Proof:
  Let's prove that ∀ ε > 0, ∃ N, ∀ n ≥ N, |f (u n) - f x₀| ≤ ε
  Fix ε > 0
  By hf applied to ε using ε_pos we get δ such that
    (δ_pos : δ > 0) and (Hf : ∀ x, |x - x₀| ≤ δ ⇒ |f x - f x₀| ≤ ε)
  By hu applied to δ using δ_pos we get N such that Hu : ∀ n ≥ N, |u n - x₀| ≤ δ
  Let's prove that N works : ∀ n ≥ N, |f (u n) - f x₀| ≤ ε
  Fix n ≥ N
  By Hf applied to u n it suffices to prove |u n - x₀| ≤ δ
  We conclude by Hu applied to n using n_ge
QED

-- Removing some hypotheses names

Exercise "Continuity implies sequential continuity"
  Given: (f : ℝ → ℝ) (u : ℕ → ℝ) (x₀ : ℝ)
  Assume: (hu : u tends to x₀) (hf : f is continuous at x₀)
  Conclusion: (f ∘ u) tends to f x₀
Proof:
  Let's prove that ∀ ε > 0, ∃ N, ∀ n ≥ N, |f (u n) - f x₀| ≤ ε
  Fix ε > 0
  By hf applied to ε using that ε > 0 we get δ such that -- Note “using that ε > 0”
    (δ_pos : δ > 0) and (Hf : ∀ x, |x - x₀| ≤ δ ⇒ |f x - f x₀| ≤ ε)
  By hu applied to δ using that δ > 0 we get N such that Hu : ∀ n ≥ N, |u n - x₀| ≤ δ
  Let's prove that N works : ∀ n ≥ N, |f (u n) - f x₀| ≤ ε
  Fix n ≥ N
  By Hf applied to u n it suffices to prove |u n - x₀| ≤ δ
  We conclude by Hu applied to n using that n ≥ N
QED

-- Removing all references to assumption names

Exercise "Continuity implies sequential continuity"
  Given: (f : ℝ → ℝ) (u : ℕ → ℝ) (x₀ : ℝ)
  Assume: (hu : u tends to x₀) (hf : f is continuous at x₀)
  Conclusion: (f ∘ u) tends to f x₀
Proof:
  Let's prove that ∀ ε > 0, ∃ N, ∀ n ≥ N, |f (u n) - f x₀| ≤ ε
  Fix ε > 0
  Since f is continuous at x₀ and ε > 0 we get δ such that
    (δ_pos : δ > 0) and (Hf : ∀ x, |x - x₀| ≤ δ ⇒ |f x - f x₀| ≤ ε)
  Since u tends to x₀ and δ > 0 we get N such that Hu : ∀ n ≥ N, |u n - x₀| ≤ δ
  Let's prove that N works : ∀ n ≥ N, |f (u n) - f x₀| ≤ ε
  Fix n ≥ N
  Since ∀ x, |x - x₀| ≤ δ → |f x - f x₀| ≤ ε it suffices to prove that |u n - x₀| ≤ δ
  Since ∀ n ≥ N, |u n - x₀| ≤ δ and n ≥ N we conclude that |u n - x₀| ≤ δ
  /- -- Forward reasoning variation
  Since ∀ n ≥ N, |u n - x₀| ≤ δ and n ≥ N we get h : |u n - x₀| ≤ δ
  Since ∀ x, |x - x₀| ≤ δ → |f x - f x₀| ≤ ε and |u n - x₀| ≤ δ we conclude that |f (u n) - f x₀| ≤ ε -/
QED

-- In the previous examples, we can use the `help` tactic and the widgets

-- Let’s now see computations and implicit lemmas

-- set_option trace.Verbose true
Example "The squeeze theorem."
  Given: (u v w : ℕ → ℝ) (l : ℝ)
  Assume: (hu : u tends to l) (hw : w tends to l)
    (h : ∀ n, u n ≤ v n)
    (h' : ∀ n, v n ≤ w n)
  Conclusion: v tends to l
Proof:
  Let's prove that ∀ ε > 0, ∃ N, ∀ n ≥ N, |v n - l| ≤ ε
  Fix ε > 0
  Since u tends to l and ε > 0 we get N such that hN : ∀ n ≥ N, |u n - l| ≤ ε
  Since w tends to l and ε > 0 we get N' such that hN' : ∀ n ≥ N', |w n - l| ≤ ε
  Let's prove that max N N' works : ∀ n ≥ max N N', |v n - l| ≤ ε
  Fix n ≥ max N N'
  Since ∀ n ≥ N,  |u n - l| ≤ ε and n ≥ N  we get hNl  : |u n - l| ≤ ε
  Since ∀ n ≥ N', |w n - l| ≤ ε and n ≥ N' we get hN'l : |w n - l| ≤ ε
  Let's prove that |v n - l| ≤ ε
  Let's first prove that -ε ≤ v n - l
  Calc -ε ≤ u n - l since |u n - l| ≤ ε
       _  ≤ v n - l since u n ≤ v n
  Let's now prove that v n - l ≤ ε
  Calc v n - l ≤ w n - l  since v n ≤ w n
       _       ≤ ε        since |w n - l| ≤ ε
QED

-- An exmple with contrapositive, and some lemmas about even and odd numbers

Example "Parity and squaring"
  Given: (n : ℤ)
  Assume:
  Conclusion: n^2 is even ⇔ n is even
Proof:
  Let's first prove that n ^ 2 is even ⇒ n is even
  · Let's prove the contrapositive: ¬n is even ⇒ ¬n ^ 2 is even
    It suffices to prove that n is odd ⇒ n^2 is odd
    Assume hyp : n is odd
    Since n is odd we get k such that hk : n = 2 * k + 1
    Since n = 2 * k + 1 it suffices to prove that (2 * k + 1)^2 is odd
    Let's prove that 2*k*(k+1) works
    We compute
  Let's now prove that n is even ⇒ n ^ 2 is even
  · Assume hyp : n is even
    Since n is even we get k such that hk : n = 2 * k
    Since n = 2 * k it suffices to prove that (2 * k)^2 is even
    Let's prove that 2*k^2 works
    We compute
QED

/- Let’s see how to introduce ad hoc lemmas for students.

Here we tell students that `v₂` is the function sending an integer to the
exponent of 2 in it prime factors decomposition. There are only two facts
needed about this function

`∀ p : ℤ, v₂ (p^2) is even`

`∀ p : ℤ, p ≠ 0 ⇒ v₂ (2*p) = v₂ p + 1`

We also registered a bunch of lemmas about even and odd numbers
(that we can list for students).
-/

-- set_option trace.Verbose true in
Exercise "Irrationality of √2"
  Given: (p q : ℤ)
  Assume: (hq : q ≠ 0)
  Conclusion: p^2 ≠ 2*q^2
Proof:
  Assume H : p^2 = 2 * q^2
  Let's prove that False
  Since v₂ (p^2) is even it suffices to prove that v₂ (p^2) is odd
  Since v₂ (q^2) is even we get k such that hk : v₂ (q^2) = 2*k
  Let's prove that k works: v₂ (p^2) = 2*k + 1
  Since q ≠ 0 we get hq' : q^2 ≠ 0
  Calc
    v₂ (p ^ 2) = v₂ (2*q^2)   since p^2 = 2*q^2
    _          = v₂ (q^2) + 1 since q^2 ≠ 0
    _          = 2 * k + 1    since v₂ (q^2) = 2*k
QED

-- Let’s see a slightly different layout

Exercise "Irrationality of √2"
  Given: (p q : ℤ)
  Assume: (hq : q ≠ 0)
  Conclusion: p^2 ≠ 2*q^2
Proof:
  Assume H : p^2 = 2 * q^2
  Let's prove that False
  Since q ≠ 0 we get h₁ : q^2 ≠ 0
  Fact h₁ : v₂ (p^2) = v₂ (q^2) + 1 by Calc
    v₂ (p ^ 2) = v₂ (2*q^2)    since p^2 = 2*q^2
    _          = v₂ (q^2) + 1  since q^2 ≠ 0
  Since v₂ (q^2) is even we get h₂ : v₂ (q^2) + 1 is odd
  Since v₂ (p^2) = v₂ (q^2) + 1 and v₂ (q^2) + 1 is odd
    we get  h₃ : v₂ (p^2) is odd
  Since v₂ (p^2) is even and v₂ (p^2) is odd we conclude that False
QED
