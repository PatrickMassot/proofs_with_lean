import ProofsWithLean.Lib_en
setup_env

/-
# Feuille 7 : Suites convergentes.
-/

/-
Une suite u est une fonction de ℕ dans ℝ, Lean écrit donc u : ℕ → ℝ

`u tends to l` signifie `∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - l| ≤ ε`

Il faut bien garder à l’esprit que `∀ ε > 0, …` est l’abbréviation de
`∀ ε, ε > 0 ⇒ …`.

Pour démontrer un énoncé qui commence ainsi, la commande `Fix` permet
d’utiliser l’abbréviation
`Fix ε > 0`
à la place de la suite de commandes
`Fix ε : ℝ`
`Assume ε_pos : ε > 0`.

Pour utiliser un énoncé qui commence ainsi, il faut donner à la commande
`Comme` l’énoncé and le fait que le nombre auquel on veut spécialiser l’énoncé est
strictement positif.

Voyons un exemple artificiel.
-/

Example "Énoncé commençant par ∀ ε > 0"
  Given: (u : ℕ → ℝ)
  Assume: (hu : ∀ δ > 0, ∃ n, u n < δ)
  Conclusion:  ∀ ε > 0, ∃ n, u n < ε/2
Proof:
  Fix ε > 0
  Since ∀ δ > 0, ∃ n, u n < δ and ε/2 > 0 we conclude that ∃ n, u n < ε/2
QED

/-
Dans l’exemple ci-dessus, on notera que l’utilisation de la lettre `δ`
dans l’hypothèse and `ε` dans la conclusion permet de clarifier les choses,
car on peut dire qu’on a « spécialisé l’hypothèse à `δ = ε/2` ».
Mais `ε` and `δ` sont des variables liées donc on peut nommer les deux `ε` sans
rien changer.

Voyons maintenant un exemple qui utilise la définition de limite.
-/

Example "Un exemple pour démarrer"
  Given: (u v : ℕ → ℝ) (l : ℝ)
  Assume: (hu : u tends to l) (hv : ∀ n, v n = u n - l)
  Conclusion: v tends to 0
Proof:
  Fix ε > 0
  Since u tends to l and ε > 0 we get N₁ such that hN₁ : ∀ n ≥ N₁, |u n - l| ≤ ε
  Let's prove that N₁ works
  Fix N ≥ N₁
  Since ∀ n ≥ N₁, |u n - l| ≤ ε and N ≥ N₁ we get hN₁' : |u N - l| ≤ ε
  Calc
    |v N - 0| = |u N - l - 0| since ∀ n, v n = u n - l
    _         = |u N - l|     by computation
    _         ≤ ε             by hypothesis
QED

Exercise "07.1 Si u est constante de valeur l, alors u tends to l"
  Given: (u : ℕ → ℝ) (l : ℝ)
  Assume:
  Conclusion: (∀ n, u n = l) ⇒ u tends to l
Proof:
  sorry
QED

/- Concernant les valeurs absolues, la base de données de résultats utilisables sans
les mentionner explicitement inclut

`∀ x y, |x + y| ≤ |x| + |y|`

`∀ x y z, |x - y| ≤ |x - z| + |z - y|`

`∀ x y, |x - y| = |y - x|`

Ces trois résultats sont utilisés par la commande `We compute`
(ou `by computation` dans les `Calc`).

Les commandes `Since …` and `It suffices to prove that …` savent que
`∀ x y, |x| ≤ y ⇔ -y ≤ x and x ≤ y`

Il est conseillé de noter ces lemmes sur une feuille car ils
peuvent être utiles dans chaque exercice.
-/

Exercise "07.2 Si u tends to l strictement positif, alors u n ≥ l/2 pour n assez grand."
  Given: (u : ℕ → ℝ) (l : ℝ)
  Assume: (hl : l > 0)
  Conclusion: (u tends to l) ⇒ ∃ N, ∀ n ≥ N, u n ≥ l/2
Proof:
  sorry
QED

/-
La base de données de résultats contient également des résultats
concernant le maximum de deux nombres

`∀ p q, p ≤ max p q`

`∀ p q, q ≤ max p q`

Il est conseillé de noter ces lemmes sur une feuille car ils
peuvent être utiles dans chaque exercice.
-/

Exercise "07.3 Si u tends to l and v tends to l' alors u+v tends to l+l'"
  Given: (u v : ℕ → ℝ) (l l' : ℝ)
  Assume: (hu : u tends to l) (hv : v tends to l')
  Conclusion: (u + v) tends to (l + l')
Proof:
  sorry
QED

Exercise "07.4 théorème des gendarmes"
  Given: (u v w : ℕ → ℝ) (l : ℝ)
  Assume: (hu : u tends to l) (hw : w tends to l)
               (h : ∀ n, u n ≤ v n) (h' : ∀ n, v n ≤ w n)
  Conclusion: v tends to l
Proof:
  sorry
QED

Exercise "07.5 La dernière inégalité dans la définition de limite peut être remplacée par
          une inégalité stricte."
  Given: (u : ℕ → ℝ) (l : ℝ)
  Assume:
  Conclusion: (u tends to l) ⇔ ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - l| < ε
Proof:
  sorry
QED

/-
Dans l’exercice suivant on pourra utiliser que la commande
`It suffices to prove that`
connait le lemme
`∀ x y : ℝ, (∀ ε > 0, |x - y| ≤ ε) ⇒ x = y`

et la commande `Comme` connait les lemmes
`∀ a b, max a b ≥ a`
et
`∀ a b, max a b ≥ b`
-/


Exercise "07.6 Une suite u admet au plus une limite"
  Given: (u : ℕ → ℝ) (l l' : ℝ)
  Assume: (hl : u tends to l) (hl' : u tends to l')
  Conclusion: l = l'
Proof:
  sorry
QED

/-
`M is supremum of u` signifie
  (∀ n, u n ≤ M) ∧ (∀ ε > 0, ∃ n₀, u n₀ ≥ M - ε)
-/
Exercise "07.7 Toute suite croissante ayant une borne supérieure tends to cette borne"
  Given: (u : ℕ → ℝ) (M : ℝ)
  Assume: (h : M is supremum of u) (h' : u is non-decreasing)
  Conclusion: u tends to M
Proof:
  sorry
QED

