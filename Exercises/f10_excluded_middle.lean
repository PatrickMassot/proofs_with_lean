import ProofsWithLean.LibNeg
setup_env

open m154
/-
# Feuille 10 : Tiers exclu, raisonnements par l’absurde and contraposées.

## Le principe du tiers-exclu

Après l’énoncé `Faux` and la définition de la négation, le troisième and dernier
ingrédient de la théorie des négations est le principe du tiers-exclu :

« Pour tout énoncé P, P or ¬ P ».

Ce principe ne découle pas du principe d’explosion and de la définition de la
négation, il faut le rajouter comme axiome.

Cet axiome se présente sous de multiple formes équivalentes. On commence par
l’utiliser sous sa forme d’origine.
-/

Example "Valeur absolue d’une somme"
  Given: (x y : ℝ)
  Assume:
  Conclusion: |x + y| ≤ |x| + |y|
Proof:
  We discuss depending on whether 0 ≤ x + y or ¬ 0 ≤ x + y
  Assume h : 0 ≤ x + y
  Calc
   |x + y| = x + y since x + y ≥ 0
   _       ≤ |x| + |y| since x ≤ |x| and y ≤ |y|
  Assume h :  ¬ 0 ≤ x + y
  Since ¬ 0 ≤ x + y we get h' : x + y < 0
  Calc
    |x + y| = -(x + y) since x + y < 0
    _       = -x + (-y) by computation
    _       ≤ |x| + |y| since -x ≤ |x| and -y ≤ |y|
QED

/-
Dans l’exercice suivant, on pourra utiliser implicitement les faits suivants :
`∀ x ≥ 0, |x| = x`
`∀ x < 0, x = - |x|`
`∀ x, x^2 ≥ 0`
`∀ x, (-x)^2 = x^2`
-/

Exercise "10.01 Valeur absolue d’un carré"
  Given: (x : ℝ)
  Assume:
  Conclusion: |x^2| = |x|^2
Proof:
  sorry
QED

/-
## Le raisonnement par l’absurde

On passe maintenant à la deuxième incarnation du principe du tiers exclu : le
principe de raisonnement par l’absurde. Ce raisonnement est basé sur la
conséquence suivante du tiers exclu :
Pour tout énoncé `P`, `¬ ¬ P ⇒ P`.
Ainsi pour démontrer `P`, il suffit de démontrer `¬ ¬ P`. Or, par définition, pour
démontrer `¬ ¬ P`, il suffit de supposer `¬ P` and de montrer `Faux`.
On to déduit que, pour montrer `P`, il suffit de supposer `¬ P` and de montrer
une contradiction. Since ce raisonnement est très général and un peu fastidieux, on
l’abrège to la phrase « Assume par l’absurde `¬ P` », où le `¬ P` peut être
remplacé par une formulation équivalente.
-/

Example "Dans un triangle rectangle (non dégénéré) de côtés a, b and c,
         c étant l’hypoténuse, on a : a + b > c."
  Given: (x y z : ℝ)
  Assume: (hx : x > 0) (hy : y > 0) (hP : z^2 = x^2 + y^2)
  Conclusion: z < x + y
Proof:
  Assume for contradiction hn : z ≥ x + y
  It suffices to prove that x^2 + y^2 > x^2 + y^2
  Since x > 0 and y > 0 we get hxpy: x + y > 0
  Since x > 0 and y > 0 we get hxmy: x * y > 0
  Calc
   x^2 + y^2 = z^2 by hypothesis
   _ ≥ (x + y)^2 since x + y ≥ 0 and z ≥ x + y
   _ = x^2 + y^2 + 2*x*y by computation
   _ > x ^ 2 + y ^ 2 since 2*x*y > 0
QED

/-
L’exemple suivant reprend l’exercice d’unicité de la limite d’un fichier précédent.
On ne peut pas démontrer ce résultat sans utiliser l’axiome du tiers exclu
quelque part. Dans la précédente version, cette utilisation était cachée dans le lemme
`∀ x y, (∀ ε > 0, |x - y| ≤ ε) ⇒ x = y`
(dont on démontrera une variante plus bas à l’aide du tiers exclu).
Cette fois, on illustre l’utilisation du raisonnement par l’absurde and de la
commande correspondante `Assume for contradiction`.
-/

