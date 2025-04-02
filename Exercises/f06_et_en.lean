import ProofsWithLean.LibPgcd_en
setup_env

namespace m154
open Nat M154
/-
# Feuille 06 : Conjonctions


Étant donnés deux énoncés `P` and `Q`, l'énoncé « `P` and `Q` » (noté `P ∧ Q`) est appelé
la *conjonction* de `P` and `Q` :

`P ∧ Q` est vrai si and seulement si `P` and `Q` sont tous les deux vrais.

## Démonstration d’une conjonction

Pour démontrer une conjonction `P ∧ Q`, il faut démontrer les deux énoncés `P` and `Q`.
Pour cela on utilise la commande `Let's first prove that …` pour annoncer le premier but
puis, une fois ce but démontré, `Let's now prove that …` (ce sont les mêmes commandes
que pour démontrer les deux implications d’une équivalence).
-/

Example "Démonstration de conjonction."
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

Exercise "06.1 Démonstration de conjonction."
  Given: (a : ℝ)
  Assume: (ha : a > 0)
  Conclusion: 2*a > 0 ∧ (a^2)^2 > 0
Proof:
  sorry
QED

/-
Le cours dispose également d’une petite base de données d’énoncés qui
comportent des implications dont la l’hypothèse est une conjonction, ce qui
conduit à devoir démontrer des conjonctions. Ces énoncés peuvent être utilisé
sans justification à l’aide de la commande
`It suffices to prove that …`
comme d’habitude avec les implications implicites.

Un exemple de tel énoncé est `∀ x y, (-y ≤ x ∧ x ≤ y) ⇒ |x| ≤ y`.
-/

Example "Démonstration d’un énoncé découlant d’une conjonction."
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
## Utilisation d’une conjonction

Pour utiliser qu’une conjonction `P ∧ Q` est vraie on utilise que les énoncés `P` and `Q`
sont tous les deux vrais.

Pour cela on utilise la commande `Since P ∧ Q we get hP : P and hQ : Q` où `hP`
et `hQ` sont des noms au choix, parmi les noms disponibles.
-/

Example "Utilisation d’une conjonction"
  Given: (a : ℝ)
  Assume: (h : 0 ≤ a ∧ a ≤ 1)
  Conclusion: a ≤ 2
Proof:
  Since 0 ≤ a ∧ a ≤ 1 we get ha : 0 ≤ a and ha' : a ≤ 1
  Since a ≤ 1 we conclude that a ≤ 2
QED

/-
Dans l’exemple ci-dessus, l’hypothèse `ha` n’est jamais utilisée, on peut
omettre d’en parler.
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
By ailleurs la commande `Comme` prend l’initiative de scinder les conjonctions
apparaissant to hypothèse lorsqu’elle cherche les justifications des
énoncés apparaissant entre `Comme` and `we conclude that` or bien `we get` ou bien
`it suffices to prove that`. On peut donc se contenter de la seconde ligne
dans la démonstration ci-dessus.
-/

Exercise "06.2 Utilisation d’une conjonction"
  Given: (a b : ℝ)
  Assume: (hab : a ≤ b ∧ b ≤ 1)
  Conclusion: a ≤ 1
Proof:
  sorry
QED

Exercise "06.3 Utilisation d’une conjonction"
  Given: (a b : ℝ)
  Assume: (hab : 0 ≤ b ∧ a ≤ 1)
  Conclusion: a*b ≤ b
Proof:
  sorry
QED

/-
Le cours dispose également d’une petite base de données d’implications ayant une
conjonction comme conclusion. Ces énoncés peuvent être utilisés sans justification.

Un exemple de tel énoncé est `∀ x y, |x| ≤ y ⇒ (-y ≤ x ∧ x ≤ y)`.
-/

Example "Utilisation d’un énoncé impliquant une conjonction"
  Given: (a b : ℝ)
  Assume: (ha : |a| ≤ 1)
  Conclusion: a ≤ 2
Proof:
  Since |a| ≤ 1 and |a| ≤ 1 ⇒ -1 ≤ a ∧ a ≤ 1 we get ha' : -1 ≤ a and ha'' : a ≤ 1
  Since a ≤ 1 we conclude that a ≤ 2
QED

/-
En fait on peut même laisser l’implication implicite.
-/

Example "Utilisation d’un énoncé impliquant une conjonction,
         to laissant l’implication implicite."
  Given: (a b : ℝ)
  Assume: (ha : |a| ≤ 1)
  Conclusion: a ≤ 2
Proof:
  Since |a| ≤ 1 we get ha' : -1 ≤ a and ha'' : a ≤ 1
  Since a ≤ 1 we conclude that a ≤ 2
QED

/-
Un autre énoncé du même type qui servira très fréquemment dans les feuilles
suivantes est
`∀ x a b, x ≥ max a b ⇒ (x ≥ a ∧ x ≥ b)`.
-/

Exercise "06.4 Utilisation d’un lemme de la base de donnée dont la conclusion
          est une conjonction"
  Given: (x a b : ℝ)
  Assume: (hx : x ≥ max a b) (ha : a ≥ 1)
  Conclusion: x ≥ 1
Proof:
  sorry
QED

/-
L’exercice suivant nécessite plus de réflexion. Il fait intervenir la notion
de pgcd de deux entiers naturels and la divisibilité. On rappelle que la
barre de divisibilité n’est pas la barre de la touche 6 sur un clavier azerty mais
un symbole unicode qu’on peut obtenir par `,dvd`.

La commande `We compute` (et sa cousine la justification `by computation` dans les `Calc`)
savent que
`∀ a b, pgcd a b ∣ a`
et
`∀ a b, pgcd a b ∣ b`
et aussi
`∀ a, a ∣ a`.

La base de données de lemmes contient l’énoncé
`∀ a b : ℕ, (a ∣ b ∧ b ∣ a) ⇒ a = b`
(notez que cet énoncé est faux pour des entiers relatifs et, pour cette raison,
l’exercice suivant ne fonctionnerait pas avec des entiers relatifs).

Elle contient également l’énoncé
`∀ a b c : ℕ, (c ∣ a ∧ c ∣ b) ⇒ c ∣ pgcd a b`

Ces cinq énoncés suffisent à faire l’exercice.
-/

Exercise "06.5"
  Given: (a b : ℕ)
  Assume:
  Conclusion: a ∣ b ⇔ pgcd a b = a
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

