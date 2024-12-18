namespace Nats

inductive Nat where
  | O : Nat
  | S : Nat → Nat

open Nat

def fromNat : Nat -> String
  | O   => "0"
  | S O => "S 0"
  | S n => "S (" ++ fromNat n ++ ")"

instance : Repr Nat where
  reprPrec
    | n, _  => Std.Format.text (fromNat n)

---------------------------------------------Defs---------------------------------------------

def add : Nat → Nat → Nat
  | n, O   => n
  | n, S m => S (add n m)
/- #eval add (S O) O -/
/- #eval add (S (S O)) (S O) -/

def mul : Nat → Nat → Nat
  | _, O => O
  | n, S m => add n (mul n m)
/- #eval mul (S (S O)) (O) -/
/- #eval mul (S O) (S (S (S O))) -/
/- #eval mul (S (S (S O))) (S (S O)) -/

def exp : Nat → Nat → Nat
  | _, O => S O
  | n, S m => mul n (exp n m)
/- #eval exp (S (S (S O))) (S O) -/
/- #eval exp (S (S (S (S O)))) O -/
/- #eval exp (S (S (S O))) (S (S (S (S O)))) -/
/- #eval exp (S O) (S (S (S (S O)))) -/


def fib : Nat → Nat
  | O => S O
  | S O => S O
  | S (S n) => add (fib (S n)) (fib n)
/- #eval fib O -/
/- #eval fib (S O) -/
/- #eval fib (S (S O)) -/
/- #eval fib (S (S (S O))) -/
/- #eval fib (S (S (S (S O)))) -/
/- #eval fib (S (S (S (S (S O))))) -/

def fact : Nat → Nat
  | O => S O
  | S O => S O
  | S n => mul (S n) (fact n)
/- #eval fact O -/
/- #eval fact (S O) -/
/- #eval fact (S (S O)) -/
/- #eval fact (S (S (S O))) -/
/- #eval fact (S (S (S (S O)))) -/
/- #eval fact (S (S (S (S (S O))))) -/

def min : Nat → Nat → Nat
  | _, O => O
  | O, _ => O
  | (S n), (S m) => S (min n m)
/- #eval min (S (S O)) O -/
/- #eval min (S O) (S (S O)) -/

def max : Nat → Nat → Nat
  | n, O => n
  | O, n => n
  | (S n), (S m) => S (max n m)
/- #eval max (S (S O)) O -/
/- #eval max (S O) (S (S O)) -/

-----------------------------------------Demons---------------------------------------------

/- -- Exemplo : -/
/- theorem add_zero : -/
/-   ∃ (e : Nat), ∀ (n : Nat), add n e = n := -/
/- by -/
/-   exists O -/
/-   intro n -/
/-   rw [add] -/
/- theorem mul_one : -/
/-   ∃ (e : Nat), ∀ (n : Nat), mul n e = n := -/
/- by -/
/-   exists S O  -/
/-   intro n -/
/-   rw [mul, mul, add] -/
/- theorem exp_one : -/
/-   ∃ (e : Nat), ∀ (n : Nat), exp n e = n := -/
/- by -/
/-   exists S O -/
/-   intro n -/
/-   rw [exp, exp, mul_one n ] -/
/- theorem coisa_estranha: -/
/-   ∃ (e : Nat), ∀ (n : Nat), max n e = n ∧  max e n = n := -/
/- by -/
/-   exists O -/
/-   intro n -/
/-   apply And.intro -/
/-   · rw [max] -/
/-   · rw [max] -/

theorem add_zero :
  ∀ (n : Nat), add n O = n :=
by
  intro n
  rw [add]

theorem mul_one :
   ∀ (n : Nat), mul n (S O) = n :=
by
  intro n
  rw [mul, mul, add]

theorem exp_one :
  ∀ (n : Nat), exp n (S O) = n :=
by
  intro n
  rw [exp, exp, mul_one n ]
