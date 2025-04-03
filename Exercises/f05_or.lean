import ProofsWithLean.Lib_en
setup_env

/-
# File 5: Disjunctions
-/

/-
From two statements `P` and `Q`, we can form the statement `P v Q`, which reads “P or Q”.

To prove a statement of this form directly, you need to prove `P` or prove `Q`.
To do this, we use the command `Let's prove that` (this is the same syntax as
when we simply want to facilitate reading by recalling the current goal).
-/
Example "Premier exemple de disjonction."
  Given:
  Assume:
  Conclusion: 2^3 = 3 ∨ 2^3 = 8
Proof:
  Let's prove that 2^3 = 8
  We compute
QED

/-
Note that such a proof requires courageous and irreversible action. Announcing
the wrong proof can lead to a dead end.
In the above proof, for example, starting with
Let's prove that 2^3 = 3
is a logically valid move, but leads to a dead end.
-/

Exercise "05.1 Proving a disjunction"
  Given:
  Assume:
  Conclusion: 1 + 1 = 2 ∨ 1 + 3 = 17
Proof:
  sorry
QED

/-
To use a hypothesis of the form `P v Q` to prove a goal `R`, we do what
is called a proof by cases. The proof splits into two branches, one
in which we assume `P` and prove `R` (i.e. prove `P ⇒ R`) and the
other in which we assume `Q` and prove `R` (i.e. prove `Q ⇒ R`).
Note that the goal is the same in both branches: it's the starting goal `R`.

To do this, we use the command
`We discuss depending on whether P or Q`.
This command checks that the `P v Q` disjunction is known, then performs the
proof by cases.
-/
Example "Proof by cases"
  Given: (a : ℝ)
  Assume: (h : a = 2 ∨ a = -2)
  Conclusion: a^2 = 4
Proof:
  We discuss depending on whether a = 2 or a = -2
  Assume ha : a = 2
  Calc
    a^2 = 2^2 since a = 2
    _   = 4   by computation
  Assume ha : a = -2
  Calc
    a^2 = (-2)^2 since a = -2
    _   = 4      by computation
QED

Exercise "05.2 Proof by cases"
  Given: (a : ℝ)
  Assume: (h : a = 2 ∨ a = -3)
  Conclusion: a^2 + a = 6
Proof:
  sorry
QED

/-
In the previous examples, the statement involving a disjunction was a local
hypothesis. The course also has a database of results whose conclusion is a
disjunction. For instance

`∀ x y : ℝ, x * y = 0 ⇒ x = 0 v y = 0`.

As on paper, you can implicitly invoke these results (which will be mentioned
in due course before the exercises). Lean will automatically search for the
premise `x * y = 0` among the assumptions.
-/

Example "Implicit use of a disjunction."
  Given: (x : ℝ)
  Assume: (hx : (x - 1) * (x + 1) = 0)
  Conclusion: x^2 = 1
Proof:
  We discuss depending on whether x - 1 = 0 or x + 1 = 0
  Assume h : x - 1 = 0
  Let's prove that x^2 = 1 -- this line is optional but helps reading
  Calc
    x^2 = 1^2 since x = 1
    _   = 1 by computation
  Assume h : x + 1 = 0
  Let's prove that x^2 = 1 -- this line is optional but helps reading
  Calc
    x^2 = (-1)^2 since x = -1
    _   = 1 by computation
QED

/-
Let's now look at examples that successively use and prove a disjunction.
The use of a disjunction creates a branch in the proof and the
strategic decision to prove the goal disjunction depends on the current
branch.

We take this opportunity to get to know the command
`Fact name: ... by`
command, which introduces a new assertion with no direct link to the current
goal. After proving it in an indented command block, this fact becomes
available for proof of the current goal, with the given name.
-/

Example "A disjunction proven after a proof by cases."
  Given: (a b : ℝ)
  Assume:
  Conclusion: a = a*b ⇒ a = 0 ∨ b = 1
Proof:
  Assume hyp : a = a*b
  -- At this stage, we need to prove either a = 0 or b = 1
  -- But it’s impossible to decide between those two options.
  -- We need to use the assumption to perform a proof by cases.
  Fact H : a*(1 - b) = 0 by
    -- In this code block, we need to prove that a*(1 - b) = 0
    Calc a*(1 - b) = a - a*b by computation
         _         = 0       since a = a*b
  -- We can now use the new fact `H : a * (1 - b) = 0`
  -- in `We discuss …`
  We discuss depending on whether a = 0 or 1 - b = 0
  Assume h : a = 0
  -- Now we are ready to take side
  Let's prove that a = 0 -- this line is an irreversible decision
  We conclude by hypothesis
  Assume h : 1 - b = 0
  -- In that case we decide to prove the other conclusion.
  Let's prove that b = 1 -- this line is an irreversible decision
  Since 1 - b = 0 we conclude that b = 1
QED

Exercise "05.3 A disjunction proven after a proof by cases."
  Given: (x y : ℝ)
  Assume:
  Conclusion: x^2 = y^2 ⇒ x = y ∨ x = -y
Proof:
  sorry
QED

/-
The following exercise uses the notions of parity and imparity for integers.

By definition, a relative integer `n` is even if `∃ k, n = 2*k`.
By definition, a relative integer `n` is odd if `∃ k, n = 2*k + 1`.

It may therefore be useful to review the existential quantifier file.

We could use that the disjunction database contains the statement:
`∀ n, n is even v n is odd`.
-/
Exercise-lemma mul_succ_pair "05.4 n(n+1) is always even"
  Given: (n : ℤ)
  Assume:
  Conclusion: n*(n+1) is even
Proof:
  sorry
QED

/-
The previous exercise is an exercise-lemma, which means that its result has
been added to the database of usable results without naming them. So, if the
context of a proof includes an integer `p`, we can write
```
  Since p*(p + 1) is even we get l such that hl : p*(p + 1) = 2*l
```
without justifying why `p*(p + 1)` is even.

You may wish to revisit the file on implication and equivalence to remember how
to prove an equivalence seen as a double implication.
-/

Exercise "05.5 An integer is even if and only if its square is even."
  Given: (n : ℤ)
  Assume:
  Conclusion: n is even ⇔ n^2 is even
Proof:
  sorry
QED

/-
We're now going to combine the universal quantifier, equivalence and disjunction.

The disjunction database in the course contains the statement
`∀ x y, x ≤ y ⇒ x = y v x < y`.
-/

Exercise "05.6 A characterization of non-decreasing functions."
  Given: (f : ℝ → ℝ)
  Assume:
  Conclusion: f is non-decreasing ⇔ (∀ x y, x < y ⇒ f x ≤ f y)
Proof:
  sorry
QED


