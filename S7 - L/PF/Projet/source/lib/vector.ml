(* définition du type vecteur *)
type vector = float * float

(* (+>) : vecteur -> vecteur -> vecteur 
  addition de deux vecteurs
  Paramètres : v1 : vecteur
               v2 : vecteur
  Résultat : vector *)
let (+>) : vector -> vector -> vector = fun v1 v2 ->
  ((fst v1 +. fst v2), (snd v1 +. snd v2))

(* ( *> ) : float -> vecteur -> vecteur
  multiplication d'un vecteur par un scalaire
  Paramètres : k : float
               v : vecteur
  Résultat : vector *)
let ( *>) : float -> vector -> vector = fun k v ->
  ((fst v *. k), (snd v *. k))

(* (<*>) : vecteur -> vecteur -> float
  produit scalaire de deux vecteurs
  Paramètres : p1 : vecteur
               p2 : vecteur
  Résultat : float *)
let (<*>) : vector -> vector -> float = fun v1 v2 ->
  (fst v1 *. fst v2) +. (snd v1 *. snd v2)