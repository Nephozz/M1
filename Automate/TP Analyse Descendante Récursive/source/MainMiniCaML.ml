

fun x -> x + 2

let foo x = if x > 2 then 1 else 2 

let za = foo(- 1) = in (za + 1)





(* 
  LL(1)
  #1 - E0 -> fun ident -> E0
  #2 - E0 -> let ident = E0 in E0
  #3 - E0 -> let rec ident = E0 in E0
  #4 - E0 -> if E0 then E0 else E0
  #22 - E0 -> E
  #5 - E -> ER EX
  #6 - EX -> = ER EX
  #7 - EX ->
  #8 - ER -> T TX 
  #9 - TX -> + T TX
  #10 - TX -> - T TX
  #11 - TX ->
  #12 - T -> F FX
  #13 - FX -> * F FX
  #14 - FX -> / F FX
  #15 - FX ->
  #16 - F -> - F
  #21 - F -> ( E0 )
  #18 - F -> ( E0 ) (E0)
  #19 - F -> ident
  #20 - F -> ident (E0)
  #21 - F -> true
  #22 - F -> false
  #17 - F -> number
*)