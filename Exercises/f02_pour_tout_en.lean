import ProofsWithLean.Lib_en
setup_env

/-
# Feuille 2 : Quantificateur universel
-/

/-
On rappelle que `f is evene` signifie `∀ x, f (-x) = f x` and
`f is odde` signifie `∀ x, f (-x) = -f x`.

Dans l’exemple suivant, on démontre un énoncé de la forme `∀ x, P x` using
la commande `Fix`.
-/

Example "La fonction qui envoie x sur x² is evene."
  Given:
  Assume:
  Conclusion: (fct x ↦ x^2) is evene
Proof:
  Fix x : ℝ
  Let's prove that (-x)^2 = x^2
  We compute
QED

Exercise "02.1 La fonction qui envoie `x` sur `x³` is odde."
  Given:
  Assume:
  Conclusion: (fct x ↦ x^3) is odde
Proof:
  sorry
QED

/-
Dans les exemples suivants, on utilise un énoncé débutant par un quantificateur universel
au moyen des commandes `Since … on conclut …` or `Comme … we get …` selon qu’on obtient
directement la conclusion voulue or que l’on souhaite obtenir un fait intermédiaire.
-/

Example "Spécialisation d’une hypothèse de parité pour conclure."
  Given: (f : ℝ → ℝ)
  Assume: (hf : f is evene)
  Conclusion: f (-5) = f 5
Proof:
  Since f is evene we conclude that f (-5) = f 5
QED

Example "Spécialisation d’une hypothèse de parité to créant un fait intermédiaire."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is evene)
  Conclusion: g (f (-5)) = g (f 5)
Proof:
  Since f is evene we get hf5 : f (-5) = f 5
  Since f (-5) = f 5 we conclude that g (f (-5)) = g (f 5)
QED

Exercise "02.2 Spécialisation d’une hypothèse d’imparité."
  Given: (f : ℝ → ℝ)
  Assume: (hf : f is odde)
  Conclusion: f (-3) = -f 3
Proof:
  sorry
QED

/-
Voyons maintenant un exemple qui démontre un énoncé quantifié using
deux hypothèses quantifiées.
Dans cet exemple, on nomme `x₀` le nombre réel introduit par la
commande `Fix` pour insister sur le fait qu’il est fixé and bien voir
qu’après la ligne `Since f is evene we get hfx₀ : f (-x₀) = f x₀`, la nouvelle
hypothèse `hfx₀` ne porte que sur ce seul nombre.

On notera aussi que la justification `by computation`, destinée aux étapes
n’utilisant pas d’hypothèse, s’occupe de la définition
de l’addition de fonctions. De même, dans des exercices suivants, elle s’occupera
de celle de la composition de fonctions.
-/

Example "Si f and g sont paires alors leur somme l’est aussi."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is evene) (hg : g is evene)
  Conclusion: (f + g) is evene
Proof:
  Let's prove that ∀ x, (f + g) (-x) = (f + g) x
  Fix x₀ : ℝ
  Since f is evene we get hf₀ : f (-x₀) = f x₀
  Since g is evene we get hg₀ : g (-x₀) = g x₀
  Calc
    (f + g) (-x₀) = f (-x₀) + g (-x₀) by computation
    _             = f x₀ + g (-x₀)    since f (-x₀) = f x₀
    _             = f x₀ + g x₀       since g (-x₀) = g x₀
    _             = (f + g) x₀        by computation
QED

/-
Dans la démonstration précédente, la ligne commençant par "Let's prove that"
est purement psychologique, Lean n’en a pas besoin du tout.

Enfin Lean n’a pas vraiment besoin qu’on lui dise à quel réel appliquer
les hypothèses de parité, il lui suffit de chercher dans l’égalité à justifier
donc les lignes de spécialisation sont inutiles.

On peut donc aussi utiliser la version ci-dessous.
-/

Example "Si f and g sont paires alors leur somme l’est aussi, avec une démonstration concise."
  Given: (f g : ℝ → ℝ)
  Assume:(hf : f is evene) (hg : g is evene)
  Conclusion: (f + g) is evene
Proof:
  Fix x₀
  Calc
    (f + g) (-x₀) = f (-x₀) + g (-x₀) by computation
    _             = f x₀ + g (-x₀)    since f is evene
    _             = f x₀ + g x₀       since g is evene
    _             = (f + g) x₀        by computation
QED

Exercise "02.3 Précomposer par une fonction paire donne une fonction paire."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is evene)
  Conclusion: (g ∘ f) is evene
Proof:
  sorry
QED

Exercise "02.4 La composée de deux fonctions impaires is odde."
  Given: (f g : ℝ → ℝ)
  Assume: (hf : f is odde) (hg : g is odde)
  Conclusion: (g ∘ f) is odde
Proof:
  sorry
QED

