import ProofsWithLean.Lib
setup_env

namespace m154
open Nat
/-
# File 4: Implications and equivalences

Implication is a logical connector. From two statements `P` and `Q`, we can
form the statement `P ⇒ Q` which reads “P implies Q”, or “If P is true then Q
is true”. In the statement `P ⇒ Q`, the statement `P` is called the premise of
the implication and the statement `Q` is called its conclusion.

The rule for using such a statement is called the modus ponens rule. It states
that if `P ⇒ Q` is true and if `P` is true then `Q` is true.

The following example shows how to use this rule directly.
-/

Example "Using an implication"
  Given: (P Q : Statement)
  Assume: (h : P ⇒ Q) (h' : P)
  Conclusion: Q
Proof:
  Since P ⇒ Q and P we conclude that Q
QED

/-
The modus ponens rule does not dictate the order of verification. Purely
cosmetically, this means that the next proof is in fact identical to
the previous one.
-/

Example "Using an implication, a cosmetic modification"
  Given: (P Q : Statement)
  Assume: (h : P ⇒ Q) (h' : P)
  Conclusion: Q
Proof:
  Since P and P ⇒ Q we conclude that Q
QED

/-
More significantly, we can postpone proving the premise. This is called
backward reasoning (this refers to the fact it goes against the geometric
direction of the implication arrow). This mode of reasoning is particularly
useful when the implication is clear and the proof of the premise is
the heart of the matter. The following example is therefore rather artificial.
We'll look at more meaningful examples later.
This is a difference in presentation, not a new rule of logic.
-/

Example "Using an implication, with backward reasonning"
  Given: (P Q : Statement)
  Assume: (h : P ⇒ Q) (h' : P)
  Conclusion: Q
Proof:
  Since P ⇒ Q it suffices to prove that P
  We conclude by hypothesis
QED

/-
In the previous examples, the truth of `P ⇒ Q` is simply an assumption. The
course library contains a number of statements that can be used to
justify implications. These statements will be mentioned in comments before the
exercises.

An example of such a statement is: `∀ x : ℝ, x > 0 ⇒ x^2 > 0`. We can therefore
write the following proof.
-/

Example "Positive square"
  Given: (a : ℝ)
  Assume: (ha : a > 0)
  Conclusion: a^2 > 0
Proof:
  Since a > 0 ⇒ a^2 > 0 and a > 0 we conclude that a^2 > 0
QED

/-
Another example of an available statement is
`∀ x : ℝ, x ≠ 0 ⇒ |x| > 0`.

Warning: the absolute value bar is the ordinary vertical bar (above the Enter
key on a qwerty keyboard) but you must not put a space after the opening bar
or before the closing bar.
-/

Exercise "04.1 Using an implication"
  Given: (x : ℝ)
  Assume: (h : x ≠ 0)
  Conclusion: |x| > 0
Proof:
  sorry
QED

/-
Let's now look at how to chain the use of two implications. When the modus
ponens rule doesn't allow you to conclude immediately, you can replace the
final `we conclude that ...` with `we get F : ...` where `F` is a hypothesis
name of your choice (among the available names).
-/

Example "Chaining implications, forwards."
  Given: (a : ℝ)
  Assume: (ha : a > 0)
  Conclusion: (a^2)^2 > 0
Proof:
  Since a > 0 and a > 0 ⇒ a^2 > 0 we get ha' : a^2 > 0
  Since a^2 > 0 and a^2 > 0 ⇒ (a^2)^2 > 0 we conclude that (a^2)^2 > 0
QED

/-
Here's the same proof but using the first implication in backward
reasonning.
-/

Example "Backward reasonning chaining implications."
  Given: (a : ℝ)
  Assume: (ha : a > 0)
  Conclusion: (a^2)^2 > 0
Proof:
  Since a^2 > 0 ⇒ (a^2)^2 > 0 it suffices to prove that a^2 > 0
  Since a > 0 and a > 0 ⇒ a^2 > 0 we conclude that a^2 > 0
QED

/-
Note how this variant changes the order in which the implications are used.
Observe carefully what the goal is at the beginning of the second line of the
two previous proofs.

Once you've understood this subtlety, choose your preferred style for the next exercise.
-/

Exercise "04.2 Chaining implications, using your favorite style."
  Given: (a : ℝ)
  Assume: (ha : a ≠ 0)
  Conclusion: |a|^2 > 0
Proof:
  sorry
QED

/-
Now try the other style. The computer won't check that the two styles are
different, so make sure that the goals at the beginning of the second line are
different.
-/

Exercise "04.3 Chaining implications, in the other style"
  Given: (a : ℝ)
  Assume: (ha : a ≠ 0)
  Conclusion: |a|^2 > 0
Proof:
  sorry
QED

/-
By this stage, you're getting tired of writing well-known implications.
Fortunately, the commands `Since ... we conclude that ...` and `Since ... we
get ...` make the effort to search the course's database of implications. We
can therefore leave these implications implicit as we would on paper.
-/

Example "Chaining implications, leavings implicit implications."
  Given: (a : ℝ)
  Assume: (ha : a ≠ 0)
  Conclusion: |a|^2 > 0
Proof:
  Since a ≠ 0 we get ha' : |a| > 0
  Since |a| > 0 we conclude that |a|^2 > 0
QED

/-
It the backward reasonning style, one can start directly with `It suffices to prove that`.
-/

Example "Chaining implications, leaving implicit implications, with the first one
         in backward reasonning style."
  Given: (a : ℝ)
  Assume: (ha : a ≠ 0)
  Conclusion: |a|^2 > 0
Proof:
  It suffices to prove that |a| > 0
  Since a ≠ 0 we conclude that |a| > 0
QED

/-
Die-hard fans of the backward modus ponens can even write:
-/

Example "Chaining implications, leaving implicit implications, with both implications
         in backward reasonning style."
  Given: (a : ℝ)
  Assume: (ha : a ≠ 0)
  Conclusion: |a|^2 > 0
Proof:
  It suffices to prove that |a| > 0
  It suffices to prove that a ≠ 0
  We conclude by hypothesis
QED

/-
Note that the software is instructed to use only one database implication at a
time. The optimistic proof
`Since a ≠ 0 we conclude that |a|^2 > 0`
would not work (this is a course choice of course, not a software limitation).

So the innocent modus ponens rule is already enough to generate a wide variety
of more or less explicit styles and present the argument in various orders.
Reflecting on this kind of thing is one of the aims of this course.

The rule for the direct proof of an implication is much simpler, as it
admits no stylistic variations. To prove a statement of the form `P ⇒ Q`,
we assume that `P` is true and prove `Q`.
Here we use the command `Assume name: ...` where `name` is a name to be chosen
from the available names and `...` is to be replaced by the statement `P` (in
fact the `: ...` is optional but helps readability).

We can repeat a previous exercise but, instead of assuming a priori the
hypothesis `a ≠ 0`, we announce an implication having it as a premise. From the
second line onwards, the proof is as above.
-/

Example "Proving an implication"
  Given: (a : ℝ)
  Assume:
  Conclusion: a ≠ 0 ⇒ |a|^2 > 0
Proof:
  Assume ha : a ≠ 0
  Since a ≠ 0 we get ha' : |a| > 0
  Since |a| > 0 we conclude that |a|^2 > 0
QED

Exercise "04.4 Proving an implication"
  Given: (a : ℝ)
  Assume:
  Conclusion: a > 0 ⇒ (a^2)^2 > 0
Proof:
  sorry
QED


/-
Let's now look at how to handle more complex predicates. We give ourselves a
function `f: ℝ → ℝ` and form the predicate covering two numbers `x₁` and `x₂`
to which we associate the statement `x₁ ≤ x₂ ⇒ f x₁ ≤ f x₂` (If x₁ ≤ x₂ then
f(x₁) ≤ f(x₂)).

We can nest two universal quantifiers to obtain the increasing function
definition:
`f is non-decreasing` means `∀ x₁, (∀ x₂, x₁ ≤ x₂ ⇒ f x₁ ≤ f x₂)`.

Such nesting is a little cumbersome to read, so we can abbreviate it to
`∀ x₁ x₂, x₁ ≤ x₂ ⇒ f x₁ ≤ f x₂`.

`f is non-increasing` means `∀ x₁ x₂, x₁ ≤ x₂ ⇒ f x₁ ≥ f x₂`.
-/

Example "A composition of non-decreasing functions is non-decreasing"
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is non-decreasing) (hg : g is non-decreasing)
  Conclusion: (g ∘ f) is non-decreasing
Proof:
  Fix x₁ x₂
  Assume h : x₁ ≤ x₂
  Let's prove that g (f x₁) ≤ g (f x₂) -- This line is optional but makes reading easier
  Since f is non-decreasing and x₁ ≤ x₂ we get H : f x₁ ≤ f x₂
  Since g is non-decreasing and f x₁ ≤ f x₂ we conclude that g (f x₁) ≤ g (f x₂)
QED


Example "A composition of non-decreasing functions is non-decreasing.
         Variation with backward reasonning."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is non-decreasing) (hg : g is non-decreasing)
  Conclusion: (g ∘ f) is non-decreasing
Proof:
  Fix x₁ x₂
  Assume h : x₁ ≤ x₂
  Let's prove that (g ∘ f) x₁ ≤ (g ∘ f) x₂
  Since g is non-decreasing it suffices to prove that f x₁ ≤ f x₂
  Since f is non-decreasing and x₁ ≤ x₂ we conclude that f x₁ ≤ f x₂
QED

Exercise "04.5 The composition of a non-decreasing and a non-increasing function
          is non-increasing."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is non-decreasing) (hg : g is non-increasing)
  Conclusion: (g ∘ f) is non-increasing
Proof:
  sorry
QED

/-
For the following exercises, recall that a function `f` is injective if, for
all `x` and `y`, `f x = f y ⇒ x = y`.
-/

Exercise "04.6 A composition of injective functions is injective."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is injective) (hg : g is injective)
  Conclusion: g ∘ f is injective
Proof:
  sorry
QED

Exercise "04.7 If a composition is injective then the first applied function is
          injective."
  Given: (f g : ℝ → ℝ)
  Assume:
  Conclusion: g ∘ f is injective ⇒ f is injective
Proof:
  sorry
QED

/-
A logical connective very much related to implication is equivalence.

From two statements `P` and `Q`, we can form the statement `P ⇔ Q`, which reads
“P is equivalent to Q” or “P is true if and only if Q is true”.

There are two ways of looking at this logical connective.

It can be seen as a double implication. Indeed, to say that the statement
`P ⇔ Q` is true means that the statements `P ⇒ Q` and `Q ⇒ P` are both true.
From this point of view, no new rules of logic are needed. To use that `P ⇔ Q`
is true we can use one of the two implications. To prove that `P ⇔ Q` is true,
we need to prove both implications.

On the use side, the commands `Since … we get …` and
`Since … we conclude that …` can extract an implication from an equivalence, as
in the following example.
-/

Example "Using one of the implications from an equivalence"
  Given: (P R : Statement)
  Assume: (h : P ⇔ R) (h' : P)
  Conclusion: R
Proof:
  Since R ⇔ P we get H : P ⇒ R
  Since P ⇒ R and P we conclude that R
QED

Exercise "04.8 Using one of the implications from an equivalence"
  Given: (P R : Statement)
  Assume: (h : P ⇔ R) (h' : R)
  Conclusion: P
Proof:
  sorry
QED

Exercise "04.9 Using one of the implications from an equivalence. A more complex case."
  Given: (P Q R S : Statement)
  Assume: (hPR : P ⇔ R) (hQRS : (Q ⇒ R) ⇒ S)
  Conclusion: (Q ⇒ P) ⇒ S
Proof:
  sorry
QED

/-
To prove an equivalence seen as a double implication, simply prove both
implications. The command to initiate this split is
`Let's first prove that …`.
-/

Example "Proving an equivalence using two implication proofs."
  Given: (P Q R : Statement)
  Assume: (hPR : P ⇒ R) (hPQ : R ⇒ Q) (hQP : Q ⇒ P)
  Conclusion: P ⇔ R
Proof:
  Let's first prove that P ⇒ R
  We conclude by hypothesis
  Let's now prove that R ⇒ P
  Assume hR : R
  Since R ⇒ Q and R we get hQ : Q
  Since Q ⇒ P and Q we conclude that P
QED

Exercise "04.10 Numbers divided by zero."
  Given: (a : ℤ)
  Assume:
  Conclusion: 0 ∣ a ⇔ a = 0
Proof:
  sorry
QED

/-
The other way of looking at equivalence is to make it play the same role as
equality between mathematical objects. From this point of view, we can use a
statement of the form `P ⇔ Q` to replace `P` by `Q` wherever `Q` occurs (and
vice versa). This is called statement rewriting (unlike the double implication
point of view, this is a new logic rule in addition to the implication rules).

The command `Since … we conclude that …` and its cousin
`Since … we get …` allow you to do this.
-/

Example "A statement rewriting that allows to conclude directly."
  Given: (P Q R S : Statement)
  Assume: (h : P ⇔ R) (h' : (Q ⇒ R) ⇒ S)
  Conclusion: (Q ⇒ P) ⇒ S
Proof:
  Since R ⇔ P and (Q ⇒ R) ⇒ S we conclude that (Q ⇒ P) ⇒ S
QED

/-
Note that this point of view makes a proof that was a little complex by
using double implication very easy.

We can also use this rewriting principle to change the goal, using the command
`Since … it suffices to prove that …`. Let's take the same example again.
-/

Example "Rewriting a statement to change the goal before concluding."
  Given: (P Q R S : Statement)
  Assume: (h : P ⇔ R) (h' : (Q ⇒ R) ⇒ S)
  Conclusion: (Q ⇒ P) ⇒ S
Proof:
  Since R ⇔ P it suffices to prove that (Q ⇒ R) ⇒ S
  We conclude by hypothesis
QED

Exercise "04.11 Rewriting a statement to change the goal before concluding."
  Given: (P R : Statement)
  Assume: (h : P ⇔ R) (h' : P)
  Conclusion: R
Proof:
  sorry
QED

/-
The analogy with equality becomes even clearer when we prove an
equivalence by successive rewritings.
-/

Example "Proving an equivalence by statement rewriting."
  Given: (P Q R S T : Statement)
  Assume: (hPR : P ⇔ R) (hST : S ⇔ T)
  Conclusion: ((Q ⇒ R) ⇒ S) ⇔ ((Q ⇒ P) ⇒ T)
Proof:
  Calc
    ((Q ⇒ R) ⇒ S) ⇔ ((Q ⇒ P) ⇒ S) since P ⇔ R
    _             ⇔ ((Q ⇒ P) ⇒ T) since S ⇔ T
QED
