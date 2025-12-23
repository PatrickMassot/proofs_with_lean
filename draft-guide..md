# Verbose Lean (English): Complete Structured Guide

## 0. Design Philosophy

Verbose Lean provides:

* A **controlled natural language** closely aligned with textbook mathematical English
* A **restricted but expressive grammar**
* Deterministic elaboration into Lean tactics
* Forward- and backward-reasoning support
* Tight integration with `calc`, `have`, `intro`, `cases`, `rcases`, `apply`, `obtain`, `choose`

The English layer is **not free-form**: every phrase corresponds to a well-defined syntactic category.

---

## 1. Introducing Assumptions: `Assume`

### 1.1 Basic assumption introduction

**Purpose:** Introduce hypotheses from goals of the form `P → Q`, `∀ x, ...`, etc.

**Syntax:**

```
Assume h
Assume h : P
Assume h₁ (h₂ : Q)
Assume that h₁ (h₂ : Q)
```

**Example:**

```lean
example (P Q : Prop) : P → Q → True := by
  Assume hP (hQ : Q)
  trivial
```

Equivalent to:

```lean
intro hP hQ
```

---

### 1.2 `Assume for contradiction`

**Purpose:** Start a proof by contradiction when the goal is *not already a negation*.

**Syntax:**

```
Assume for contradiction h : P
```

**Semantics:** Replaces the goal with `False` and adds `h : P`.

**Example:**

```lean
example (P Q : Prop) (h : ¬ Q → ¬ P) : P → Q := by
  Assume hP
  Assume for contradiction hQ : ¬ Q
  exact h hQ hP
```

**Restrictions (enforced):**

* Disallowed if the goal is already a negation
* Disallowed if the assumed statement is definitionally incorrect (even after unfolding)
* Can be enabled for negation goals via:

```lean
allowProvingNegationsByContradiction
```

---

## 2. Forward Reasoning: `By … we get / choose / suffices`

### 2.1 Extracting data: `By … we get`

**Purpose:** Eliminate conjunctions, existentials, and splittable lemmas.

**Syntax:**

```
By h we get h₁ h₂
By h we get x such that H
By h applied to t we get ...
```

**Examples:**

Conjunction:

```lean
example (P Q : Prop) (h : P ∧ Q) : Q := by
  By h we get hP hQ
  exact hQ
```

Existential:

```lean
example (n : Nat) (h : ∃ k, n = 2*k) : True := by
  By h we get k such that H
  trivial
```

Lemma with anonymous splitting:

```lean
example (x : ℝ) (h : |x| ≤ 3) : True := by
  By h we get h₁ h₂
  trivial
```

---

### 2.2 Choice: `By … we choose`

**Purpose:** Extract a *function* from a dependent choice.

**Syntax:**

```
By h we choose g such that H
```

**Example:**

```lean
noncomputable example (f : ℕ → ℕ)
  (h : ∀ y, ∃ x, f x = y) : ℕ → ℕ := by
  By h we choose g such that H
  exact g
```

Supports multiple properties:

```lean
By h we choose g such that H₁ and H₂
```

---

### 2.3 Backward reasoning: `it suffices to prove`

**Purpose:** Apply implications and reduce goals.

**Syntax:**

```
By h it suffices to prove P
By h applied to t it suffices to prove P
By h it suffices to prove P and Q
```

**Examples:**

```lean
example (P Q : Prop) (h : P → Q) (hP : P) : Q := by
  By h it suffices to prove P
  exact hP
```

Multiple goals:

```lean
example (P Q R : Prop) (h : P → R → Q) (hP : P) (hR : R) : Q := by
  By h it suffices to prove P and R
  exact hP
  exact hR
```

---

## 3. Structured Calculations: `Calc`

### 3.1 Basic calculation blocks

**Purpose:** Chain equalities and inequalities with explicit justifications.

**Syntax:**

```
Calc
  t₀ = t₁ by computation
  _  ≤ t₂ from h
```

**Example:**

```lean
example (a b : ℕ) : (a + b)^2 = a^2 + b^2 + 2*a*b := by
  Calc
    (a + b)^2 = a^2 + b^2 + 2*a*b by computation
```

---

### 3.2 Justification forms

Each step may be justified by:

