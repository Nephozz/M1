open Base
open Liste

(*
Les fonctions suivant ont des tests qui ratent :

- conforme 
- ajouter
*)

(* A COMPLETER : foncteur Arbre*)
module Arbre (B: Base) =
struct
  (* Ensemble d'entier naturel encodé par des arbres utilisant la décomposition en base B des entiers naturels. *)
  type arbre = Noeud of bool * arbre list | Vide

  (* conforme : arbre -> bool *)
  (* Vérifie qu'un arbre est conforme c'est-à-dire que tous les noeuds ont exactement b fils où b est la base de décomposition des entiers *)
  let rec conforme arbre = match arbre with
  | Vide -> false
  | Noeud(true, f) -> (List.length f) = B.base 
    && (List.for_all (fun x -> x = Vide) f)
  | Noeud(_, la) -> if List.length la = B.base 
    then List.for_all (fun x -> x) (List.map conforme la)
    else false

  (* appartient : int list -> arbre -> bool *)
  (* Teste l'appartenance d'un entier, décomposé en base B, à un ensemble d'entiers codé avec un arbre *)
  (* L'ensemble de départ et l'ensemble d'arrivée sont conformes à la base *)
  let rec appartient ld (Noeud(b, la)) = match ld with
  | [] -> b
  | d::tld -> if Liste.get d la = Vide then false
    else appartient tld (Liste.get d la)

  (* ajouter : int list -> arbre -> arbre *)
  (* Ajoute un entier, décomposé en base B, à un ensemble d'entier codé avec un arbre *)
  (* L'ensemble de départ et l'ensemble d'arrivée sont conformes à la base *)

  let rec ajouter ld (Noeud(b, la))= match ld with
  | [] -> Noeud(true, Liste.l_taille B.base Vide)
  | d::tld -> let ca = get d la in
    if ca = Vide 
    then Noeud(b, set d la (ajouter tld (Noeud(false, l_taille B.base Vide))))
    else Noeud(b, set d la (ajouter tld ca))
  
  (* retirer : int list -> arbre -> arbre *)
  (* Retire un entier, décomposé en base B, d'un ensemble d'entier avec normalisation de l'ensemble, c'est-à-dire en coupant les branches mortes *)
  (* L'ensemble de départ et l'ensemble d'arrivée sont conformes à la base *)
  (*
  let retirer ld (Noeud(b, la)) = match ld with
  | [] -> (Noeud(b, la))
  | d::tld -> let ca = get d la in
    if ca = Vide 
    then Noeud(b, la)
    else Noeud(b, set d la Vide)
  *)
  end

(*    la = arbre list d = int         *)

module TestArbre2 = struct
  module Arbre2 = Arbre (Base2)
  open Arbre2

  let%test_unit _ = print_string "=== Tests du module Arbre en Base 2 ===\n"

  let arbre_0_base2 = Noeud (true, [ Vide; Vide ])

  let arbre_3_base2 =
    Noeud
      (false, [ Vide; Noeud (false, [ Vide; Noeud (true, [ Vide; Vide ]) ]) ])

  let arbre_0_base2_KO = Noeud (true, [ Vide; Vide; Vide; Vide ])

  let arbre_0_14_base2 =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( false,
              [
                Vide;
                Noeud
                  ( false,
                    [
                      Vide; Noeud (false, [ Noeud (true, [ Vide; Vide ]); Vide ]);
                    ] );
              ] );
        ] )

  let arbre_0_7_14_base2 =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( false,
              [
                Vide;
                Noeud
                  ( false,
                    [
                      Vide; Noeud (true, [ Noeud (true, [ Vide; Vide ]); Vide ]);
                    ] );
              ] );
        ] )

  let arbre_0_1_7_14_base2 =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( true,
              [
                Vide;
                Noeud
                  ( false,
                    [
                      Vide; Noeud (true, [ Noeud (true, [ Vide; Vide ]); Vide ]);
                    ] );
              ] );
        ] )

  let arbre_0_1_7_14_36_base2 =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( true,
              [
                Noeud
                  ( false,
                    [
                      Noeud
                        ( false,
                          [
                            Vide;
                            Noeud
                              ( false,
                                [
                                  Noeud
                                    ( false,
                                      [ Noeud (true, [ Vide; Vide ]); Vide ] );
                                  Vide;
                                ] );
                          ] );
                      Vide;
                    ] );
                Noeud
                  ( false,
                    [
                      Vide; Noeud (true, [ Noeud (true, [ Vide; Vide ]); Vide ]);
                    ] );
              ] );
        ] )

  let arbre_0_1_4_7_14_36_base2 =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( true,
              [
                Noeud
                  ( false,
                    [
                      Noeud
                        ( true,
                          [
                            Vide;
                            Noeud
                              ( false,
                                [
                                  Noeud
                                    ( false,
                                      [ Noeud (true, [ Vide; Vide ]); Vide ] );
                                  Vide;
                                ] );
                          ] );
                      Vide;
                    ] );
                Noeud
                  ( false,
                    [
                      Vide; Noeud (true, [ Noeud (true, [ Vide; Vide ]); Vide ]);
                    ] );
              ] );
        ] )

  let arbre_0_1_4_7_14_36_base2_KO =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( true,
              [
                Noeud
                  ( false,
                    [
                      Noeud
                        ( true,
                          [
                            Vide;
                            Noeud
                              ( false,
                                [
                                  Noeud
                                    ( false,
                                      [ Noeud (true, [ Vide; Vide ]); Vide ] );
                                  Vide;
                                ] );
                          ] );
                      Vide;
                    ] );
                Noeud
                  ( false,
                    [
                      Vide;
                      Noeud (true, [ Noeud (true, [ Vide; Vide ]); Vide; Vide ]);
                    ] );
              ] );
        ] )

  (* Conforme *)
  
  let%test _ = conforme arbre_0_base2
  let%test _ = conforme arbre_0_14_base2
  let%test _ = conforme arbre_0_7_14_base2
  let%test _ = conforme arbre_0_1_7_14_base2
  let%test _ = conforme arbre_0_1_7_14_36_base2
  let%test _ = conforme arbre_0_1_4_7_14_36_base2
  let%test _ = not (conforme arbre_0_1_4_7_14_36_base2_KO)
  let%test _ = not (conforme arbre_0_base2_KO)
  
  (* Appartient *)
  
  let%test _ = appartient [] (*0*) arbre_0_1_4_7_14_36_base2
  let%test _ = appartient [ 1 ] (*1*) arbre_0_1_4_7_14_36_base2
  let%test _ = appartient [ 1; 0; 0 ] (*4*) arbre_0_1_4_7_14_36_base2
  let%test _ = appartient [ 1; 1; 1 ] (*7*) arbre_0_1_4_7_14_36_base2
  let%test _ = appartient [ 1; 1; 1; 0 ] (*14*) arbre_0_1_4_7_14_36_base2
  let%test _ = appartient [ 1; 0; 0; 1; 0; 0 ] (*36*) arbre_0_1_4_7_14_36_base2
  let%test _ = not (appartient [ 1; 0 ] (*2*) arbre_0_1_4_7_14_36_base2)
  let%test _ = not (appartient [ 1; 1 ] (*3*) arbre_0_1_4_7_14_36_base2)
  let%test _ = not (appartient [ 1; 0; 1 ] (*5*) arbre_0_1_4_7_14_36_base2)
  let%test _ = not (appartient [ 1; 0; 1; 1 ] (*11*) arbre_0_1_4_7_14_36_base2)

  let%test _ =
    not (appartient [ 1; 0; 0; 1; 0; 1 ] (*37*) arbre_0_1_4_7_14_36_base2)


  (* ajouter *)
  
  let%test _ = ajouter [] (*0*) Vide = arbre_0_base2
  let%test _ = ajouter [ 1; 1; 1; 0 ] (*14*) arbre_0_base2 = arbre_0_14_base2
  let%test _ = ajouter [ 1; 1; 1 ] (*7*) arbre_0_14_base2 = arbre_0_7_14_base2
  let%test _ = ajouter [ 1 ] (*1*) arbre_0_7_14_base2 = arbre_0_1_7_14_base2

  let%test _ =
    ajouter [ 1; 0; 0; 1; 0; 0 ] (*36*) arbre_0_1_7_14_base2
    = arbre_0_1_7_14_36_base2

  let%test _ =
    ajouter [ 1; 0; 0 ] (*4*) arbre_0_1_7_14_36_base2
    = arbre_0_1_4_7_14_36_base2
  

  (* retirer *)
  (*
  let%test _ =
    retirer [ 1; 0; 0 ] (*4*) arbre_0_1_4_7_14_36_base2
    = arbre_0_1_7_14_36_base2

  let%test _ =
    retirer [ 1; 0; 0; 1; 0; 0 ] (*36*) arbre_0_1_7_14_36_base2
    = arbre_0_1_7_14_base2

  let%test _ = retirer [ 1 ] (*1*) arbre_0_1_7_14_base2 = arbre_0_7_14_base2
  let%test _ = retirer [ 1; 1; 1 ] (*7*) arbre_0_7_14_base2 = arbre_0_14_base2
  let%test _ = retirer [ 1; 1; 1; 0 ] (*14*) arbre_0_14_base2 = arbre_0_base2
  let%test _ = retirer [] (*0*) arbre_0_base2 = Vide
  let%test _ = retirer [ 1; 1 ] (*3*) arbre_3_base2 = Vide
  *)
