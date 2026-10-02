/- Copyright © 2018–2025 Anne Baanen, Alexander Bentkamp, Jasmin Blanchette,
Johannes Hölzl, and Jannis Limperg. See `LICENSE.txt`. -/

import LoVe.LoVelib

set_option autoImplicit false
set_option tactic.hygienic false

namespace LoVe


/-!
## Question 1: Natural-Number Induction

For every inductive type `T`, Lean automatically generates an inductor
`T.rec`. It takes a motive, one case for each constructor, and a value to
induct on.

For `Nat`, the constructors are `zero` and `succ`. Implement the following
induction principle yourself.

The arguments are:

* `motive` — the property to prove for each natural number;
* `ezero` — the proof for `0`;
* `esucc` — the proof for `n + 1`, assuming the property holds for `n`;
* `n` — the natural number to induct on.
-/

def indNat
    (motive : Nat → Prop)
    (ezero : motive 0)
    (esucc : (n : Nat) → motive n → motive (n + 1))
    (n : Nat) : motive n :=
  sorry


/-!
### Q1.1: Congruence of Equality

Prove that applying the same function to equal arguments preserves equality.

Do not use the library theorem `congrArg`.

You may find this theorem useful in the next two questions.
-/

theorem Eq_congrArg {α β : Type} (f : α → β) {a b : α}
    (hab : a = b) :
    f a = f b :=
  sorry


/-!
### Q1.2: Induction Using `indNat`

Use your `indNat` function to prove that adding zero on the left does not
change a natural number.

Your proof must use `indNat`. Do not use the `induction` tactic or the
library theorem `Nat.zero_add`.

Hint: In the successor case, you may find `Eq_congrArg` useful.
-/

theorem zero_add_indNat (n : Nat) :
    0 + n = n :=
  sorry


/-!
### Q1.3: Induction Using `Nat.rec`

Prove the same property again, this time using Lean's built-in `@Nat.rec`
directly.

The `@` makes all arguments explicit, including arguments that Lean would
normally infer.

Do not use the `induction` tactic or the library theorem `Nat.zero_add`.

Compare the arguments of `Nat.rec` with those of your `indNat`.
-/

theorem zero_add_Nat_rec (n : Nat) :
    0 + n = n :=
  sorry


/-!
## Question 2: Equality and Induction

For an indexed inductive type, the motive of its inductor may depend on the
indices as well as on the inductive proof itself.

We now define our own equality predicate `MyEq`.
-/

set_option inductive.autoPromoteIndices false

inductive MyEq {α : Type} : α → α → Prop where
  | refl : (a : α) → MyEq a a


/-!
### Q2.1: An Inductor for `MyEq`

Implement the inductor for `MyEq`.

The arguments are:

* `motive` — the property to prove about a proof of `MyEq a b`;
* `erefl` — the case corresponding to the `refl` constructor;
* `a`, `b` — the indices;
* `heq` — the proof to induct on.

Do not use `MyEq.rec`.
-/

def indEq {α : Type}
    (motive : (a : α) → (b : α) → MyEq a b → Prop)
    (erefl : (a : α) → motive a a (MyEq.refl a))
    (a : α) (b : α) (heq : MyEq a b) :
    motive a b heq :=
  sorry


/-!
### Q2.2: Transitivity Using `indEq`

Prove transitivity of `MyEq` using your `indEq` function.
-/

theorem MyEq_trans {α : Type} (a b c : α)
    (hab : MyEq a b) (hbc : MyEq b c) :
    MyEq a c :=
  sorry


/-!
### Q2.3: Transitivity Using `Eq.rec`

Prove transitivity of Lean's built-in equality using the built-in `@Eq.rec`.

Do not use tactics.
-/

theorem Eq_trans_rec {α : Type} (a b c : α)
    (hab : a = b) (hbc : b = c) :
    a = c :=
  sorry


/-!
## Question 3: Generalized Induction

The following function reverses a list using an accumulator.
-/

def revAcc {α : Type} : List α → List α → List α
  | [],      acc => acc
  | x :: xs, acc => revAcc xs (x :: acc)


/-!
### Q3.1: Generalizing the Accumulator

Prove the theorem below.

Your proof must proceed by induction on `l`.

A direct induction on `l` would fix `acc` too early. In the inductive case,
the accumulator changes from `acc` to `x :: acc`, so the induction hypothesis
must hold for an arbitrary accumulator.

Your induction should begin with

    induction l generalizing acc with

There will be at least one question about generalized induction on the quiz.
-/

theorem revAcc_revAcc {α : Type} (l acc : List α) :
    revAcc (revAcc l acc) [] = revAcc acc l := by
  sorry


end LoVe