| English phrase   | Meaning                       |
| ---------------- | ----------------------------- |
| `by computation` | `ring`, `norm_num`, reduction |
| `by hypothesis`  | `assumption`                  |
| `from h`         | `apply h`                     |
| `since P`        | prove P and apply             |
| `since P and Q`  | multi-fact reasoning          |
| `by tactic`      | arbitrary Lean tactics        |

**Example:**

```lean
Calc f (-x) = f x since even_fun f
```

---

### 3.3 Inequality chains

**Example:**

```lean
example (a b c d : ℕ) (h : a ≤ b) (h' : c ≤ d) :
  a + c ≤ b + d := by
  Calc
    a + c ≤ b + c from h
    _     ≤ b + d from h'
```

---

### 3.4 Interactive mode

```
Calc?
```

Invokes the widget to build a calculation interactively.

---

## 4. Naming Intermediate Results: `Fact` / `Claim`

**Purpose:** Introduce named lemmas (`have`) with English justification.

### 4.1 Proof-based

```
Fact H : P by
  tactic
```

**Example:**

```lean
Fact H : 1 + 1 = 2 by computation
```

---

### 4.2 From existing facts

```
Fact H : Q from h
```

**Example:**

```lean
Fact H : ε ≥ 0 from ε_pos
```

---

### 4.3 Since-justified

```
Fact H : Q since P
```

**Example:**

```lean
Fact H : ε ≥ 0 since ε > 0
```

---

## 5. Fixing Variables and Goals

### 5.1 `Fix`

**Purpose:** Introduce universally quantified variables.

```
Fix x
Fix ε > 0
Fix n ≥ N
```

**Example:**

```lean
Fix ε > 0
```

Equivalent to:

```lean
intro ε
have ε_pos : ε > 0 := ...
```

---

### 5.2 `Let's prove`

**Purpose:** Explicit goal structuring.

```
Let's prove that P
Let's prove that N works : ∀ n ≥ N, ...
```

Used extensively in Exercises.

---

## 6. Using Facts: `Since … we conclude`

**Purpose:** Forward chaining with one or more facts.

**Syntax:**

```
Since P we conclude that Q
Since P and R we conclude that Q
```

**Example:**

```lean
Since u converges to x₀ and δ > 0
we get N such that H
```

---

## 7. `We conclude`, `We compute`

### 7.1 `We conclude`

Closes a goal using an explicit fact.

```
We conclude by h
```

### 7.2 `We compute`

Closes a goal by definitional reduction.

```
We compute
```

Used heavily in `Calc` and `Fact`.

---

## 8. Structured Proof Blocks: `Exercise`, `Example`, `Proof`, `QED`

These are **syntactic sugar** for readable, textbook-style proofs.

**Structure:**

```
Exercise "Title"
  Given: ...
  Assume: ...
  Conclusion: ...
Proof:
  ...
QED
```

Fully elaborates to standard Lean proof terms.

---

## 9. Advanced Infrastructure (Implicit but Essential)

* **Anonymous fact splitting**
  (`configureAnonymousFactSplittingLemmas`)
* **Goal splitting**
  (`configureAnonymousGoalSplittingLemmas`)
* **Unfoldable definitions**
  (`configureUnfoldableDefs`)
* **Controlled unfolding of notation-heavy definitions**
* **Strong assumption resolution**

These ensure that English proofs behave predictably.

---

## 10. Summary Table

| Category           | Tactics                                      |
| ------------------ | -------------------------------------------- |
| Assumptions        | `Assume`, `Assume for contradiction`         |
| Forward reasoning  | `By … we get`, `By … we choose`              |
| Backward reasoning | `it suffices to prove`                       |
| Calculations       | `Calc`, `Calc?`                              |
| Naming facts       | `Fact`, `Claim`                              |
| Structure          | `Fix`, `Let's prove`, `Since`, `We conclude` |
| Proof blocks       | `Exercise`, `Example`, `Proof`, `QED`        |

---

## Concluding Remarks

Verbose Lean (English) achieves a rare combination of:

* Mathematical readability
* Formal precision
* Deterministic elaboration
* Pedagogical clarity

It is especially well-suited for **teaching**, **formalized textbooks**, and **bridging informal mathematics with Lean**.
