import ProofsWithLean.Lib

macro_rules | `($x ∣ $y)   => `(@Dvd.dvd ℕ Nat.instDvd ($x : ℕ) ($y : ℕ))

addAnonymousGoalSplittingLemma divise_antisym
addAnonymousFactSplittingLemma divise_gcd_si
addAnonymousFactSplittingLemma divise_refl
addAnonymousFactSplittingLemma divise_si_divise_gcd
addAnonymousFactSplittingLemma divise_si_divise_left
addAnonymousFactSplittingLemma divise_si_divise_right

addAnonymousComputeLemma gcd_divise_left
addAnonymousComputeLemma gcd_divise_right

addAnonymousFactSplittingLemma gcd_divise_left
addAnonymousFactSplittingLemma gcd_divise_right
addAnonymousFactSplittingLemma divise_antisym
