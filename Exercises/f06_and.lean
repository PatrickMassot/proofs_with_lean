import ProofsWithLean.LibPgcd_en
setup_env

namespace m154
open Nat M154
/-
# File 6 : Conjunctions

Given two statements `P` and `Q`, the statement `P` and `Q` (denoted `P ∧ Q`)
is called the *conjunction* of `P` and `Q` :

`P ∧ Q` is true if and only if `P` and `Q` are both true.

## Proving a conjunction

To demonstrate a conjunction `P ∧ Q`, both statements `P` and `Q` must be
proven. To do this, we use the command `Let's first prove that ...` to
announce the first goal and then, once this goal has been proved,
`Let's now prove that ...` (these are the same commands as for proving the two
implications of an equivalence).
-/

Example "Proving a conjunction."
  Given: (a : ℝ)
  Assume: (ha : a > 0)
  Conclusion: a^2 > 0 ∧ |a| > 0
Proof:
  Let's first prove that a^2 > 0
  Since a > 0 we conclude that a^2 > 0
  Let's now prove that |a| > 0
  Since a > 0 we get H : a ≠ 0
  Since a ≠ 0 we conclude that |a| > 0
QED

Exercise "06.1 Proving a conjunction."
  Given: (a : ℝ)
  Assume: (ha : a > 0)
  Conclusion: 2*a > 0 ∧ (a^2)^2 > 0
Proof:
  sorry
QED

/-
The course also has a small database of statements that include implications
whose hypothesis is a conjunction, leading to the need to prove conjunctions.
These statements can be used without justification using the command
`It suffices to prove that ...`
as usual with implicit implications.

An example of such a statement is `∀ x y, (-y ≤ x ∧ x ≤ y) ⇒ |x| ≤ y`.
-/

Example "Proving a statement following from a conjunction."
  Given: (a b : ℝ)
  Assume: (h : a - b ≥ -1) (h' : a - b ≤ 1)
  Conclusion: |a - b| ≤ 1
Proof:
  It suffices to prove that -1 ≤ a - b and a - b ≤ 1
  Let's first prove that -1 ≤ a - b
  We conclude by hypothesis
  Let's now prove that a - b ≤ 1
  We conclude by hypothesis
QED


/-
## Using a conjunction

To use that a conjunction `P ∧ Q` is true we use that the statements `P` and
`Q` are both true.

To do this, we use the command
`Since P ∧ Q we get hP : P and hQ : Q`
where `hP` and `hQ` are any of the available names.
-/

Example "Using a conjunction"
  Given: (a : ℝ)
  Assume: (h : 0 ≤ a ∧ a ≤ 1)
  Conclusion: a ≤ 2
Proof:
  Since 0 ≤ a ∧ a ≤ 1 we get ha : 0 ≤ a and ha' : a ≤ 1
  Since a ≤ 1 we conclude that a ≤ 2
QED

/-
In the example above, the `ha` assumption is never used, so we can omit it.
-/
Example "Utilisation d’une partie d’une conjonction"
  Given: (a : ℝ)
  Assume: (h : 0 ≤ a ∧ a ≤ 1)
  Conclusion: a ≤ 2
Proof:
  Since 0 ≤ a ∧ a ≤ 1 we get ha' : a ≤ 1
  Since a ≤ 1 we conclude that a ≤ 2
QED

/-
Furthermore, the `Since` command takes the initiative of splitting the
conjunctions appearing to hypothèse when looking for justifications of
statements appearing between `Since` and `we conclude that` or `we get` or
`it suffices to prove that`. We can therefore be satisfied with the second line
in the above demonstration.
-/

Exercise "06.2 Using a conjunction"
  Given: (a b : ℝ)
  Assume: (hab : a ≤ b ∧ b ≤ 1)
  Conclusion: a ≤ 1
Proof:
  sorry
QED

Exercise "06.3 Using a conjunction"
  Given: (a b : ℝ)
  Assume: (hab : 0 ≤ b ∧ a ≤ 1)
  Conclusion: a*b ≤ b
Proof:
  sorry
QED

/-
The course also has a small database of implications with a conjunction as the
conclusion. These statements can be used without justification.

An example of such a statement is `∀ x y, |x| ≤ y ⇒ (-y ≤ x ∧ x ≤ y)`.
-/

Example "Using a statement implying a conjunction"
  Given: (a b : ℝ)
  Assume: (ha : |a| ≤ 1)
  Conclusion: a ≤ 2
Proof:
  Since |a| ≤ 1 and |a| ≤ 1 ⇒ -1 ≤ a ∧ a ≤ 1 we get ha' : -1 ≤ a and ha'' : a ≤ 1
  Since a ≤ 1 we conclude that a ≤ 2
QED

/-
In fact, you can even leave the implication implicit.
-/

Example "Using a statement implying a conjunction,
         without mentioning the implication."
  Given: (a b : ℝ)
  Assume: (ha : |a| ≤ 1)
  Conclusion: a ≤ 2
Proof:
  Since |a| ≤ 1 we get ha' : -1 ≤ a and ha'' : a ≤ 1
  Since a ≤ 1 we conclude that a ≤ 2
QED

/-
Another statement of the same type, which will be used very frequently in the
following files, is
`∀ x a b, x ≥ max a b ⇒ (x ≥ a ∧ x ≥ b)`.
-/

Exercise "06.4 Using a lemma from the database whose conclusion is a
          conjunction."
  Given: (x a b : ℝ)
  Assume: (hx : x ≥ max a b) (ha : a ≥ 1)
  Conclusion: x ≥ 1
Proof:
  sorry
QED

/-
The next exercise requires more thought. It involves the notion of gcd of two
natural numbers and divisibility. Remember that the divisibility bar is not the
bar above the Enter on a qwerty keyboard, but a unicode symbol that can be
obtained by `,dvd`.

The `We compute` command (and its cousin the `by computation` justification in
`Calc`) know that
`∀ a b, gcd a b ∣ a`
and
`∀ a b, gcd a b ∣ b`
and also
`∀ a, a ∣ a`.

The lemma database contains the statement
`∀ a b : ℕ, (a ∣ b ∧ b ∣ a) ⇒ a = b`
(note that this statement is false for integers and, for this reason,
the following exercise would not work with relative integers).

It also contains the statement
`∀ a b c : ℕ, (c ∣ a ∧ c ∣ b) ⇒ c ∣ gcd a b`

These five statements are enough to do the exercise.
-/

Exercise "06.5 Divisibility and gcd"
  Given: (a b : ℕ)
  Assume:
  Conclusion: a ∣ b ⇔ gcd a b = a
Proof:
  sorry
QED

/-
L’exercice suivant nécessite également une réflexion assez poussée.

On pourra utiliser le lemme de disjonction affirmant que la relation d’ordre sur
les réels est totale :
`∀ x y, x ≤ y ∨ y ≤ x`

et le lemme d’anti-symétrie pour cette relation d’ordre :
`∀ x y, (x ≤ y ∧ y ≤ x) ⇒ x = y`
-/
Exercise "06.6"
  Given: (f : ℝ → ℝ)
  Assume: (h : f is non-decreasing) (h' : ∀ x, f (f x) = x)
  Conclusion: ∀ x, f x = x
Proof:
  sorry
QED

