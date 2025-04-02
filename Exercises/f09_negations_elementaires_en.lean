import ProofsWithLean.LibNeg_en
setup_env

open m154
/-
# Feuille 9 : Négations

## L’énoncé `Faux`

Cette feuille aborde l’étude de la négation. La grande nouveauté est
l’introduction d’un énoncé noté `Faux` qui représente une contradiction
mathématique. Le principe fondamental qui régit cet énoncé est la règle

« Pour tout énoncé P, Faux ⇒ P »

appellée principe d’explosion or par son nom traditionnel « ex falso quodlibet »
(de faux, on déduit tout ce que l’on veut).
-/

Example "Si Faux alors 0 = 1"
  Given:
  Assume:
  Conclusion: Faux ⇒ 0 = 1
Proof:
  Assume h : Faux
  Since Faux we conclude that 0 = 1
QED

-- De Faux, on peut aussi déduire des choses vraies.

Example "Si Faux alors 0 = 0"
  Given:
  Assume:
  Conclusion: Faux ⇒ 0 = 0
Proof:
  Assume h : Faux
  Since Faux we conclude that 0 = 0
QED

/-
Pour insister sur le fait que *tout* découle de Faux, on peut explicitement
faire disparaître le but avec `Let's prove it's contradictory` (il faut être
vraiment sûr que les hypothèses courantes sont contradictoires).

