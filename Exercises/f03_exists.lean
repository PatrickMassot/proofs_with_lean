import ProofsWithLean.Lib
setup_env
open m154

/-
# File 3: Existential quantifier
-/

/-
In the following example, we prove a statement of the form `∃ x, P x` using the
command `Let's prove that _ works`.
-/
Example "Existence proof"
  Given:
  Assume:
  Conclusion: ∃ x : ℝ, x*x = 4
Proof:
  Let's prove that -2 works  -- Is it the only possibility?
  We compute
QED

Exercise "03.1"
  Given:
  Assume:
  Conclusion: ∃ x : ℝ, x*x = 16
Proof:
  sorry
QED

/-
In the following example, we use an assumption of the form `∃ x : X, P x` using
the command `Since … we get … such that`.

There are two things to note in the calculation.

Firstly, the first line could be justified by writing
`n = n' + 1 since n = n' + 1`,
but this awkward formulation is avoided by writing `n = n' + 1 by hypothesis`.

Secondly, the fact that `n' + 1` is strictly positive is true without making
any hypothesis about the natural number `n'`, so we can justify it with `by
computation`.
-/

Example "Use of some existence, followed by a computation."
  Given: (n : ℕ)
  Assume: (h : ∃ n', n = n' + 1)
  Conclusion: n > 0
Proof:
  Since ∃ n', n = n' + 1 we get n' such that hn' : n = n' + 1
  Calc
    n = n' + 1 by hypothesis
    _ > 0      by computation
QED

/-
Alternatively, we can use `Since … it suffices to prove that …` to
transform the current goal by substitution using an equality.
-/

Example "Use of some existence, followed by a substitution."
  Given: (n : ℕ)
  Assume: (h : ∃ n', n = n' + 1)
  Conclusion: n > 0
Proof:
  Since ∃ n', n = n' + 1 we get n' such that hn' : n = n' + 1
  Since n = n' + 1 it suffices to prove that n' + 1 > 0
  We compute
QED

/-
You can now choose between those two styles.
-/

Exercise "03.2 Use of an existence"
  Given: (n : ℕ)
  Assume: (h : ∃ n', n = n' + 3)
  Conclusion: n > 0
Proof:
  sorry
QED

/-
Note that there are usually several `x` that work. In the following
example, there are two (unless y is zero). To emphasize that we've fixed one,
we call it `x₀`.

This example includes a discussion according to the sign of x₀ but at this
stage it is not useful to remember how this discussion is initiated. The
demonstration also implicitly uses the sign rule for products.
-/
Example "Every square is non-negative."
  Given: (y : ℝ)
  Assume: (h : ∃ x, y = x*x)
  Conclusion: y ≥ 0
Proof:
  Since ∃ x, y = x*x we get x₀ such that hy₀ : y = x₀*x₀
  Since y = x₀*x₀ it suffices to prove that x₀*x₀ ≥ 0
  We discuss depending on whether 0 ≤ x₀ or x₀ < 0
  Assume h' : 0 ≤ x₀
  Since 0 ≤ x₀ we conclude that x₀*x₀ ≥ 0
  Assume h' : x₀ < 0
  Since x₀ ≤ 0 we conclude that x₀*x₀ ≥ 0
QED

/-
The following exercises use the divisibility relation in ℤ.
Warning: the divisibility bar is not the one on the keyboard, but obtained by
pressing `,|`.

In the following example, we improve readability by specifying what “works”
means.
-/

Example "Divisibility is transitive."
  Given: (a b c : ℤ)
  Assume: (h1 : a ∣ b) (h2 : b ∣ c)
  Conclusion: a ∣ c
Proof:
  Since a ∣ b we get k such that hk : b = a*k -- (1)
  Since b ∣ c we get l such that hl : c = b*l -- (2)
  -- In order to prove a ∣ c, we need to find m such that c = a*m
  Let's prove that ∃ m, c = a * m
  Let's prove that k*l works:c = a * (k * l)
  Calc
    c = b*l     since c = b*l
    _ = (a*k)*l since b = a*k
    _ = a*(k*l) by computation
QED

/-
Let’s now see a similar statement.
-/

Exercise "03.3 Divisibility and addition."
  Given: (a b c : ℤ)
  Assume: (h1 : a ∣ b) (h2 : a ∣ c)
  Conclusion: a ∣ b+c
Proof:
  sorry
QED

/-
We now begin to explicitly combine quantifiers with the definition of
surjectivity.

Recall that `f is surjective` means `∀ y, ∃ x, f x = y`.
-/

/-
The next example also illustrate the use of the `We rename` command.
-/

Example "If g ∘ f is surjective then g is surjective."
  Given: (f g : ℝ → ℝ)
  Assume: (hyp : (g ∘ f) is surjective)
  Conclusion: g is surjective
Proof:
/- We start with a very verbose proof, but this discussion is very important
   to understand in order to understand the difference between bound and free
   variables. -/
  Let's prove that ∀ y, ∃ x, g x = y
  Fix y
  We reformulate hyp as ∀ y, ∃ x, (g ∘ f) x = y
  -- A priori the `y` symbol appearing in this assumption has nothing to do with
  -- the `y` we fixed. It is a bound variable.
  -- We can rename it to z.
  We rename y to z at hyp
  -- We also have variables named `x` in both `hyp` and the goal.
  -- But they are both bound variable, with no relationship.
  -- Let’s rename the one appearing in `hyp` for clarity.
  We rename x to w at hyp
  -- We can specialize assumpion `hyp` to the `y` we fixed, and get some `w`
  Since ∀ z, ∃ w, (g ∘ f) w = z we get w : ℝ such that hw : g (f w) = y
  Let's prove that f w works
  -- We need to prove `g(f(w)) = y` but, by definition of composition,
  -- this is nothing else than our assumption on `w`.
  -- On paper we would have simply written “f(w) works”.
  We conclude by hypothesis
QED

/-
Of course, most of the above discussion is useless from a logical point of
view. Neither Lean nor expert readers needs all this talk. Here's a concise
version of the same proof.
-/
Example "If g ∘ f is surjective then g is surjective."
  Given: (f g : ℝ → ℝ)
  Assume: (hyp : (g ∘ f) is surjective)
  Conclusion: g is surjective
Proof:
  Fix y
  Let's prove that ∃ x, g x = y -- This line is optional but makes reading easier
  Since (g ∘ f) is surjective we get w : ℝ such that hw : (g ∘ f) w = y
  Let's prove that f w works
  We conclude by hypothesis
QED

Exercise "03.4 A composition of surjective functions is surjective"
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is surjective) (hg : g is surjective)
  Conclusion: (g ∘ f) is surjective
Proof:
  sorry
QED

