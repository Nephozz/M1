open Base

(* A COMPLETER : foncteur Conversion *)
module Conversion (B: Base)= 
struct
  (* decompose : réalise une décomposition dans la base d’un entier supposé naturel*)
  (* int -> int list *)
  (* pré-condition : entier est positif *)
  (* résultat : la décomposition dans la base *)
  let decompose n = 
    let rec calcul_digit acc d = match d with
    | 0 -> acc
    | r -> calcul_digit ((r mod B.base)::acc) (r/B.base)
  in calcul_digit [] n

  (* recompose : réalise la recomposition d'un entien naturel depuis sa représentation dans la base *)
  (* int list -> int *)
  (* L'entier représenté par la liste de booléens *)
  let recompose l =
    let rec puiss x n =
      if n = 0 then 1 else
      if n mod 2 = 0 then puiss (x * x) (n / 2)
      else x * puiss (x * x) (n / 2)
    in List.fold_right (fun h sum -> h + sum)
    (List.mapi(fun i x -> x * (puiss B.base i)) (List.rev l)) 0
end



module TestConversion2 = struct
  module Conversion2 = Conversion (Base2)
  open Conversion2

  let%test_unit _ =
    print_string "=== Tests du module Conversion en Base 2 ===\n"

  (* decompose *)
  let%test _ = decompose 0 = []
  let%test _ = decompose 1 = [ 1 ]
  let%test _ = decompose 2 = [ 1; 0 ]
  let%test _ = decompose 3 = [ 1; 1 ]
  let%test _ = decompose 4 = [ 1; 0; 0 ]
  let%test _ = decompose 5 = [ 1; 0; 1 ]
  let%test _ = decompose 6 = [ 1; 1; 0 ]
  let%test _ = decompose 7 = [ 1; 1; 1 ]
  let%test _ = decompose 14 = [ 1; 1; 1; 0 ]

  (* recompose *)
  let%test _ = recompose [] = 0
  let%test _ = recompose [ 1 ] = 1
  let%test _ = recompose [ 1; 0 ] = 2
  let%test _ = recompose [ 1; 1 ] = 3
  let%test _ = recompose [ 1; 0; 0 ] = 4
  let%test _ = recompose [ 1; 0; 1 ] = 5
  let%test _ = recompose [ 1; 1; 0 ] = 6
  let%test _ = recompose [ 1; 1; 1 ] = 7
  let%test _ = recompose [ 1; 1; 1; 0 ] = 14

end

module TestConversion5 = struct
  module Conversion5 = Conversion (Base5)
  open Conversion5

  let%test_unit _ =
    print_string "=== Tests du module Conversion en Base 5 ===\n"
  
  (* decompose *)
  
  let%test _ = decompose 0 = []
  let%test _ = decompose 1 = [ 1 ]
  let%test _ = decompose 2 = [ 2 ]
  let%test _ = decompose 3 = [ 3 ]
  let%test _ = decompose 4 = [ 4 ]
  let%test _ = decompose 5 = [ 1; 0 ]
  let%test _ = decompose 6 = [ 1; 1 ]
  let%test _ = decompose 7 = [ 1; 2 ]
  let%test _ = decompose 14 = [ 2; 4 ]
  let%test _ = decompose 36 = [ 1; 2; 1 ]

  (* recompose *)

  let%test _ = recompose [] = 0
  let%test _ = recompose [ 1 ] = 1
  let%test _ = recompose [ 2 ] = 2
  let%test _ = recompose [ 3 ] = 3
  let%test _ = recompose [ 4 ] = 4
  let%test _ = recompose [ 1; 0 ] = 5
  let%test _ = recompose [ 1; 1 ] = 6
  let%test _ = recompose [ 1; 2 ] = 7
  let%test _ = recompose [ 2; 4 ] = 14
  let%test _ = recompose [ 1; 2; 1 ] = 36
  
end
