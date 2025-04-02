import ProofsWithLean.Lib_en
setup_env

open m154
/-
# Feuille 8 : Suites extraites, valeurs d'adhérence and suites de Cauchy.
-/

/-
Cette feuille continue l'étude du chapitre 2 du cours de math 101, to abordant
les suites extraites, les valeurs d'adhérence and les suites de Cauchy.
Il n'y a aucune nouvelle commande Lean à apprendre. Cependant les
exercices sont globalement un peu plus difficiles mathématiquement que dans
la feuille 7. Il est donc inutile de travailler cette feuille si la
feuille 7 n'est pas solidement comprise.

On rappelle des lemmes potentiellement utiles.
Les commandes `Comme` and `It suffices to prove that` and la justification
`since` des étapes de calcul connaissent le lemme

`∀ x y |x| ≤ y ↔ -y ≤ x ∧ x ≤ y`

La commande `We compute` and la justification `by computation` connaissent les lemmes
`∀ x y, |x + y| ≤ |x| + |y|`

`∀ x y z, |x - y| ≤ |x - z| + |z - y|`

`∀ x y, |x - y| = |y - x|`

`∀ p q r, r ≥ max p q  ⇒ r ≥ p ∧ r ≥ q`

`∀ p q, max p q ≥ p`

`∀ p q, max p q ≥ q`
-/

/- On rappelle aussi la définition :

`u tends to l : ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - l| ≤ ε`

Étant donnée une fonction `φ : ℕ → ℕ`, on dit que
`φ est une extraction` si elle est strictement croissante :
∀ n m, n < m → φ n < φ m

Les commandes `Comme` and `It suffices to prove that` and la justification
`since` des étapes de calcul connaissent le lemme
suivant (sa démonstration est une récurrence immédiate).

`φ est une extraction ⇒ ∀ n, n ≤ φ n`

ainsi que le résultat

`u tends to l ∧ u tends to l' ⇒ l = l'`

démontré dans la feuille précédente.

Pour l'exercice suivant, il est également utile de se souvenir que la notation
`∃ n ≥ N, P n` est l'abréviation de `∃ n, n ≥ N ∧ P n`.
-/

Exercise-lemma extraction_superieur "08.1 Si `φ` est une extraction alors elle prend des valeurs
 arbitrairement grandes pour des indices arbitrairement grands."
  Given: {φ : ℕ → ℕ}
  Assume: (h : φ est une extraction)
  Conclusion: ∀ N N', ∃ n ≥ N', φ n ≥ N
Proof:
  sorry
QED

/-
L'exercice précédent est un exercice-lemme, de sorte qu'il vous sera possible
de l'invoquer implicitement dans les démonstrations suivantes.

Un réel `a` est valeur d'adhérence d'une suite `u` s'il
existe une suite extraite de `u` qui tends to `a` :

`a est valeur d'adhérence de u : ∃ φ, φ est une extraction ∧ (u ∘ φ) tends to a'
-/

Exercise-lemma valeur_proche_adherence
  "08.2 Si `a` est valeur d'adhérence de `u` alors il existe des valeurs
  de `u` aussi proches qu'on veut de `a` pour des indices aussi grands qu'on veut."
  Given: {u : ℕ → ℝ} {a : ℝ}
  Assume: (hyp : a est valeur d'adhérence de u)
  Conclusion: ∀ ε > 0, ∀ N, ∃ n ≥ N, |u n - a| ≤ ε
Proof:
  sorry
QED

Exercise-lemma limite_extraction_si_limite
  "08.3 Si `u` tends to `l` alors toutes ses suites extraites tendent vers `l`."
  Given: {u : ℕ → ℝ} {φ : ℕ → ℕ} {l : ℝ}
  Assume: (h : u tends to l) (hφ : φ est une extraction)
  Conclusion:  u ∘ φ tends to l
Proof:
  sorry
QED

Exercise-lemma val_adh_lim
  "08.4 Si une suite `u` tends to `l` alors elle n'a pas d'autre valeur d'adhérence que `l`."
  Given: {u : ℕ → ℝ} {l a : ℝ}
  Assume: (hl : u tends to l) (ha : a est valeur d'adhérence de u)
  Conclusion: a = l
Proof:
  sorry
QED

/-
Une suite `u` est de Cauchy si ses termes sont aussi proches qu'on
veut pour des indices assez grands :

`u est de Cauchy : ∀ ε > 0, ∃ N, ∀ p ≥ N, ∀ q ≥ N, |u p - u q| ≤ ε`
-/

Exercise-lemma cauchy_si_converge "08.5 Si une suite `u` converge alors elle est de Cauchy."
  Given: {u : ℕ → ℝ}
  Assume:
  Conclusion: (∃ l, u tends to l) → u est de Cauchy
Proof:
  sorry
QED

/- Dans l'exercice suivant, on pourra utiliser l’énoncé démontré plus haut :

`a est valeur d'adhérence de u ⇒ ∀ ε > 0, ∀ N, ∃ n ≥ N, |u n - a| ≤ ε`
-/

Exercise "08.6
  Si une suite de Cauchy `u` admet une valeur d'adhérence `l` alors elle converge vers `l`."
  Given: (u : ℕ → ℝ) (l : ℝ)
  Assume: (hu : u est de Cauchy) (hl :  l est valeur d'adhérence de u)
  Conclusion: u tends to l
Proof:
  sorry
QED

