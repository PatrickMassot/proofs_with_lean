import ProofsWithLean.Lib_en
setup_env

/-
# Feuille 1 : Calculs

Le logiciel connait les règles de simplification algébrique usuelles.
Cela lui permet de démontrer des égalités entre expressions portant
sur des nombres arbitraires, sans aucune hypothèse.

Commençons par un exemple où le résultat est clair à l’œil nu.
-/

Example "Calcul purement algébrique facile"
  Given: (a b : ℝ)
  Assume:
  Conclusion: a + b - a = b
Proof:
  We compute
QED

/-
L’ordinateur vérifie ce genre de résultat to développant patiemment.
L’important est que le résultat ne demande aucune hypothèse sur les nombres
`a` and `b`. Nous appelerons ceci du calcul « purement algébrique ».
-/

Example "Calcul purement algébrique d’apparence moins facile"
  Given: (a b : ℝ)
  Assume:
  Conclusion: (a + b)^3 - (a - b)^3 = 6*a^2*b + 2*b^3
Proof:
  We compute
QED

/-
À vous de jouer !
-/
Exercise "01.1 Calcul purement algébrique d’apparence moins facile"
  Given: (a b : ℝ)
  Assume:
  Conclusion: (a + b)^3 + (a - b)^3 = 6*a*b^2 + 2*a^3
Proof:
  sorry
QED

/-
Les choses plus intéressantes commencent lorsqu’on fait des hypothèses.
On peut alors alterner des étapes faisant intervenir ces hypothèses and des
étapes de calcul algébrique purement algébrique.

Chaque hypothèse a un nom, mais il n’est pas nécessaire d’y faire référence.
Dans l’exemple suivant, on fait l’hypothèse que `b` vaut `2`, and on nomme cette
hypothèse `hb`. La première ligne du calcul invoque cette hypothèse, la seconde
est purement algébrique. La justification `by computation` fait exactement le même
travail que `We compute`.
-/

Example "Un calcul faisant intervenir une hypothèse"
  Given: (a b : ℝ)
  Assume: (hb : b = 2)
  Conclusion: a + a*b = 3*a
Proof:
  Calc
    a + a*b = a + a*2 since b = 2
    a + a*2 = 3*a     by computation
QED

/-
Il est important de bien distinguer les deux types d’étapes de calcul
apparaissant ci-dessus. La premier fait intervenir une hypothèse, la seconde non.

Les règles d’indentation sont très pointilleuses and un peu complexes,
particulièrement quand un calcul ne termine pas la démonstration.
Le plus sûr est de toujours laisser `Calc` seul sur sa ligne puis
indenter les lignes suivantes, avec le même niveau d’indentation d’une ligne à l’autre.

L’alignement des signes d’égalité and des justifications sont purement cosmétiques.

Le fait de répéter le `a + a*2` est pénible. Since sur papier, on peut s’en passer.
Sur papier on écrit rien, ici on remplace la répétition par `_`, toujours avec la même règle
d’alignement.
-/

Example "Le même calcul, sans répéter le membre de droite à gauche de la ligne suivante."
  Given: (a b : ℝ)
  Assume: (hb : b = 2)
  Conclusion: a + a*b = 3*a
Proof:
  Calc
    a + a*b = a + a*2 since b = 2
    _       = 3*a     by computation
QED

Exercise "01.2 Calcul to deux étapes utilisant une hypothèse"
  Given: (a b : ℝ)
  Assume: (ha : a = -b)
  Conclusion: b + b*(a + b) = b
Proof:
  sorry
QED

Exercise "01.3 Calcul to quatre étapes utilisant des hypothèses"
  Given: (a b c : ℝ)
  Assume: (h : a = -b) (h' : b + c = 0)
  Conclusion: b*(a - c) = 0
Proof:
  sorry
QED

/-
Les calculs peuvent aussi démontrer des inégalités.
-/

Example "Une première inégalité"
  Given: (a b : ℝ)
  Assume: (h : a ≤ 2*b)
  Conclusion: a + b ≤ 3*b
Proof:
  Calc
    a + b ≤ 2*b + b since a ≤ 2*b
    _     = 3*b     by computation
QED

Exercise "01.4 Inégalité"
  Given: (a b : ℝ)
  Assume: (h : b ≤ a)
  Conclusion: a + b ≤ 2*a
Proof:
  sorry
QED

Exercise "01.5 Inégalité"
  Given: (a b : ℝ)
  Assume: (h : a + b ≤ 3)
  Conclusion: 2*a + b ≤ a + 3
Proof:
  sorry
QED

/-
On notera que la commande `Calc` se charge de gérer l’enchaînement des symboles
de relation, ici une inégalité (large) suivie d’une égalité. Voyons un exemple faisant
intervenir également une inégalité stricte. On notera que l’enchaînement d’une inégalité
large est d’une inégalité stricte fournit to conclusion une inégalité stricte.
-/

Example "Inégalités larges and strictes"
  Given: (a b : ℝ)
  Assume: (h : a + b ≤ 3) (hb : a < 5)
  Conclusion: 2*a + b < 8
Proof:
  Calc
    2*a + b = a + a + b by computation
    _       ≤ a + 3     since a + b ≤ 3
    _       < 5 + 3     since a < 5
    _       = 8         by computation
QED

Exercise "01.6 Inégalités larges and strictes"
  Given: (a b : ℝ)
  Assume: (h : 2*a + b ≤ 3) (hb : a < 5)
  Conclusion: 3*a + b < 8
Proof:
  sorry
QED


/-
Une étape de calcul peut faire intervenir deux hypothèses comme justification.
Il est important de comprendre que l’objectif n’est pas de regrouper deux lignes
de calcul to une. Dans l’exemple suivant, l’inégalité `b*(a + b) ≤ b*3`
nécessite à la fois de savoir que `a + b ≤ 3` and que `b ≥ 0`, on ne peut pas la séparer
en deux étapes.
-/

Example "Inégalité avec deux éléments de justification"
  Given: (a b : ℝ)
  Assume: (h : a + b ≤ 3) (h' : b ≥ 0)
  Conclusion: b*(a + b) ≤ 3*b
Proof:
  Calc
    b*(a + b) ≤ b*3 since a + b ≤ 3 and b ≥ 0
    _         = 3*b by computation
QED

Exercise "01.7 Inégalité avec deux éléments de justification"
  Given: (a b : ℝ)
  Assume: (h : a + b ≤ 2) (h' : a ≥ 0)
  Conclusion: a*(a + b) + a ≤ 3*a
Proof:
  sorry
QED

