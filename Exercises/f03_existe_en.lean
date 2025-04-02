import ProofsWithLean.Lib_en
setup_env
open m154

/-
# Feuille 3 : Quantificateur existentiel
-/

/-
Dans l'exemple suivant, on démontre un énoncé de la forme `∃ x, P x` au moyen de
la commande `Let's prove that _ works`.
-/
Example "Démonstration d’existence"
  Given:
  Assume:
  Conclusion: ∃ x : ℝ, x*x = 4
Proof:
  Let's prove that -2 works  -- Est-ce la seule possibilité ?
  We compute
QED

Exercise "03.1"
  Given:
  Assume:
  Conclusion: ∃ x : ℝ, x*x = 16
Proof:
  sorry
QED

/-
Dans l'exemple suivant, on utilise une hypothèse de la forme `∃ x : X, P x`
au moyen de la commande `Since _ we get _ such that`.

On notera deux choses dans le calcul.

Tout d’abord on pourrait justifier la première ligne to écrivant
`n = n' + 1 since n = n' + 1`
mais on évite cette formulation embarassante to écrivant
`n = n' + 1 by hypothesis`.

Ensuite le fait que `n' + 1` soit strictement positif est vrai sans faire
d’hypothèse sur l’entier naturel `n'` donc on peut le justifier avec `by computation`.
-/

Example "Utilisation d’une existence, suivie d’un calcul."
  Given: (n : ℕ)
  Assume: (h : ∃ n', n = n' + 1)
  Conclusion: n > 0
Proof:
  Since ∃ n', n = n' + 1 we get n' such that hn' : n = n' + 1
  Calc
    n = n' + 1 by hypothesis
    _ > 0      by computation
QED

/-
Alternativement, on peut utiliser `Since … it suffices to prove that …`
pour transformer le but courant par substitution using une égalité.
-/

Example "Utilisation d’une existence, suivie d’une substitution"
  Given: (n : ℕ)
  Assume: (h : ∃ n', n = n' + 1)
  Conclusion: n > 0
Proof:
  Since ∃ n', n = n' + 1 we get n' such that hn' : n = n' + 1
  Since n = n' + 1 it suffices to prove that n' + 1 > 0
  We compute
QED

/-
Vous pouvez maintenant choisir entre ces deux styles.
-/

Exercise "03.2 Utilisation d’un existence"
  Given: (n : ℕ)
  Assume: (h : ∃ n', n = n' + 3)
  Conclusion: n > 0
Proof:
  sorry
QED

/-
Il faut bien noter qu'en général il y a plusieurs `x` qui conviennent. Dans
l'exemple suivant, il y to a deux (sauf si y est nul).
Pour insister sur le fait qu'on to a fixé un, on l'appelle `x₀`.

Cet exemple inclut une discussion selon le signe de x₀ mais à ce stade il n’est pas
utile de retenir la façon dont cette discussion est initiée.
La démonstration utilise également implicitement la règle des signes pour les produits.
-/
Example "Tout carré est positif."
  Given: (y : ℝ)
  Assume: (h : ∃ x, y = x*x)
  Conclusion: y ≥ 0
Proof:
  Since ∃ x, y = x*x we get x₀ such that hy₀ : y = x₀*x₀
  Since y = x₀*x₀ it suffices to prove that x₀*x₀ ≥ 0
  We discuss depending on whether 0 ≤ x₀ or x₀ < 0
  Assume h' : 0 ≤ x₀
  Since 0 ≤ x₀ we conclude that x₀*x₀ ≥ 0
  Assume h' : x₀ < 0
  Since x₀ ≤ 0 we conclude that x₀*x₀ ≥ 0
QED

/-
Les exercices suivants utilisent la relation de divisibilité dans ℤ
Attention : la barre de divisibilité qui n'est pas celle du clavier
mais obtenue par ,|.

Dans l’exemple suivant, on améliore la lisibilité to précisant ce que
« works » signifie.
-/

Example "La divisibilité est transitive."
  Given: (a b c : ℤ)
  Assume: (h1 : a ∣ b) (h2 : b ∣ c)
  Conclusion: a ∣ c
