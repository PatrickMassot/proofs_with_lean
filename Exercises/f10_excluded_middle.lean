import ProofsWithLean.LibNeg
setup_env

open m154
/-
# File 10: Excluded middle, proofs by contradition and contraposition

## The excluded middle principle

After the `False` statement and the definition of negation, the third and final
ingredient of negation theory is the principle of excluded middle:

“For any statement P, P or ¬ P”.

This principle does not follow from the principle of explosion and the
definition of negation, but must be added as an axiom.

This axiom has many equivalent forms. We start by using it in its original
form.
-/

Example "Absolure value of a sum"
  Given: (x y : ℝ)
  Assume:
  Conclusion: |x + y| ≤ |x| + |y|
Proof:
  We discuss depending on whether 0 ≤ x + y or ¬ 0 ≤ x + y
  Assume h : 0 ≤ x + y
  Calc
   |x + y| = x + y since x + y ≥ 0
   _       ≤ |x| + |y| since x ≤ |x| and y ≤ |y|
  Assume h :  ¬ 0 ≤ x + y
  Since ¬ 0 ≤ x + y we get h' : x + y < 0
  Calc
    |x + y| = -(x + y) since x + y < 0
    _       = -x + (-y) by computation
    _       ≤ |x| + |y| since -x ≤ |x| and -y ≤ |y|
QED

/-
In the next exercise, you can implicit use the following facts:
`∀ x ≥ 0, |x| = x`
`∀ x < 0, x = - |x|`
`∀ x, x^2 ≥ 0`
`∀ x, (-x)^2 = x^2`
-/

Exercise "10.01 Absolute value of a square"
  Given: (x : ℝ)
  Assume:
  Conclusion: |x^2| = |x|^2
Proof:
  sorry
QED

/-
## Proofs by contradiction

We now turn to the second incarnation of the excluded middle principle:
the principle of proofs by contradiction. This reasoning is based on the
following consequence of the excluded middle:
For any statement `P`, `¬ ¬ P ⇒ P`.
Thus, to prove `P`, it suffices to prove `¬ ¬ P`. Now, by
definition, to prove `¬ ¬ P`, it suffices to assume `¬ P` and show
`False`. We deduce that, to show `P`, it suffices to assume `¬ P` and show a
contradiction.

Since this reasoning is very general and a little tedious, we abbreviate it to
the phrase “Assume for contradition `¬ P`”, where the `¬ P` can be replaced by an
equivalent formulation.

-/

Example "In a right-angle triangle with sides x, y and z, z being the
         hypothenuse, we have x + y > z."
  Given: (x y z : ℝ)
  Assume: (hx : x > 0) (hy : y > 0) (hP : z^2 = x^2 + y^2)
  Conclusion: z < x + y
Proof:
  Assume for contradiction hn : z ≥ x + y
  It suffices to prove that x^2 + y^2 > x^2 + y^2
  Since x > 0 and y > 0 we get hxpy: x + y > 0
  Since x > 0 and y > 0 we get hxmy: x * y > 0
  Calc
   x^2 + y^2 = z^2 by hypothesis
   _ ≥ (x + y)^2 since x + y ≥ 0 and z ≥ x + y
   _ = x^2 + y^2 + 2*x*y by computation
   _ > x ^ 2 + y ^ 2 since 2*x*y > 0
QED

/-
The following example repeats the limit uniqueness exercise from a previous
file. This result cannot be proven without using the excluded middle
principle somewhere. In the previous version, this use was hidden in the lemma
`∀ x y, (∀ ε > 0, |x - y| ≤ ε) ⇒ x = y`
(a variant of which will be proven below using the excluded middle
principle). This time, we illustrate the use of proof by contradiction and the
corresponding command `Assume for contradiction`.
-/

