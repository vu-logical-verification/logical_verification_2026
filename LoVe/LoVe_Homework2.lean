/- Copyright © 2018–2025 Anne Baanen, Alexander Bentkamp, Jasmin Blanchette,
Johannes Hölzl, and Jannis Limperg. See `LICENSE.txt`. -/

import LoVe.LoVelib

-- You may find it helpful to review the demo files when solving the questions.
-- You are expected to understand the parts of the demos relevant to the homework.

/- # LoVe Homework 2: Functional Programming and Recursors

Replace the placeholders (e.g., `:= sorry`) with your solutions.
-/

set_option autoImplicit false
set_option tactic.hygienic false

namespace LoVe


/- ## Question 1: Map

Recall that `map f xs` applies the function `f` to every element of the
list `xs`.
-/

/- 1.1. Define `map` recursively on lists. -/

def map {α β : Type} (f : α → β) : List α → List β
  | []      => []
  | x :: xs => sorry

/- 1.2. Prove that mapping the composition of two functions is equivalent
to mapping the first function and then the second function.
-/

theorem map_comp {α β γ : Type} (f : α → β) (g : β → γ) :
    ∀xs : List α,
      map (fun x ↦ g (f x)) xs = map g (map f xs) :=
  sorry


/- ## Question 2: Gauss's Summation Formula

The function `sumUpToOfFun f n` computes the sum

  f 0 + f 1 + ⋯ + f n.
-/

def sumUpToOfFun (f : ℕ → ℕ) : ℕ → ℕ
  | 0     => f 0
  | m + 1 => sumUpToOfFun f m + f (m + 1)

/- 2.1. Prove Gauss's summation formula.

Hints:
* The `mul_add` and `add_mul` theorems might be useful when reasoning
  about multiplication.
* The `linarith` tactic might be useful when reasoning about addition.
-/

#check mul_add
#check add_mul

theorem sumUpToOfFun_eq :
    ∀m : ℕ, 2 * sumUpToOfFun (fun i ↦ i) m = m * (m + 1) :=
  sorry

/- 2.2. Prove that summation distributes over pointwise addition. -/

theorem sumUpToOfFun_add (f g : ℕ → ℕ) :
    ∀n : ℕ,
      sumUpToOfFun (fun i ↦ f i + g i) n =
        sumUpToOfFun f n + sumUpToOfFun g n :=
  sorry


/- ## Question 3: Recursion on Natural Numbers

Lean automatically generates a recursor for every inductive type.

In this question, we will define our own recursor for natural numbers
and use recursors to implement several functions.
-/

/- 3.1. Complete the definition of `recNat`, corresponding to the
natural number recursor from the lectures. Do not use the built-in recursor `Nat.rec`.

The function takes:
* A result type `τ`.
* A natural number `e`.
* A base-case value `ez`.
* A step function `ebody`.
-/

def recNat (τ : Type) (e : ℕ) (ez : τ)
    (ebody : ℕ → τ → τ) : τ :=
  sorry

/- 3.2. Use your `recNat` function to define `double`, which doubles
a natural number.

You may not use arithmetic operators such as `+` or `*`.
You may use the constructors of `Nat`, such as `Nat.succ`.
-/

def double (x : ℕ) : ℕ :=
  sorry

-- Test your implementation:
-- #eval double 0
-- #eval double 10
-- #eval double 20
-- #eval double 30

/- 3.3. Use your `recNat` function to define
`dec`, which subtracts one from a natural number.

The function should satisfy:
* dec 0 = 0
* dec 9 = 8
* dec 10 = 9

You may not use arithmetic operators such as `+` or `*`.
You may use the constructors of `Nat`, such as `Nat.succ`.
-/

def dec (x : ℕ) : ℕ :=
  sorry

-- Test your implementation:
-- #eval dec 0
-- #eval dec 10
-- #eval dec 20
-- #eval dec 30

/- 3.4. Use your `recNat` (and `dec` if you want to) to define subtraction
on natural numbers.

