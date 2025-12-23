# Verbose Lean (English) Reference Guide

Verbose Lean is a "Controlled Natural Language," meaning it looks like English but follows strict syntactic rules that map directly to Lean 4 tactics.

## 1. Structure of a Problem

Verbose Lean separates the statement of a theorem from its proof using precise keywords. This structure replaces the standard `theorem` or `example` header.

### Syntax

```lean
Exercise "Name of the exercise"
  Given: (x : Type) (y : Type)
  Assume: (h1 : x > 0) (h2 : y > x)
  Conclusion: y > 0
Proof:
  <Tactics go here>
  QED
```

* **Given:** Declares the objects (variables).
* **Assume:** Declares the hypotheses.
* **Conclusion:** States the goal to be proven.
* **Proof:** / **QED**: Block delimiters for the proof script.

---

## 2. Forward Reasoning (Deducing New Facts)

These tactics correspond to the `have` tactic in standard Lean. They allow you to build new facts from existing assumptions and lemmas.

### `Since ... we get ...`

The most versatile forward reasoning tactic. It combines facts to deduce a new one, often performing implicit rewriting or logical steps (like `gcongr`).

* **Syntax:**

    ```text
    Since <fact1> and <fact2> we get <new_fact_name> : <new_fact_statement>
    ```

* **Example:**

    ```lean
    Since x > 0 and y > x we get h_new : y > 0
    ```

### `We claim that ...`

Proves an intermediate statement. This opens a new subgoal to prove the claim, and then adds it to the context.

* **Syntax:**

    ```text
    We claim that <fact_name> : <fact_statement>
    ```

* **Example:**

    ```lean
    We claim that h_pos : x * x ≥ 0
    Proof:
       ... -- prove the claim here
    ```

### `By ... applied to ... we get ...`

Explicitly instantiates a universal quantifier or a lemma.

* **Syntax:**

    ```text
    By <lemma_name> applied to <arguments> we get <fact_name> : <fact_statement>
    ```

* **Example:**

    ```lean
    By le_trans applied to h1, h2 we get h3 : a ≤ c
    ```

### `The assumption ... gives ...` (Destructuring Existence)

Used to extract a witness from an existential hypothesis (equivalent to `cases` or `obtain`).

* **Syntax:**

    ```text
    The assumption <h_exists> gives <var> such that <h_property>
    ```

* **Example:**
  * *Context:* `h : ∃ δ, δ > 0`
  * *Usage:* `The assumption h gives δ such that hδ : δ > 0`

---

## 3. Backward Reasoning (Goal Management)

These tactics manipulate the goal, corresponding to `apply`, `suffices`, or refinement.

### `It suffices to prove that ...`

Replaces the current goal with a new sufficient condition.

* **Syntax:**

    ```text
    It suffices to prove that <new_goal>
    ```

* **Example:**
  * *Goal:* `|x - y| < ε`
  * *Usage:* `It suffices to prove that |x - y| < ε / 2`

### `Let's first prove that ...`

Similar to "We claim", but specifically framed as a sub-goal strategy.

* **Syntax:**

    ```text
    Let's first prove that <sub_goal>
    ```

### `By ... it suffices to prove ...`

Applies a lemma to the goal and leaves the premises of that lemma as new goals (equivalent to `apply`).

* **Syntax:**

    ```text
    By <lemma> it suffices to prove <new_goal>
    ```

* **Example:**

    ```lean
    By continuous_def it suffices to prove ∀ ε > 0, ∃ δ > 0, ...
    ```

---

## 4. Introducing Variables and Assumptions

These tactics handle the `intro` tactic, dealing with "For all" quantifiers and implications in the goal.

### `Let ... be ...`

Introduces a variable from a universal quantifier.

* **Syntax:**

    ```text
    Let <var> be <type>
    ```

* **Example:**
  * *Goal:* `∀ n : ℕ, n ≥ 0`
  * *Usage:* `Let n be a natural number`

### `Fix ...`

A concise way to introduce a variable, often with a constraint if the quantifier is bounded.

* **Syntax:**

    ```text
    Fix <var>
    Fix <var> ≥ <bound>
    ```

* **Example:**
  * *Goal:* `∀ ε > 0, ...`
  * *Usage:* `Fix ε > 0`

### `Assume ...`

Introduces the hypothesis of an implication.

* **Syntax:**

    ```text
    Assume <hypothesis_name> : <hypothesis_statement>
    ```

* **Example:**
  * *Goal:* `P → Q`
  * *Usage:* `Assume hP : P`

---

## 5. Structuring the Proof (Decomposition)

Tactics for splitting proofs into smaller logical blocks (cases, induction).

### `We proceed by cases on ...`

Splits the proof based on a logical disjunction or a variable's cases.

* **Syntax:**

    ```text
    We proceed by cases on <variable_or_proposition>
    ```

* **Example:**

    ```lean
    We proceed by cases on n
    ```

### `We proceed by induction on ...`

Starts an induction proof.

* **Syntax:**

    ```text
    We proceed by induction on <variable>
    ```

---

## 6. Concluding the Proof

Tactics that close the current goal.

### `The conclusion follows from ...`

Closes the goal using the listed facts (similar to `assumption` or `simp [facts]`).

* **Syntax:**

    ```text
    The conclusion follows from <fact1>, <fact2>
    ```

* **Example:**

    ```lean
    The conclusion follows from h1, h_ineq
    ```

### `We conclude by ...`

Similar to the above, explicitly naming the method or lemma used to finish.

* **Syntax:**

    ```text
    We conclude by <tactic_or_lemma>
    ```

---

## 7. Examples

### Example 1: Basic Logic

```lean
Exercise "Transitivity of inequality"
  Given: (a b c : ℕ)
  Assume: (h1 : a ≤ b) (h2 : b ≤ c)
  Conclusion: a ≤ c
Proof:
  By le_trans applied to h1, h2 we get h3 : a ≤ c
  The conclusion follows from h3
  QED
```

### Example 2: Epsilon-Delta Style (Real Analysis)

```lean
Exercise "Continuity definition"
  Given: (f : ℝ → ℝ) (x₀ : ℝ)
  Assume: (h_cont : ContinuousAt f x₀)
  Conclusion: ∀ ε > 0, ∃ δ > 0, ∀ x, |x - x₀| < δ → |f x - f x₀| < ε
Proof:
  Fix ε > 0
  By continuousAt_def applied to h_cont we get h_def : ∀ ε > 0, ∃ δ > 0, ∀ x, |x - x₀| < δ → |f x - f x₀| < ε
  By h_def applied to ε we get h_eps : ∃ δ > 0, ∀ x, |x - x₀| < δ → |f x - f x₀| < ε
  The assumption h_eps gives δ such that h_delta : δ > 0 and h_main : ∀ x, |x - x₀| < δ → |f x - f x₀| < ε
  Let's prove that ∃ δ > 0, ∀ x, |x - x₀| < δ → |f x - f x₀| < ε
  The conclusion follows from h_delta, h_main
  QED
```
