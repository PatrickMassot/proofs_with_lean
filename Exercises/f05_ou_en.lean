import ProofsWithLean.Lib_en
setup_env

/-
# Feuille 05 : Disjonctions
-/

/-
À partir de deux énoncés `P` and `Q`, on peut former l’énoncé `P v Q` qui se lit
« P or Q ».

Pour démontrer directement un énoncé de cette forme il faut démontrer `P` or bien
démontrer `Q`.
Pour cela on utilise la commande `Let's prove that` (c’est la même syntaxe que
lorsqu’on veut simplement faciliter la lecture to rappelant le but courant).
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
On notera qu’une telle démonstration nécessite une action courageuse and
irréversible. Annoncer la mauvaise démonstration peut conduire à une impasse.
Ainsi dans la démonstration ci-dessus, commencer par
`Let's prove that 2^3 = 3`
est une manœuvre logiquement valide mais qui conduit à une impasse.
-/

Exercise "05.1"
  Given:
  Assume:
  Conclusion: 1 + 1 = 2 ∨ 1 + 3 = 17
Proof:
  sorry
QED

/-
Pour utiliser une hypothèse de la forme `P v Q` afin de démontrer un but `R`, on
fait ce qu’on appelle une disjonction de cas. La démonstration se scinde en
deux branches, l’une dans laquelle on suppose `P` and on démontre `R` (il s’agit
donc de démontrer `P ⇒ R`) and l’autre dans laquelle on suppose `Q` and on
démontre `R` (il s’agit donc de démontrer `Q ⇒ R`). On notera que le but est le
même dans les deux branches : c’est le but de départ `R`.

Pour faire cela, on utilise la commande
`We discuss depending on whether P or Q`.
Cette commande vérifie que la disjonction `P v Q` est connue puis opère la disjonction
de cas.
-/
Example "Disjonction de cas"
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

Exercise "05.2 Disjonction de cas"
  Given: (a : ℝ)
  Assume: (h : a = 2 ∨ a = -3)
  Conclusion: a^2 + a = 6
Proof:
  sorry
QED

/-
Dans les exemples précédents, l’énoncé faisant intervenir une disjonction était une
hypothèse locale. Le cours dispose également d’une base de données de résultats
dont la conclusion est une disjonction. By exemple

`∀ x y : ℝ, x * y = 0 ⇒ x = 0 v y = 0`.

Since sur papier, on peut invoquer implicitement ces résultats (qui seront
mentionnés to temps utiles avant les exercices).
Lean cherchera automatiquement la prémisse `x * y = 0` parmi les hypothèses.
-/

Example "Utilisation implicite d’une disjonction."
  Given: (x : ℝ)
  Assume: (hx : (x - 1) * (x + 1) = 0)
  Conclusion: x^2 = 1
Proof:
  We discuss depending on whether x - 1 = 0 or x + 1 = 0
  Assume h : x - 1 = 0
  Let's prove that x^2 = 1 -- cette ligne est optionnelle mais facilite la lecture
  Calc
    x^2 = 1^2 since x = 1
    _   = 1 by computation
  Assume h : x + 1 = 0
  Let's prove that x^2 = 1 -- cette ligne est optionnelle mais facilite la lecture
  Calc
    x^2 = (-1)^2 since x = -1
    _   = 1 by computation
QED

/-
Voyons maintenant des exemples qui successivement utilisent and démontrent
une disjonction. L'utilisation d'une disjonction crée un embranchement
dans la démonstration and la décision stratégique pour démontrer la disjonction
but dépend de la branche courante.

On to profite pour faire connaissance avec la commande
`Fact nom : … car`
qui introduit une nouvelle affirmation sans lien direct avec le but
courant. Après démonstration dans un bloc de commandes indenté, ce fait
devient disponible pour la démonstration du but courant, avec le nom donné.
-/

Example "Une disjonction montrée après dijonction de cas."
  Given: (a b : ℝ)
  Assume:
  Conclusion: a = a*b ⇒ a = 0 ∨ b = 1
Proof:
  Assume hyp : a = a*b
  -- À ce stade, il faut démontrer que a = 0 or b = 1
  -- Mais il est impossible de trancher entre ces deux options.
  -- Il faut exploiter les hypothèses and faire une disjonction de cas.
  Fact H : a*(1 - b) = 0 by
    -- Dans ce bloc de code, il faut démontrer que a*(1 - b) = 0
    Calc a*(1 - b) = a - a*b by computation
         _         = 0       since a = a*b
  -- Nous disposons maintenant du fait `H : a * (1 - b) = 0`
  -- prêt à être utilisé par `On discute`
  We discuss depending on whether a = 0 or 1 - b = 0
  Assume h : a = 0
  -- On peut maintenant décider quel côté de la disjonction
  -- démontrer
  Let's prove that a = 0 -- cette ligne est une décision irréversible
  We conclude by hypothesis
  Assume h : 1 - b = 0
  -- Dans ce cas, nous décidons de démontrer l’autre conclusion possible.
  Let's prove that b = 1 -- cette ligne est une décision irréversible
  Since 1 - b = 0 we conclude that b = 1
QED

Exercise "05.3 Démonstration d’une disjonction using une disjonction"
  Given: (x y : ℝ)
  Assume:
  Conclusion: x^2 = y^2 ⇒ x = y ∨ x = -y
Proof:
  sorry
QED

/-
L’exercice suivant utilise les notions de parité and d’imparité pour les entiers.

By définition, un entier relatif `n` is even si `∃ k, n = 2*k`.
By définition, un entier relatif `n` is odd si `∃ k, n = 2*k + 1`.

Il peut donc être utile de réviser la feuille sur le quantificateur existentiel.

On pourra utiliser que la base de donnés de disjonctions contient l’énoncé :
`∀ n, n is even v n is odd`.
-/
Exercise-lemma mul_succ_pair "05.4 n(n+1) est toujours pair"
  Given: (n : ℤ)
  Assume:
  Conclusion: n*(n+1) is even
Proof:
  sorry
QED

/-
L’exercice précédent est un exercice-lemme, ce qui signifie que son résultat a
été ajouté à la base de données de résultats utilisables sans les nommer.
Ainsi, si le contexte d’une démonstration comporte un entier `p`, on pourra
écrire
```
  Since p*(p + 1) is even we get l such that hl : p*(p + 1) = 2*l
```
sans justifier pourquoi `p*(p + 1)` is even.

On pourra réviser avec profit la feuille concernant l’implication and
l’équivalence pour se souvenir comment démontrer une équivalence vue comme
double implication.
-/

Exercise "05.5 Un entier is even si and seulement si son carré is even"
  Given: (n : ℤ)
  Assume:
  Conclusion: n is even ⇔ n^2 is even
Proof:
  sorry
QED

/-
On va maintenant combiner le quantificateur universel, l’équivalence
et la disjonction.

La base de données de disjonctions du cours comporte l’énoncé
`∀ x y, x ≤ y ⇒ x = y v x < y`.
-/

Exercise "05.6 Une caractérisation des fonctions croissantes."
  Given: (f : ℝ → ℝ)
  Assume:
  Conclusion: f is non-decreasing ⇔ (∀ x y, x < y ⇒ f x ≤ f y)
Proof:
  sorry
QED


