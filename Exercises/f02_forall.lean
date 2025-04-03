import ProofsWithLean.Lib_en
setup_env

/-
# File 2: Universal quantifier
-/

/-
Recall `f is even` mean `∀ x, f (-x) = f x` and
`f is odd` means `∀ x, f (-x) = -f x`.

Dans l’exemple suivant, on démontre un énoncé de la forme `∀ x, P x` using
la commande `Fix`.
-/

Example "The function that maps `x` to `x²` is even."
  Given:
  Assume:
  Conclusion: (fct x ↦ x^2) is even
Proof:
  Fix x : ℝ
  Let's prove that (-x)^2 = x^2
  We compute
QED

Exercise "02.1 The function that maps `x` to `x³` is odd."
  Given:
  Assume:
  Conclusion: (fct x ↦ x^3) is odd
Proof:
  sorry
QED

/-
In the following examples, we use a statement beginning with a universal
quantifier with the commands `Since … we conclude that …` or `Since … we get …`
depending on whether we obtain the desired conclusion directly or wish to
obtain an intermediate fact.
-/

Example "Specializing a parity assumption to conclude."
  Given: (f : ℝ → ℝ)
  Assume: (hf : f is even)
  Conclusion: f (-5) = f 5
Proof:
  Since f is even we conclude that f (-5) = f 5
QED

Example "Specializing a parity assumption to create an intermediate fact."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is even)
  Conclusion: g (f (-5)) = g (f 5)
Proof:
  Since f is even we get hf5 : f (-5) = f 5
  Since f (-5) = f 5 we conclude that g (f (-5)) = g (f 5)
QED

Exercise "02.2 Specializing a parity assumption to create an intermediate fact."
  Given: (f : ℝ → ℝ)
  Assume: (hf : f is odd)
  Conclusion: f (-3) = -f 3
Proof:
  sorry
QED

/-
Let's now look at an example that proves a quantified statement using two
quantified hypotheses.
In this example, we name the real number introduced by the `Fix` command `x₀`
to emphasize the fact that it is fixed and clearly see that after the line
`Since f is even we get hf₀ : f (-x₀) = f x₀`, the new hypothesis `hf₀`
relates to this number alone.

Note also that the `by computation` justification, intended for steps not using
an assumption, deals with the definition of the addition of functions.
Similarly, in subsequent exercises, it will deal with the definition of the
composition of functions.
-/

Example "If f and g are even then so is their sum."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is even) (hg : g is even)
  Conclusion: (f + g) is even
Proof:
  Let's prove that ∀ x, (f + g) (-x) = (f + g) x
  Fix x₀ : ℝ
  Since f is even we get hf₀ : f (-x₀) = f x₀
  Since g is even we get hg₀ : g (-x₀) = g x₀
  Calc
    (f + g) (-x₀) = f (-x₀) + g (-x₀) by computation
    _             = f x₀ + g (-x₀)    since f (-x₀) = f x₀
    _             = f x₀ + g x₀       since g (-x₀) = g x₀
    _             = (f + g) x₀        by computation
QED

/-
In the previous proof, the line starting with “Let's prove that” is
purely psychological; Lean doesn't need it at all.

Finally, Lean doesn't really need to be told which real to apply the parity
assumptions to, he just needs to look in the equality to justify, so the
specialization lines are unnecessary.

So you can also use the version below.
-/

Example "If f and g are even then so is their sum, with a concise proof."
  Given: (f g : ℝ → ℝ)
  Assume:(hf : f is even) (hg : g is even)
  Conclusion: (f + g) is even
Proof:
  Fix x₀
  Calc
    (f + g) (-x₀) = f (-x₀) + g (-x₀) by computation
    _             = f x₀ + g (-x₀)    since f is even
    _             = f x₀ + g x₀       since g is even
    _             = (f + g) x₀        by computation
QED

Exercise "02.3 Precomposing by an even function leads to an even function."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is even)
  Conclusion: (g ∘ f) is even
Proof:
  sorry
QED

Exercise "02.4 Any composition of odd functions is odd."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is odd) (hg : g is odd)
  Conclusion: (g ∘ f) is odd
Proof:
  sorry
QED