The function `sub a b` should subtract `b` from `a`. Since we are
working with natural numbers, subtraction should return zero whenever
`b` is greater than `a`.

For example:
* sub 10 3 = 7
* sub 5 5 = 0
* sub 3 10 = 0

You may not use arithmetic operators such as `+`, `-`, or `*`.
-/

def sub (a b : ℕ) : ℕ :=
  sorry

-- Test your implementation:
-- #eval sub 10 3
-- #eval sub 5 5
-- #eval sub 3 10
-- #eval sub 20 0



/- ## Question 4: Sets

One approach to implementing extensional sets in proof assistants is
to maintain a strict order on their elements.

A set is extensional if two sets are equal exactly when they contain
the same elements.

We will represent finite sets of natural numbers using a comparison
function and an inductive type.
-/

/- ### Comparisons

We use the following comparison type and functions instead of the
ordinary `<` operator, since our set representation uses `Option ℕ`.
-/

inductive Comparison : Type
  | lt : Comparison
  | eq : Comparison
  | gt : Comparison

open Comparison

def compare_nat : ℕ → ℕ → Comparison
  | Nat.zero,   Nat.zero   => eq
  | Nat.zero,   Nat.succ _ => lt
  | Nat.succ _, Nat.zero   => gt
  | Nat.succ a, Nat.succ b => compare_nat a b

/- An `Option α` is either `none` or `some a` for a value `a : α`.

For reference:

inductive Option (α : Type) : Type
  | none : Option α
  | some : α → Option α
-/

def compare : Option ℕ → Option ℕ → Comparison
  | none,   none   => eq
  | none,   some _ => gt
  | some _, none   => lt
  | some a, some b => compare_nat a b

/- The following lemma may be useful in your proofs. -/

lemma compare_nat_compares (a b : ℕ) :
    compare_nat a b = lt ↔ a < b := by
  induction a generalizing b with
  | zero =>
      cases b with
      | zero =>
          simp [compare_nat]
      | succ b' =>
          simp [compare_nat]
  | succ a ih =>
      cases b with
      | zero =>
          simp [compare_nat]
      | succ b' =>
          simp [compare_nat]
          rw [ih b']


/- ### Set Representation

A term of type `SetAbove (some a)` represents a nonempty set whose
smallest element is `a`.

A term of type `SetAbove none` represents the empty set.

For example:

  ∅       : SetAbove none
  {1,2,3} : SetAbove (some 1)

The definition of `SetAbove` resembles the definition of a list.

Like `List.cons`, the constructor `scons` takes a new element `a` and
an existing set.

Unlike `List.cons`, it also requires a proof that `a` is strictly
smaller than the smallest element of the existing set.

This ordering ensures that elements cannot occur more than once.
-/

inductive SetAbove : Option ℕ → Type
  | snil : SetAbove none
  | scons (a : ℕ) (k : Option ℕ) :
      compare (some a) k = lt →
      SetAbove k →
      SetAbove (some a)


/- 4.1. Complete the definition of `empty`, which represents the
empty set.
-/

def empty : SetAbove none :=
  sorry

/- 4.2. Complete the definition of `singleton`.

For every natural number `a`, `singleton a` should represent the set
containing only `a`.
-/

def singleton (a : ℕ) : SetAbove (some a) :=
  sorry

/- 4.3. Complete the definition of `mem`.

The function should return `true` exactly when `a` is a member of
the given set.
-/

def mem (a : ℕ) {k : Option ℕ} : SetAbove k → Bool :=
  sorry

/- 4.4. Prove that an element strictly smaller than the smallest
element of a set cannot belong to that set.

Hint: The lemma `compare_nat_compares` may be useful.
-/

#check compare_nat_compares

lemma mem_lt_key_false (a : ℕ) (k : Option ℕ) (m : SetAbove k) :
    compare (some a) k = lt →
    mem a m = false :=
  sorry

end LoVe
