(*  Exercice à rendre **)
(*  pgcd : int -> int -> int 
    renvoie le pgcd de 2 nombre
    a, b : entier
    précondition : a et b > 0
*)
let pgcd a b = 
  let rec pgcd_abs a_abs b_abs =
    if a_abs == b_abs then 
      a_abs
    else if a_abs > b_abs then 
      pgcd_abs (a_abs-b_abs) b_abs
    else 
      pgcd_abs a_abs (b_abs-a_abs)
    in pgcd_abs (abs a) (abs b)

let%test _ = pgcd 3 3 = 3
let%test _ = pgcd 3 5 = 1
let%test _ = pgcd 10 5 = 5

