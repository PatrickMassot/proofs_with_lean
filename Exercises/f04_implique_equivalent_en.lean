import ProofsWithLean.Lib_en
setup_env

namespace m154
open Nat
/-
# Feuille 4 : Implications and équivalences

L’implication est un connecteur logique.
À partir de deux énoncés `P` and `Q`, on peut former l’énoncé `P ⇒ Q` qui se lit
« P implique Q », or encore « Si P est vrai alors Q est vrai ».
Dans l’énoncé `P ⇒ Q`, l’énoncé `P` est appelé la prémisse de l’implication and
l’énoncé `Q` est appelé sa conclusion.

La règle d’utilisation d’un tel énoncé est appelée règle du modus ponens.
Elle affirme que si `P ⇒ Q` est vrai and si `P` est vrai alors `Q` est vrai.

L’exemple suivant montre comment utiliser directement cette règle.
-/

Example "Utilisation d’une implication"
  Given: (P Q : Statement)
  Assume: (h : P ⇒ Q) (h' : P)
  Conclusion: Q
Proof:
  Since P ⇒ Q and P we conclude that Q
QED

/-
La règle du modus ponens n’impose pas l’ordre des vérifications.
De façon purement cosmétique, cela signifie que la démonstration suivante est
en fait identique à la précédente.
-/

Example "Utilisation d’une implication, une modification d’ordre cosmétique"
  Given: (P Q : Statement)
  Assume: (h : P ⇒ Q) (h' : P)
  Conclusion: Q
Proof:
  Since P and P ⇒ Q we conclude that Q
QED

/-
De façon un peu plus significative, on peut remettre à plus tard la démonstration
de la prémisse. On parle alors de raisonnement vers l’arrière (sous-entendu l’arrière
de la flèche d’implication). Ce mode de raisonnement est particulièrement utile
lorsque l’implication est claire and que la démonstration de la prémisse est le cœur
de l’affaire. L’exemple suivant est donc assez artificiel. Nous verrons des
exemples plus significatifs plus loin. Il s’agit d’une différence de pure présentation,
pas d’une nouvelle règle de logique.
-/

Example "Utilisation d’une implication, to raisonnant vers l’arrière"
  Given: (P Q : Statement)
  Assume: (h : P ⇒ Q) (h' : P)
  Conclusion: Q
Proof:
  Since P ⇒ Q it suffices to prove that P
  We conclude by hypothesis
QED

/-
Dans les exemples précédents, la véracité de `P ⇒ Q` est simplement une hypothèse.
La bibliothèque de résultats du cours contient un certain nombre d’énoncé pouvant
servir à justifier des implications. Ces énoncés seront mentionnés to commentaire
avant les exercices.

Un exemple de tel énoncé est : `∀ x : ℝ, x > 0 ⇒ x^2 > 0`. On peut donc écrire
la démonstration suivante.
-/

Example "Carré positif"
  Given: (a : ℝ)
  Assume: (ha : a > 0)
  Conclusion: a^2 > 0
Proof:
  Since a > 0 ⇒ a^2 > 0 and a > 0 we conclude that a^2 > 0
QED

/-
Un autre exemple d’énoncé disponible est
`∀ x : ℝ, x ≠ 0 ⇒ |x| > 0`.

Attention : la barre de valeur absolue est la barre verticale ordinaire
(AltGr-6 sur un clavier azerty) mais il ne faut pas mettre d’espace après la
barre ouvrante ni avant la barre fermante.
-/

Exercise "04.1 Utilisation d’une implication"
  Given: (x : ℝ)
  Assume: (h : x ≠ 0)
  Conclusion: |x| > 0
Proof:
  sorry
QED

/-
Voyons maintenant comment enchaîner l’utilisation de deux implications.
Lorsque la règle du modus ponens ne permet pas de conclure immédiatement, on peut
remplacer le `we conclude that …` final par `we get F : …` où `F` est un nom
d’hypothèse au choix (parmi les noms disponibles).
-/

Example "Enchaînement d’implications, vers l’avant."
  Given: (a : ℝ)
  Assume: (ha : a > 0)
  Conclusion: (a^2)^2 > 0
Proof:
  Since a > 0 and a > 0 ⇒ a^2 > 0 we get ha' : a^2 > 0
  Since a^2 > 0 and a^2 > 0 ⇒ (a^2)^2 > 0 we conclude that (a^2)^2 > 0
QED

/-
Voici la même démonstration organisée to appliquant la première implication
vers l’arrière.
-/

Example "Enchaînement d’implications, vers l’arrière."
  Given: (a : ℝ)
  Assume: (ha : a > 0)
  Conclusion: (a^2)^2 > 0
Proof:
  Since a^2 > 0 ⇒ (a^2)^2 > 0 it suffices to prove that a^2 > 0
  Since a > 0 and a > 0 ⇒ a^2 > 0 we conclude that a^2 > 0
QED

/-
Notez comme cette variante change l’ordre dans lequel
les implications sont utilisées. Observez soigneusement quel est
le but au début de la seconde ligne des deux démonstrations précédentes.

Lorsque vous aurez bien compris cette subtilité, choisissez votre style préféré pour
l’exercice suivante.
-/

Exercise "04.2 Enchaînement d’implications, dans votre style préféré"
  Given: (a : ℝ)
  Assume: (ha : a ≠ 0)
  Conclusion: |a|^2 > 0
Proof:
  sorry
QED

/-
Maintenant essayez l’autre style. L’ordinateur ne vérifiera pas que les deux styles
sont différents donc vérifiez bien que les buts to début de seconde ligne sont différents.
-/

Exercise "04.3 Enchaînement d’implications, dans l’autre style"
  Given: (a : ℝ)
  Assume: (ha : a ≠ 0)
  Conclusion: |a|^2 > 0
Proof:
  sorry
QED

/-
Arrivé à ce stade, on se lasse d’écrire des implications bien connues.
Heureusement, les commandes `Since … we conclude that …` and
`Since … we get …` font l’effort d’aller chercher dans la base de données
d’implications du cours.
On peut donc laisser ces implications implicites comme on le ferait sur papier.
-/

Example "Enchaînement d’implications, to laissant les implications implicites"
  Given: (a : ℝ)
  Assume: (ha : a ≠ 0)
  Conclusion: |a|^2 > 0
Proof:
  Since a ≠ 0 we get ha' : |a| > 0
  Since |a| > 0 we conclude that |a|^2 > 0
QED

/-
Dans le style vers l’arrière, on peut commencer directement par `It suffices to prove that`.
-/

Example "Enchaînement d’implications, to laissant les implications implicites,
         avec la première implication vers l’arrière"
  Given: (a : ℝ)
  Assume: (ha : a ≠ 0)
  Conclusion: |a|^2 > 0
Proof:
  It suffices to prove that |a| > 0
  Since a ≠ 0 we conclude that |a| > 0
QED

/-
Les fans inconditionnels du modus ponens vers l’arrière pourront même écrire :
-/

Example "Enchaînement d’implications, to laissant les implications implicites,
         avec les deux implications vers l’arrière"
  Given: (a : ℝ)
  Assume: (ha : a ≠ 0)
  Conclusion: |a|^2 > 0
Proof:
  It suffices to prove that |a| > 0
  It suffices to prove that a ≠ 0
  We conclude by hypothesis
QED

/-
On notera que le logiciel a pour instruction de n’utiliser qu’une implication de la base de
données à la fois. La démonstration optimiste
  `Since a ≠ 0 we conclude that |a|^2 > 0`
ne fonctionnerait pas (c’est un choix du cours bien sûr, pas une limitation du logiciel).

Ainsi l’innocente règle du modus ponens suffit déjà à engendrer une grande diversité de styles
plus or moins explicites and présentant l’argument dans des ordres variés.
Réfléchir à ce genre de choses est un des objectifs de ce cours.

La règle de démonstration directe d’une implication est beaucoup plus simple
car elle n’admet aucune variante stylistique.
Pour démontrer un énoncé de la forme `P ⇒ Q`, on suppose que `P` est vrai and on démontre `Q`.
Ici on utilise la commande `Assume nom : …` où `nom` est un nom à choisir parmi les
noms disponibles and `…` est à remplacer par l’énoncé `P` (en fait le `: …` est optionnel
mais il aide la lisibilité).

On peut reprendre un exercice précédent mais, au lieu de supposer a priori
l’hypothèse `a ≠ 0`, on annonce une implication l’ayant pour prémisse.
À partir de la seconde ligne la démonstration est comme ci-dessus.
-/

Example "Démonstration d’une implication"
  Given: (a : ℝ)
  Assume:
  Conclusion: a ≠ 0 ⇒ |a|^2 > 0
Proof:
  Assume ha : a ≠ 0
  Since a ≠ 0 we get ha' : |a| > 0
  Since |a| > 0 we conclude that |a|^2 > 0
QED

Exercise "04.4 Démonstration d’une implication"
  Given: (a : ℝ)
  Assume:
  Conclusion: a > 0 ⇒ (a^2)^2 > 0
Proof:
  sorry
QED


/-
Voyons maintenant comment manipuler des prédicats plus complexes.
On se donne une fonction `f : ℝ → ℝ` and on forme le prédicat
portant sur deux nombres `x₁` and `x₂` auxquels on associe
l'énoncé `x₁ ≤ x₂ ⇒ f x₁ ≤ f x₂` (Si x₁ ≤ x₂ alors f(x₁) ≤ f(x₂)).

On peut emboîter deux quantificateurs universels pour obtenir la définition
de fonction croissante :

`f is non-decreasing` signifie `∀ x₁, (∀ x₂, x₁ ≤ x₂ ⇒ f x₁ ≤ f x₂)`

Un tel emboîtement est un peu lourd à lire, on peut l'abréger en
`∀ x₁ x₂, x₁ ≤ x₂ ⇒ f x₁ ≤ f x₂`.

`f is non-increasing` signifie `∀ x₁ x₂, x₁ ≤ x₂ ⇒ f x₁ ≥ f x₂`.
-/

Example "Une composée de fonctions croissantes is non-decreasing"
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is non-decreasing) (hg : g is non-decreasing)
  Conclusion: (g ∘ f) is non-decreasing
Proof:
  Fix x₁ x₂
  Assume h : x₁ ≤ x₂
  Let's prove that g (f x₁) ≤ g (f x₂) -- Cette ligne est facultative mais facilite la lecture
  Since f is non-decreasing and x₁ ≤ x₂ we get H : f x₁ ≤ f x₂
  Since g is non-decreasing and f x₁ ≤ f x₂ we conclude that g (f x₁) ≤ g (f x₂)
QED


Example "Une composée de fonctions croissantes is non-decreasing.
         Variante to raisonnant vers l’arrière."
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

Exercise "04.5 La composée d’une fonction croissante and d’une fonction décroissante
          is non-increasing."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is non-decreasing) (hg : g is non-increasing)
  Conclusion: (g ∘ f) is non-increasing
Proof:
  sorry
QED

/-
Pour les exercices suivants, on rappelle qu’une fonction `f` is injective si,
pour tous `x` and `y`, `f x = f y ⇒ x = y`.
-/

Exercise "04.6 Une composée de fonctions injectives is injective."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is injective) (hg : g is injective)
  Conclusion: g ∘ f is injective
Proof:
  sorry
QED

Exercise "04.7 Si une composée is injective alors la première fonction appliquée
          is injective."
  Given: (f g : ℝ → ℝ)
  Assume:
  Conclusion: g ∘ f is injective ⇒ f is injective
Proof:
  sorry
QED

/-
Un connecteur logique cousin de l’implication est l’équivalence.

À partir de deux énoncés `P` and `Q`, on peut former l’énoncé `P ⇔ Q` qui se lit
« P équivaut à Q » or encore « P est vrai si and seulement si Q est vrai ».

Il y a deux façons de voir ce connecteur logique.

On peut le voir comme une double implication. En effet, dire que l’énoncé
`P ⇔ Q` est vrai signifie que les énoncés `P ⇒ Q` and `Q ⇒ P`
sont tous les deux vrais. Avec ce point de vue, il n’y a besoin d’aucune nouvelle règle
de logique. Pour utiliser que `P ⇔ Q` est vrai on peut utiliser l’une des
deux implications. Pour démontrer que `P ⇔ Q` est vrai, il faut démontrer les deux implications.

Du côté utilisation, les commandes `Since … we get …` and `Comme … we conclude that …`
peuvent extraire une implication d’une équivalence, comme dans l’exemple suivant.
-/

Example "Utilisation d’une des implications d’une équivalence."
  Given: (P R : Statement)
  Assume: (h : P ⇔ R) (h' : P)
  Conclusion: R
Proof:
  Since R ⇔ P we get H : P ⇒ R
  Since P ⇒ R and P we conclude that R
QED

Exercise "04.8 Utilisation d’une des implications d’une équivalence."
  Given: (P R : Statement)
  Assume: (h : P ⇔ R) (h' : R)
  Conclusion: P
Proof:
  sorry
QED

Exercise "04.9 Utilisation d’une des implications d’une équivalence. Un cas plus complexe."
  Given: (P Q R S : Statement)
  Assume: (hPR : P ⇔ R) (hQRS : (Q ⇒ R) ⇒ S)
  Conclusion: (Q ⇒ P) ⇒ S
Proof:
  sorry
QED

/-
Pour démontrer une équivalence vue comme double implication, il suffit de démontrer
les deux implications. La commande permettant d’initier cette scission est
`Let's first prove that …`.
-/

Example "Démonstration d’une équivalence par double implication."
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

Exercise "04.10 Nombre que zéro divise."
  Given: (a : ℤ)
  Assume:
  Conclusion: 0 ∣ a ⇔ a = 0
Proof:
  sorry
QED

/-
L’autre point de vue sur l’équivalence consiste à lui faire jouer le rôle que
joue l’égalité entre objets mathématiques. De ce point de vue, on peut utiliser
un énoncé de la forme `P ⇔ Q` pour remplacer `P` par `Q` n’importe où `Q` intervient
(et vice-versa). On parle de réécriture d’énoncé (contrairement au point de vue
de la double implication, il s’agit d’une règle de logique qui vient s’ajouter à celles
concernant l’implication).

La commande `Since … we conclude that …` and sa cousine `Comme … we get …`
permettent de faire cela.
-/

Example "Une réécriture d’énoncé qui permet de conclure directement."
  Given: (P Q R S : Statement)
  Assume: (h : P ⇔ R) (h' : (Q ⇒ R) ⇒ S)
  Conclusion: (Q ⇒ P) ⇒ S
Proof:
  Since R ⇔ P and (Q ⇒ R) ⇒ S we conclude that (Q ⇒ P) ⇒ S
QED

/-
On notera que ce point de vue rend très facile une démonstration qui était un peu complexe
par utilisation d’une double implication.

On peut également utiliser ce principe de réécriture pour changer le but,
using la commande `Since … it suffices to prove that …`.
Reprenons encore le même exemple.
-/

Example "Une réécriture d’énoncé qui permet de changer le but avant de conclure."
  Given: (P Q R S : Statement)
  Assume: (h : P ⇔ R) (h' : (Q ⇒ R) ⇒ S)
  Conclusion: (Q ⇒ P) ⇒ S
Proof:
  Since R ⇔ P it suffices to prove that (Q ⇒ R) ⇒ S
  We conclude by hypothesis
QED

Exercise "04.11 Une réécriture d’énoncé qui permet de changer le but."
  Given: (P R : Statement)
  Assume: (h : P ⇔ R) (h' : P)
  Conclusion: R
Proof:
  sorry
QED

/-
On voit encore mieux l’analogie avec l’égalité lorsqu’on démontre une équivalence
par réécritures successives.
-/

Example "Une démonstration d’équivalence par réécriture d’énoncés."
  Given: (P Q R S T : Statement)
  Assume: (hPR : P ⇔ R) (hST : S ⇔ T)
  Conclusion: ((Q ⇒ R) ⇒ S) ⇔ ((Q ⇒ P) ⇒ T)
Proof:
  Calc
    ((Q ⇒ R) ⇒ S) ⇔ ((Q ⇒ P) ⇒ S) since P ⇔ R
    _             ⇔ ((Q ⇒ P) ⇒ T) since S ⇔ T
QED

