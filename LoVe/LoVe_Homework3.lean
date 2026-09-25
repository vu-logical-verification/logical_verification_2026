/- Copyright © 2018–2025 Anne Baanen, Alexander Bentkamp, Jasmin Blanchette,
Johannes Hölzl, and Jannis Limperg. See `LICENSE.txt`. -/

import LoVe.LoVelib

-- You may find it helpful to review the demo files when solving the questions.
-- You are expected to understand the parts of the demos relevant to the homework.

/- # LoVe Homework 3: Inductive Types and Recursors

Replace the placeholders (e.g., `:= sorry`) with your solutions.
-/

set_option autoImplicit false
set_option tactic.hygienic false

namespace LoVe

/- ## Question 1: Inductive Types

Lean allows us to define new types using the `inductive` command.

In Lecture 5, we defined the inductive types `RGB` and `List'`.

Write down the definitions of `RGB` and `List'` exactly as they appear
in Lecture 5.

The definition of `Tree` should be identical to the one used in the
written part of Assignment 3. Its constructors should be called `leaf`
and `node`.
-/

/- 1.1. Define `RGB` exactly as in Lecture 5. -/

inductive RGB : Type where
  -- TODO

/- 1.2. Define `List'` exactly as in Lecture 5. -/

inductive List' (α : Type) : Type where
  -- TODO

/- 1.3. Define `Tree` exactly as in the written part of Assignment 3. -/

inductive Tree (α : Type) : Type where
  -- TODO


/- ## Question 2: Nondependent Recursors

Lean automatically generates a recursor for every inductive type.

In Homework 2, you defined your own recursor for natural numbers:

    def recNat (τ : Type) (e : ℕ) (ez : τ)
        (ebody : ℕ → τ → τ) : τ := ...

In this question, you will similarly define nondependent recursors for
the inductive types from Question 1.

Do not use Lean's automatically generated recursors.
-/

/- 2.1. Define the nondependent recursor for `RGB`.

The values `er`, `eg`, and `eb` specify the result corresponding to
the three constructors of `RGB`.
-/

def recRGB (τ : Type) (e : RGB)
    (er eg eb : τ) : τ :=
  sorry

/- 2.2. Define the nondependent recursor for `List'`.

The value `enil` specifies the result for the empty list.

The function `econs` receives:
* the head of the list;
* the recursively computed result for the tail.
-/

def recList (α τ : Type) (xs : List' α)
    (enil : τ)
    (econs : α → τ → τ) : τ :=
  sorry

/- 2.3. Define the nondependent recursor for `Tree`.

The function `eleaf` receives the value stored in a leaf.

The function `enode` receives:
* the recursively computed result for the left subtree;
* the recursively computed result for the right subtree.
-/

def recTree (α τ : Type) (t : Tree α)
    (eleaf : α → τ)
    (enode : τ → τ → τ) : τ :=
  sorry

/- 2.4. Use `recTree` to construct a function `map` that takes
a function as its first argument and a binary tree as its second argument,
and applies the function to each leaf of the tree, thereby producing
another tree. You MUST use the recursor `recTree`.
-/

def map {τ₁ τ₂ : Type} (f : τ₁ → τ₂) (t : Tree τ₁) : Tree τ₂ :=
  sorry



/- ## Question 3: Indexed Inductive Types

An inductive type may depend on a value.

For example, we can define a type `isEven n` whose inhabitants provide
evidence that the natural number `n` is even.

Notice that `isEven n` should have type `Type`, not `Prop`.

In the next homework, we will switch from using Type to Prop.
-/

/- 3.1. Complete the definition of `isEven`

The definition should have two constructors:
* one giving evidence that `0` is even;
* one giving evidence that `n + 2` is even whenever `n` is even.
-/

inductive isEven : Nat → Type where
  -- TODO

/- 3.2. Construct an inhabitant of `isEven 0`. -/

def isEven0 : isEven 0 :=
  sorry

/- 3.3. Construct an inhabitant of `isEven 4`. -/

def isEven4 : isEven 4 :=
  sorry


end LoVe