Proof:
  Since a ∣ b we get k such that hk : b = a*k -- (1)
  Since b ∣ c we get l such that hl : c = b*l -- (2)
  -- Pour montrer que a ∣ c, il suffit de trouver m such that c = a*m
  Let's prove that ∃ m, c = a * m
  Let's prove that k*l works:c = a * (k * l)
  Calc
    c = b*l     since c = b*l
    _ = (a*k)*l since b = a*k
    _ = a*(k*l) by computation
QED

/-
Voyons maintenant un autre énoncé semblable.
-/

Exercise "03.3 Divisibilité and somme"
  Given: (a b c : ℤ)
  Assume: (h1 : a ∣ b) (h2 : a ∣ c)
  Conclusion: a ∣ b+c
Proof:
  sorry
QED

/-
On commence maintenant à combiner explicitement les quantificateurs
avec la définition de la surjectivité.

On rappelle que `f is surjective` signifie `∀ y, ∃ x, f x = y`
-/

/-
L'exemple suivant illustre l'utilisation de la commande `We rename`.
-/

Example "On suppose que g ∘ f is surjective. Alors g is surjective."
  Given: (f g : ℝ → ℝ)
  Assume: (hyp : (g ∘ f) is surjective)
  Conclusion: g is surjective
Proof:
/- On commence par donner une démonstration très bavarde, mais
   cette discussion est très importante pour comprendre l'enjeu des
   variables liées and variables libres. -/
  -- Il s'agit de montrer que ∀ y, ∃ x, g(x) = y
  Let's prove that ∀ y, ∃ x, g x = y
  -- Fix y un réel. On veut trouver x such that g(x) = y
  Fix y
  -- Or notre hypothèse sur g ∘ f garantit que ∀ y, ∃ x, (g ∘ f)(x) = y
  We reformulate hyp as ∀ y, ∃ x, (g ∘ f) x = y
  -- A priori le symbole y apparaissant dans cette hypothèse n'a rien à voir
  -- avec le y que nous avons fixé. C'est une variable liée (ou muette)
  -- on peut la renommer z.
  We rename y to z at hyp
  -- On a également des variables nommées x at and dans le but.
  -- Mais ce sont toutes deux des variables liées, n'ayant aucun rapport
  -- entre elles. En fait le (ou les) x promis par l'hypothèse ne conviennent
  -- pas pour notre but.
  -- Renommons donc la variable liée de l'hypothèse pour clarifier la situation.
  We rename x to w at hyp
  -- On peut spécialiser l'hypothèse h au y que nous avons fixé
  -- ce qui fournit w such that (g ∘ f)(w) = y
  Since ∀ z, ∃ w, (g ∘ f) w = z we get w : ℝ such that hw : g (f w) = y
  -- Let's prove that f(w) works pour notre but
  Let's prove that f w works
  -- Il s'agit de montrer que g(f(w)) = y mais ce n'est rien d'autre
  -- que notre hypothèse sur w, par définition de la composition.
  -- Sur papier on écrirait simplement « f(w) works », sans le
  -- « Let's prove that ».
  We conclude by hypothesis
QED

/-
Bien sûr l'essentiel de la discussion ci-dessus est inutile d'un point
de vue logique. Ni Lean ni une rédaction pour experts n'ont besoin
de tous ces discours. Voici la même démonstration sans bavardage.
-/
Example "On suppose que g ∘ f is surjective. Alors g is surjective."
  Given: (f g : ℝ → ℝ)
  Assume: (hyp : (g ∘ f) is surjective)
  Conclusion: g is surjective
Proof:
  Fix y
  Let's prove that ∃ x, g x = y -- Cette ligne est optionnelle mais facilite la lecture
  Since (g ∘ f) is surjective we get w : ℝ such that hw : (g ∘ f) w = y
  Let's prove that f w works
  We conclude by hypothesis
QED

/-
Et on peut passer à la rédaction « sur papier », par exemple :

  Fix y réel. Montrons qu'il existe x réel such that g(x) = y.
  By l'hypothèse de surjectivité de g ∘ f appliquée à y, we get w réel such that
  g ∘ f(w) = y. Le réel f(w) works.
-/

Exercise "03.4"
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is surjective) (hg : g is surjective)
  Conclusion: (g ∘ f) is surjective
Proof:
  sorry
QED