end

module TestArbre5 = struct
  module Arbre5 = Arbre (Base5)
  open Arbre5

  let%test_unit _ = print_string "=== Tests du module Arbre en Base 5 ===\n"

  let arbre_0_base5 = Noeud (true, [ Vide; Vide; Vide; Vide; Vide ])
  let arbre_0_base5_KO = Noeud (true, [ Vide; Vide; Vide; Vide ])

  let arbre_0_14_base5 =
    Noeud
      ( true,
        [
          Vide;
          Vide;
          Noeud
            ( false,
              [
                Vide;
                Vide;
                Vide;
                Vide;
                Noeud (true, [ Vide; Vide; Vide; Vide; Vide ]);
              ] );
          Vide;
          Vide;
        ] )

  let arbre_0_7_14_base5 =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( false,
              [
                Vide;
                Vide;
                Noeud (true, [ Vide; Vide; Vide; Vide; Vide ]);
                Vide;
                Vide;
              ] );
          Noeud
            ( false,
              [
                Vide;
                Vide;
                Vide;
                Vide;
                Noeud (true, [ Vide; Vide; Vide; Vide; Vide ]);
              ] );
          Vide;
          Vide;
        ] )

  let arbre_0_1_7_14_base5 =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( true,
              [
                Vide;
                Vide;
                Noeud (true, [ Vide; Vide; Vide; Vide; Vide ]);
                Vide;
                Vide;
              ] );
          Noeud
            ( false,
              [
                Vide;
                Vide;
                Vide;
                Vide;
                Noeud (true, [ Vide; Vide; Vide; Vide; Vide ]);
              ] );
          Vide;
          Vide;
        ] )

  let arbre_0_1_7_14_36_base5 =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( true,
              [
                Vide;
                Vide;
                Noeud
                  ( true,
                    [
                      Vide;
                      Noeud (true, [ Vide; Vide; Vide; Vide; Vide ]);
                      Vide;
                      Vide;
                      Vide;
                    ] );
                Vide;
                Vide;
              ] );
          Noeud
            ( false,
              [
                Vide;
                Vide;
                Vide;
                Vide;
                Noeud (true, [ Vide; Vide; Vide; Vide; Vide ]);
              ] );
          Vide;
          Vide;
        ] )

  let arbre_0_1_4_7_14_36_base5 =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( true,
              [
                Vide;
                Vide;
                Noeud
                  ( true,
                    [
                      Vide;
                      Noeud (true, [ Vide; Vide; Vide; Vide; Vide ]);
                      Vide;
                      Vide;
                      Vide;
                    ] );
                Vide;
                Vide;
              ] );
          Noeud
            ( false,
              [
                Vide;
                Vide;
                Vide;
                Vide;
                Noeud (true, [ Vide; Vide; Vide; Vide; Vide ]);
              ] );
          Vide;
          Noeud (true, [ Vide; Vide; Vide; Vide; Vide ]);
        ] )

  let arbre_0_1_4_7_14_36_base5_KO =
    Noeud
      ( true,
        [
          Vide;
          Noeud
            ( true,
              [
                Noeud
                  ( false,
                    [
                      Noeud
                        ( true,
                          [
                            Vide;
                            Noeud
                              ( false,
                                [
                                  Noeud
                                    ( false,
                                      [ Noeud (true, [ Vide; Vide ]); Vide ] );
                                  Vide;
                                ] );
                          ] );
                      Vide;
                    ] );
                Noeud
                  ( false,
                    [
                      Vide;
                      Noeud (true, [ Noeud (true, [ Vide; Vide ]); Vide; Vide ]);
                    ] );
              ] );
        ] )

  (* Conforme *)
  (*
  let%test _ = conforme arbre_0_base5
  let%test _ = conforme arbre_0_14_base5
  let%test _ = conforme arbre_0_7_14_base5
  let%test _ = conforme arbre_0_1_7_14_base5
  let%test _ = conforme arbre_0_1_7_14_36_base5
  let%test _ = conforme arbre_0_1_4_7_14_36_base5
  let%test _ = not (conforme arbre_0_1_4_7_14_36_base5_KO)
  let%test _ = not (conforme arbre_0_base5_KO)
  *)

  (* Appartient *)
  (*
  let%test _ = appartient [] (*0*) arbre_0_1_4_7_14_36_base5
  let%test _ = appartient [ 1 ] (*1*) arbre_0_1_4_7_14_36_base5
  let%test _ = appartient [ 4 ] (*4*) arbre_0_1_4_7_14_36_base5
  let%test _ = appartient [ 1; 2 ] (*7*) arbre_0_1_4_7_14_36_base5
  let%test _ = appartient [ 2; 4 ] (*14*) arbre_0_1_4_7_14_36_base5
  let%test _ = appartient [ 1; 2; 1 ] (*36*) arbre_0_1_4_7_14_36_base5
  let%test _ = not (appartient [ 2 ] (*2*) arbre_0_1_4_7_14_36_base5)
  let%test _ = not (appartient [ 3 ] (*3*) arbre_0_1_4_7_14_36_base5)
  let%test _ = not (appartient [ 1; 0 ] (*5*) arbre_0_1_4_7_14_36_base5)
  let%test _ = not (appartient [ 2; 1 ] (*11*) arbre_0_1_4_7_14_36_base5)
  let%test _ = not (appartient [ 1; 2; 2 ] (*37*) arbre_0_1_4_7_14_36_base5)
  *)

  (* ajouter *)
  (*
  let%test _ = ajouter [] (*0*) Vide = arbre_0_base5
  let%test _ = ajouter [ 2; 4 ] (*14*) arbre_0_base5 = arbre_0_14_base5
  let%test _ = ajouter [ 1; 2 ] (*7*) arbre_0_14_base5 = arbre_0_7_14_base5
  let%test _ = ajouter [ 1 ] (*1*) arbre_0_7_14_base5 = arbre_0_1_7_14_base5

  let%test _ =
    ajouter [ 1; 2; 1 ] (*36*) arbre_0_1_7_14_base5 = arbre_0_1_7_14_36_base5

  let%test _ =
    ajouter [ 4 ] (*4*) arbre_0_1_7_14_36_base5 = arbre_0_1_4_7_14_36_base5
  *)

  (* retirer *)
  (*
  let%test _ =
    retirer [ 4 ] (*4*) arbre_0_1_4_7_14_36_base5 = arbre_0_1_7_14_36_base5

  let%test _ =
    retirer [ 1; 2; 1 ] (*36*) arbre_0_1_7_14_36_base5 = arbre_0_1_7_14_base5

  let%test _ = retirer [ 1 ] (*1*) arbre_0_1_7_14_base5 = arbre_0_7_14_base5
  let%test _ = retirer [ 1; 2 ] (*7*) arbre_0_7_14_base5 = arbre_0_14_base5
  let%test _ = retirer [ 2; 4 ] (*14*) arbre_0_14_base5 = arbre_0_base5
  let%test _ = retirer [] (*0*) arbre_0_base5 = Vide
  *)
end
