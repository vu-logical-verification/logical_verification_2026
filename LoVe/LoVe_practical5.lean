/- Copyright © 2018–2025 Anne Baanen, Alexander Bentkamp, Jasmin Blanchette,
Johannes Hölzl, and Jannis Limperg. See `LICENSE.txt`. -/

import LoVe.LoVelib

def map {α β : Type} (f : α -> β) : List α -> List β
  | List.nil => List.nil
  | List.cons x xs => (f x) :: map f xs


theorem mapocomp {α β γ : Type} (f : α -> β) (g : β -> gamma) (l : List α) :
  map (g ∘ f) l = map g (map f l) := by
  induction l with
  | nil => simp [map]
  | cons x xs ih => simp [map, ih]

def foldl {α β : Type} (b : β) (f : β -> α -> β)  (l : List α) : β :=
  match l with
  | List.nil => b
  | List.cons x xs => foldl (f b x) f  xs

-- (1,(2,(3,(4,(5 a)))))
def foldr {α β : Type} (f : α -> β -> β) (b : β) (l : List α) : β :=
  match l with
  | List.nil => b
  -- | List.cons x xs => foldr f (f x b) xs
  | List.cons x xs => (f x) (foldr f b xs)

theorem plusfold_aux (l : List ℕ) (a : ℕ) :
    foldl a Nat.add l = a + foldr Nat.add 0 l := by
    induction l generalizing a with
    | nil =>
      simp [foldl, foldr]
    |cons x xs ih =>
      rw [foldl, foldr, ih]
      simp [Nat.add_assoc]


      sorry


theorem plusfold (l : List ℕ) : foldr Nat.add 0 l =  foldl 0 Nat.add l := sorry