Example "Uniqueness of limits."
  Given: (u : ℕ → ℝ) (l l' : ℝ)
  Assume: (hl : u tends to l) (hl' : u tends to l')
  Conclusion: l = l'
Proof:
  Assume for contradiction H : l ≠ l'
  Fact ineg : |l - l'| > 0 by
    Since l ≠ l' we get H' : l - l' ≠ 0
    Since l - l' ≠ 0 we conclude that |l - l'| > 0
  Since u tends to l and |l - l'|/4 > 0 we get N
      such that hN : ∀ n ≥ N, |u n - l| ≤ |l - l'| / 4
  Since u tends to l' and |l - l'|/4 > 0 we get N'
      such that hN' : ∀ n ≥ N', |u n - l'| ≤ |l - l'| / 4
  Set N₀ := max N N' -- The `Set` command is never mandatory,
                     -- but can save a couple of letters.
  Since ∀ n ≥ N, |u n - l| ≤ |l - l'| / 4 and N₀ ≥ N
     we get hN₁ : |u N₀ - l| ≤ |l - l'| / 4
  Since ∀ n ≥ N', |u n - l'| ≤ |l - l'| / 4 and N₀ ≥ N'
     we get hN'₁ : |u N₀ - l'| ≤ |l - l'| / 4
  Let's prove it's contradictory -- this line is not mandatory
  -- The next line implicitly uses the statement `∀ x, x < x ⇒ False`
  It suffices to prove that |l - l'| < |l - l'|
  Calc
    |l - l'| ≤ |l - u N₀| + |u N₀ - l'|   by computation
    _        = |u N₀ - l| + |u N₀ - l'|   by computation
    _        ≤ |l - l'|/4 + |l - l'|/4    since |u N₀ -  l| ≤ |l - l'| / 4 and
                                                  |u N₀ - l'| ≤ |l - l'| / 4
    _        = |l - l'|/2                 by computation
    _        < |l - l'|                   since |l - l'| > 0
QED

Exercise "10.02 Numbers that are smaller than every positive number."
  Given: (x : ℝ)
  Assume: (h : ∀ ε > 0, x ≤ ε)
  Conclusion:  x ≤ 0
Proof:
  sorry
QED

/-
## The principle of contraposition

Another very useful incarnation of the excluded middle principle is the
contraposition principle: to prove “P ⇒ Q”, it suffices to prove
“not Q ⇒ not P”.

The following example illustrates the use of the contraposition principle and
the corresponding command `Let's prove the contrapositive: …`.
-/

Example "Commande de contraposition"
  Given: (P Q : Prop)
  Assume: (h : (¬ Q) ⇒ ¬ P)
  Conclusion: P ⇒ Q
Proof:
  Let's prove the contrapositive: (¬ Q) ⇒ ¬ P
  We conclude by hypothesis
QED

/-
Here is a more concrete exercise.
-/

Exercise "10.03 Concrete contraposition"
  Given: (f : ℝ → ℝ)
  Assume: (hf : f is injective)
  Conclusion: ∀ x y, x ≠ y ⇒ f x ≠ f y
Proof:
  sorry
QED

/-
The aim of the following exercise is to see how the principle of proof by contradiction
leads to the principle of contraposition. It is therefore crucial to
solve it without using `Let's prove the contrapositive: …` but using
`Assume for contradiction: …`.
-/
Exercise "10.04 The contraposition principle from the proof by contradiction principle."
  Given: (P Q : Prop)
  Assume: (h : (¬ Q) ⇒ ¬ P)
  Conclusion: P ⇒ Q
Proof:
  sorry
QED


/-
In this exercise, we'll reason by contraposition for one of the implications
and use the definitions of even and odd. You can also use the database of
implicitly usable lemmas, which contains the statements:
 `∀ n, ¬ n is even ⇒ n is odd`
 `∀ n, ¬ n is odd ⇒ n is even`
-/
Exercise "10.05 parity and squaring"
  Given: (n : ℤ)
  Assume:
  Conclusion: n^2 is even ⇔ n is even
Proof:
  sorry
QED


/-
## Negation of quantified statements

Understanding the negation of statements with quantifiers is crucial. In the
following exercise, we'll use only the definition of negation.
-/

Exercise "10.06 Negation of an existential statement"
  Given: (n : ℤ)
  Assume:
  Conclusion: ¬ (∃ k, n = 2*k) ⇔ ∀ k, n ≠ 2*k
Proof:
  sorry
QED

/-
In contrast, the negation rule for the universal quantifier requires the
excluded middle principle. So as not to overdo the pure logic in this course,
the following section explains how to use these negation rules without
demonstrating them.

## Pushing negation through a statement

The following example shows how `It suffices to prove that` can reformulate the
current goal by pushing a negation through quantifiers.
-/

Example "The function x ↦ 2x is not even."
  Given:
  Assume:
  Conclusion: ¬ (fct x ↦ 2*x) is even
Proof:
  Let's prove that ¬ ∀ x, 2 * (-x) = 2 * x -- This line is optionnal
  It suffices to prove that ∃ x : ℝ, 2 * (-x) ≠ 2 * x
  Let's prove that 42 works
  -- We compute -- or else:
  Assume hyp : 2 * -42 = 2 * 42
  Since 2 * -42 = 2 * 42 we conclude that False
QED

Exercise "10.07 The identity function, x ↦ x, has no upper bound."
  Given:
  Assume:
  Conclusion: ¬ ∃ M : ℝ, ∀ x, x ≤ M
Proof:
  sorry
QED

/-
This way of pushing negations is also available for the command
`Since … we get h: …` where the new hypothesis `h` can simply be obtained by
pushing the negation into the provided fact.
This also applies to the variant `Since … we conclude that …`, as shown in the
following example.
-/

Example "Pushing negationns through quantifiers."
  Given: (f : ℝ → ℝ)
  Assume: (h : ¬ ∀ x, f (-x) ≤ f x)
  Conclusion: ∃ x, f (-x) > f x
Proof:
  Since ¬ ∀ x, f (-x) ≤ f x we conclude that ∃ x, f (-x) > f x
QED

/-
You can use this way of pushing negation to prove a great classic of
logical “paradoxes”: in a non-empty bar, there is always one person `p` such
that if `p` drinks, then everyone drinks.

The proof begins with an application of the principle of excluded
middle, i.e. `We discuss depending on whether … or ¬ …` (with the same
statement to replace the two sets of suspension points).

You can skip this exercise if you're a bit behind the rest of the group.
-/
Exercise "10.08 The drinker paradox"
  Given: (x : Bar) -- The bar is non-empty, we denote by `x` someone in the bar.
  Assume:
  Conclusion: ∃ p : Bar, (p boit ⇒ ∀ q : Bar, q boit)
Proof:
  sorry
QED

/-
The “contrapose then push the negation” combination is so common that the
command `Let's prove the contrapositive: …` automatically tries to push the
negation after the contraposition to get the advertised contrapositive, as
you'll see in the following exercise which is the promised variant of
`∀ x y, (∀ ε > 0, |x - y| ≤ ε) ⇒ x = y`
(and was already proven by contradiction above).
-/

Exercise "10.09 Numbers smaller than every positive number."
  Given: (x : ℝ)
  Assume:
  Conclusion: (∀ ε > 0, x ≤ ε) ⇒ x ≤ 0
Proof:
  sorry
QED

/-
In the following exercise, we can use that the command
`We discuss depending on whether …`
knows the lemma `a ≤ b ⇒ a = b ∨ a < b`
So, to having the hypothesis `hxy : x ≤ y`, the command
`We discuss depending on whether x = y or x < y` allows the discussion to be
split into two branches, one assuming x = y and the other x < y.
-/

Exercise "10.10 Characterization of increasing functions"
  Given: (f : ℝ → ℝ)
  Assume:
  Conclusion: (∀ x y, x < y ⇒ f x < f y) ⇔ (∀ x y, (x ≤ y ⇔ f x ≤ f y))
Proof:
  sorry
QED