Example "Unicité de la limite."
  Given: (u : ℕ → ℝ) (l l' : ℝ)
  Assume: (hl : limite_suite u l) (hl' : limite_suite u l')
  Conclusion: l = l'
Proof:
  Assume for contradiction H : l ≠ l'
  Fact ineg : |l - l'| > 0 by
    Since l ≠ l' we get H' : l - l' ≠ 0
    Since l - l' ≠ 0 we conclude that |l - l'| > 0
  Since u tends to l and |l - l'|/4 > 0 we get N
      such that hN : ∀ n ≥ N, |u n - l| ≤ |l - l'| / 4
  Since u tends to l' and |l - l'|/4 > 0 we get N'
      such that hN' : ∀ n ≥ N', |u n - l'| ≤ |l - l'| / 4
  Set N₀ := max N N' -- la commande « Posons » n'est jamais indispensable
                        -- mais elle économise quelques caractères.
  Since ∀ n ≥ N, |u n - l| ≤ |l - l'| / 4 and N₀ ≥ N
     we get hN₁ : |u N₀ - l| ≤ |l - l'| / 4
  Since ∀ n ≥ N', |u n - l'| ≤ |l - l'| / 4 and N₀ ≥ N'
     we get hN'₁ : |u N₀ - l'| ≤ |l - l'| / 4
  Let's prove it's contradictory -- Cette ligne n’est pas obligatoire mais clarifie
  -- La ligne suivante utilise implicitement l’énoncé `∀ x, x < x ⇒ Faux`
  It suffices to prove that |l - l'| < |l - l'|
  Calc
    |l - l'| ≤ |l - u N₀| + |u N₀ - l'|   by computation
    _        = |u N₀ - l| + |u N₀ - l'|   by computation
    _        ≤ |l - l'|/4 + |l - l'|/4    since |u N₀ -  l| ≤ |l - l'| / 4 and
                                                  |u N₀ - l'| ≤ |l - l'| / 4
    _        = |l - l'|/2                 by computation
    _        < |l - l'|                   since |l - l'| > 0
QED

Exercise "10.02 Nombres plus petits que tout nombre strictement positif"
  Given: (x : ℝ)
  Assume: (h : ∀ ε > 0, x ≤ ε)
  Conclusion:  x ≤ 0
Proof:
  sorry
QED

/-
## Le principe de contraposition

Une autre incarnation très utile de l’axiome du tiers exclu est le principe
de contraposition : pour démontrer « P ⇒ Q », il suffit de démontrer
« non Q ⇒ non P ».

L’exemple suivant illustre l’utilisation du principe de contraposition
et de la commande correspondante `Let's prove the contrapositive: …`.
-/

Example "Commande de contraposition"
  Given: (P Q : Prop)
  Assume: (h : (¬ Q) ⇒ ¬ P)
  Conclusion: P ⇒ Q
Proof:
  Let's prove the contrapositive: (¬ Q) ⇒ ¬ P
  We conclude by hypothesis
QED

/-
Voici un exercice plus concret.
-/

Exercise "10.03 Contraposition concrète"
  Given: (f : ℝ → ℝ)
  Assume: (hf : f is injective)
  Conclusion: ∀ x y, x ≠ y ⇒ f x ≠ f y
Proof:
  sorry
QED

/-
Le but de l’exercice suivant est de voir comment le principe de raisonnement
par l’absurde entraîne le principe de contradiction. Il est donc crucial de le
résoudre sans utiliser `Let's prove the contrapositive: …` mais using
`Assume for contradiction : …`.
-/
Exercise "10.04 Le principe de contraposition à partir du raisonnement par l’absurde."
  Given: (P Q : Prop)
  Assume: (h : (¬ Q) ⇒ ¬ P)
  Conclusion: P ⇒ Q
Proof:
  sorry
QED


/- Dans cet exercice, on raisonnera par contraposition pour une des implications
et on utilisera les définitions de pair and impair.
On pourra aussi utiliser que la base de données de lemmes utilisables implicitement
contient les énoncés :
 `∀ n, ¬ n is even ⇒ n is odd`
 `∀ n, ¬ n is odd ⇒ n is even`
-/
Exercise "10.05 parité and élévation au carré"
  Given: (n : ℤ)
  Assume:
  Conclusion: n^2 is even ⇔ n is even
Proof:
  sorry
QED


/-
## Négation des énoncés quantifiés

Il est crucial de comprendre les négations d'énoncés comportant des
quantificateurs. Dans l’exercice suivant, on utilisera seulement la
définition de la négation.
-/

Exercise "10.06 Négation d’un énoncé existentiel"
  Given: (n : ℤ)
  Assume:
  Conclusion: ¬ (∃ k, n = 2*k) ⇔ ∀ k, n ≠ 2*k
Proof:
  sorry
QED

/-
By contraste, la règle de négation du quantificateur universel requiert le
principe du tiers-exclu. Afin de ne pas faire trop de logique pure dans ce
cours, la section suivante explique comment utiliser ces règles de négation
sans les démontrer.

## Pousser la négation à travers un énoncé

L’exemple suivant montre comment `It suffices to prove that` peut reformuler le
but courant to poussant une négation à travers des quantificateurs.
-/

Example "La fonction x ↦ 2x n'est pas paire."
  Given:
  Assume:
  Conclusion: ¬ (fct x ↦ 2*x) is even
Proof:
  Let's prove that ¬ ∀ x, 2 * (-x) = 2 * x -- Cette ligne est optionnelle
  It suffices to prove that ∃ x : ℝ, 2 * (-x) ≠ 2 * x
  Let's prove that 42 works
  -- We compute -- or bien
  Assume hyp : 2 * -42 = 2 * 42
  Since 2 * -42 = 2 * 42 we conclude that Faux
QED

Exercise "10.07 La fonction identité, x ↦ x, n'est pas majorée."
  Given:
  Assume:
  Conclusion: ¬ ∃ M : ℝ, ∀ x, x ≤ M
Proof:
  sorry
QED

/-
Cette façon de pousser les négations est également disponible pour la commande
`Since … we get h : …` où la nouvelle hypothèse `h` peut être simplement
obtenue to poussant la négation dans le fait fourni. Cela vaut également pour la variante
`Since … we conclude that …`, comme on le voit dans l’exemple suivant.
-/

Example "Pousser la négation à travers un quantificateur"
  Given: (f : ℝ → ℝ)
  Assume: (h : ¬ ∀ x, f (-x) ≤ f x)
  Conclusion: ∃ x, f (-x) > f x
Proof:
  Since ¬ ∀ x, f (-x) ≤ f x we conclude that ∃ x, f (-x) > f x
QED

/-
Vous pouvez utiliser cette façon de pousser la négation pour démontrer un très
grand classique des « paradoxes » logiques : dans un bar non-vide, il existe
toujours une personne `p` telle que si `p` boit alors tout le monde boit.

La démonstration commence par une application du principe du tiers exclu,
c’est-à-dire par `We discuss depending on whether … or ¬ …` (avec le même énoncé pour remplacer
les deux séries de points de suspension).

Vous pouvez passer cet exercice si vous êtes un peu to retard sur le reste du groupe.
-/
Exercise "10.08 Le paradoxe du buveur"
  Given: (x : Bar) -- Le bar est supposé non-vide, on note `x` une personne du bar
  Assume:
  Conclusion: ∃ p : Bar, (p boit ⇒ ∀ q : Bar, q boit)
Proof:
  sorry
QED

/-
La combinaison « contraposition puis pousser la négation » est tellement courante
que la commande `Let's prove the contrapositive: …` essaie automatiquement de pousser
la négation après la contraposition pour obtenir la contraposée annoncée, comme
vous le constaterez dans l’exercice suivant qui est la variante promise de
`∀ x y, (∀ ε > 0, |x - y| ≤ ε) ⇒ x = y` (et déjà démontrée par l’absurde plus haut).
-/

Exercise "10.09 Nombres plus petits que tout nombre strictement positif"
  Given: (x : ℝ)
  Assume:
  Conclusion: (∀ ε > 0, x ≤ ε) ⇒ x ≤ 0
Proof:
  sorry
QED

/-
Dans l’exercice suivant, on pourra utiliser que la commande `We proceed depending on`
connait le lemme `a ≤ b ⇒ a = b ∨ a < b`
Ainsi, to ayant l’hypothèse `hxy : x ≤ y`, la commande
`We discuss depending on whether x = y or x < y` permet de scinder
la discussion to deux branches, l’une supposant x = y and l’autre x < y.
-/

Exercise "10.10 Caractérisation des fonctions strictement croissantes"
  Given: (f : ℝ → ℝ)
  Assume:
  Conclusion: (∀ x y, x < y ⇒ f x < f y) ⇔ (∀ x y, (x ≤ y ⇔ f x ≤ f y))
Proof:
  sorry
QED