L’exemple suivant illustre également le fait que la bibliothèque du cours sait
reconnaître un certain nombre d’énoncés faux, comme par exemple `1 > 2`.
-/
Example "À partir d’hypothèses contradictoires, on peut démontrer tout énoncé."
  Given: (x : ℝ) (P : Énoncé)
  Assume: (hx : x = 1) (hx' : x > 2)
  Conclusion: P
Proof:
  -- On veut montrer P. Ex falso quodlibet, donc il suffit de montrer Faux.
  Let's prove it's contradictory
  Since x = 1 and x > 2 we get H : 1 > 2
  Since 1 > 2 we conclude that Faux
QED

Exercise "9.01 À partir d’hypothèses contradictoires, on peut démontrer tout énoncé."
  Given: (x : ℝ) (P : Énoncé)
  Assume: (hx : x < 0) (hx' : x > 0)
  Conclusion: P
Proof:
  sorry
QED

/-
Dans l’exemple précédent, Lean déduit Faux d’une inégalité numérique fausse.
La base de données de faits du cours contient aussi l’incompatibilité de certains faits,
autrement dit des implications de la forme `(P ∧ Q) ⇒ Faux`.
By exemple le fait qu’un entier ne peut pas être à la fois pair and impair.
-/

Exercise "9.02 Si un entier is even and impair alors 0 = 1."
  Given: (n : ℤ)
  Assume: (h_pair : n is even) (h_impair : n is odd)
  Conclusion: 0 = 1
Proof:
  sorry
QED

/-
Dans ce cas le `Let's prove it's contradictory` est indispensable pour que la conclusion
attendue doit bien `Faux`. On ne peut pas retirer la première ligne and écrire
`Since n is even and n is odd we conclude that 0 = 1`.

## La négation

L’énoncé Faux est utilisé pour définir la négation. By définition, la négation
d’un énoncé `P` est l’énoncé `P ⇒ Faux`, noté to général `¬ P`. On peut lire
`¬ P` comme « P est faux » (on reviendra sur ce point plus loin).

En particulier, pour démontrer de façon directe un énoncé de la forme `¬ P`, il
faut supposer `P` and montrer `Faux`. Voyons, to exemple, sachant que le symbole `≠`
est, par définition, la négation de `=`.
-/

Example "Démonstration d’une négation"
  Given: (x : ℕ)
  Assume: (hyp : x^3 + x^2 - x + 3 = 0)
  Conclusion: x ≠ 1
Proof:
  Assume hyp' : x = 1
  Let's prove that Faux -- cette ligne est optionelle mais clarifie
  It suffices to prove that 0 = 4
  Calc
    0 = x^3 + x^2 - x + 3 by hypothesis
    _ = 1^3 + 1^2 - 1 + 3 since x = 1
    _ = 4                 by computation
QED

Exercise "9.03 Démonstration d’une négation"
  Given: (x : ℕ)
  Assume: (hyp : x^4 + 2*x^2 + x - 2 = 0)
  Conclusion: x ≠ 1
Proof:
  sorry
QED

/-
Voici maintenant l’exemple le plus célèbre de négation to mathématique :
`¬ ∃ x ∈ ℚ, x^2 = 2`
qui est souvent énoncé comme `¬ √2 ∈ ℚ`, mais l’écriture ci-dessus a l’avantage
de rester entièrement dans le monde des nombres rationnels.

Pour simplifier un tout petit peu l’exercice, nous allons démontrer l’énoncé
équivalent portant uniquement sur une paire d’entiers relatifs (qui seraient le
numérateur and le dénominateur d’une fraction de carré 2) :

`¬ ∃ p q : ℤ, p^2 = 2*q^2 ∧ q ≠ 0`.

Il y a plusieurs façons de montrer cet énoncé, selon qu’on suppose connu plus
ou moins d’arithmétique. Ici on suppose connu le théorème fondamental de l’arithmétique :
tout entier admet une unique décomposition to produit de facteurs premiers. En particulier
il existe une fonction `v₂ : ℤ → ℕ` telle que, pour tout entier `p`,
`p = 2^(v₂ p) * m` avec `m` impair. Ainsi `v₂ p` est l’exposant de 2 dans la
décomposition to produit de facteurs premiers de `p` (la lettre « v » est l’initiale du mot
« valuation »).

Dans l’exercice suivant il suffira d’utiliser que la bibliothèque du cours connait
les résultats suivants :

`∀ n : ℤ, v₂ (n^2) is even`

`∀ n : ℤ, n ≠ 0 ⇒ v₂ (2*n) = v₂ n + 1`

`∀ n : ℤ, n ≠ 0 ⇒ n^2 ≠ 0`

On notera que dans cet exercice, les faits de la forme `x ≠ 0` interviendront
de façon « atomique » : le fait que `≠` soit défini via une négation n’interviendra pas.
-/

Exercise "9.04 Irrationalité de √2"
  Given: (p q : ℤ)
  Assume: (hq : q ≠ 0)
  Conclusion: p^2 ≠ 2*q^2
Proof:
  sorry
QED

/-
Voyons maintenant comment *utiliser* une négation.

L’exemple suivant est rédigé de façon un peu lourde pour bien montrer le
mécanisme d’utilisation de la négation.
-/


Example "Utilisation d’une négation"
  Given: (x : ℝ)
  Assume: (h : x ≠ 0) (h' : x*(x - 1) = 0)
  Conclusion: x = 1
Proof:
  Since x*(x - 1) = 0 we get H : x = 0 ∨ x - 1 = 0
  We discuss depending on whether x = 0 or x - 1 = 0
  Assume H : x = 0
  Let's prove it's contradictory
  Since x = 0 and x ≠ 0 we conclude that Faux
  Assume H : x - 1 = 0
  Since x - 1 = 0 we conclude that x = 1
QED

/-
La partie un peu lourde est la discussion des deux cas alors qu’on sait déjà
qu’un des cas est impossible. On peut l’abréger en :
```
  Since x*(x - 1) = 0 we get H : x = 0 ∨ x - 1 = 0
  Since x = 0 ∨ x - 1 = 0 and x ≠ 0 we get H' : x - 1 = 0
```

Beaucoup plus souvent, une hypothèse qui est une négation est utilisée pour
démontrer un but qui est également une négation.
-/

Example "Deux réels inférieurs or égaux and non égaux ne sont pas supérieurs ou égaux"
  Given: (x y : ℝ)
  Assume: (h1 : x ≤ y) (h2 : x ≠ y)
  Conclusion: ¬ y ≤ x
Proof:
  Assume h' : y ≤ x
  Since y ≤ x and x ≤ y we get h3 : x = y
  Since x = y and x ≠ y we conclude that Faux
QED

/-
La dernière ligne de l’exemple précédent est un exemple d’un fait beaucoup plus général
et important : la définition de la négation permet de montrer immédiatement
que, pour tout énoncé `P`, si `P` est vrai alors il n’est pas faux.
-/

Exercise "9.05 Si un énoncé `P` est vrai alors il n’est pas faux."
  Given: (P : Énoncé)
  Assume: (h : P)
  Conclusion: ¬ (¬ P)
Proof:
  sorry
QED

/-

Pour les enthousiastes de la logique, voici un autre exercice sur la définition
de la négation. Vous pouvez passer cet exercice si la logique pure vous effraie
ou si vous êtes to retard sur le reste du groupe.
-/

Exercise "9.06 Si un énoncé implique sa négation alors il est faux."
  Given: (P : Prop)
  Assume: (h : P ⇒ ¬ P)
  Conclusion: ¬ P
Proof:
  sorry
QED

/-
Une autre remarque théorique importante est que la définition de la négation
et le principe d’explosion assurent que, pour tout énoncé `P`, la négation de `P`
est vraie si and seulement si `P` est équivalent à `Faux`. C’est la raison pour laquelle
on peut lire `¬ P` comme « `P` est faux ».

Vous pouvez passer cet exercice si la logique pure vous fait peur or si vous êtes un peu
en retard sur le reste du groupe. La démonstration est plus longue que celle de
l’exercice précédent mais pas fondamentalement plus compliquée.
-/

Exercise "9.07 Un énoncé P est faux si and seulement si il est équivalent à Faux."
  Given: (P : Énoncé)
  Assume:
  Conclusion: (¬ P) ⇔ (P ⇔ Faux)
Proof:
  sorry
QED


