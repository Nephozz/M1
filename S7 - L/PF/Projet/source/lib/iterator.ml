(* interface des itérateurs (implémentée par les flux) *)
module type Intf = sig
  type 'a t

  val vide : 'a t
  val cons : 'a -> 'a t -> 'a t
  val unfold : ('s -> ('a * 's) option) -> 's -> 'a t
  val filter : ('a -> bool) -> 'a t -> 'a t
  val append : 'a t -> 'a t -> 'a t
  val constant : 'a -> 'a t
  val map : ('a -> 'b) -> 'a t -> 'b t
  val uncons : 'a t -> ('a * 'a t) option
  val apply : ('a -> 'b) t -> 'a t -> 'b t
  val map2 : ('a -> 'b -> 'c) -> 'a t -> 'b t -> 'c t
  val map3 : ('a -> 'b -> 'c -> 'd) -> 'a t -> 'b t -> 'c t -> 'd t
end

type 'a flux = Tick of ('a * 'a flux) option Lazy.t

module Flux : Intf with type 'a t = 'a flux = struct
  type 'a t = 'a flux = Tick of ('a * 'a t) option Lazy.t

  let vide = Tick (lazy None)
  let cons t q = Tick (lazy (Some (t, q)))
  let uncons (Tick (lazy flux)) = flux

  let rec apply f x =
    Tick
      (lazy
        (match uncons f, uncons x with
         | None, _ -> None
         | _, None -> None
         | Some (tf, qf), Some (tx, qx) -> Some (tf tx, apply qf qx)))

  let rec unfold f e =
    Tick
      (lazy
        (match f e with
         | None -> None
         | Some (t, e') -> Some (t, unfold f e')))

  let rec filter p flux =
    Tick
      (lazy
        (match uncons flux with
         | None -> None
         | Some (t, q) -> if p t then Some (t, filter p q) else uncons (filter p q)))

  let rec append flux1 flux2 =
    Tick
      (lazy
        (match uncons flux1 with
         | None -> uncons flux2
         | Some (t1, q1) -> Some (t1, append q1 flux2)))

  let constant c = unfold (fun () -> Some (c, ())) ()

  (* implantation rapide mais inefficace de map *)
  let map f i = apply (constant f) i
  let map2 f i1 i2 = apply (apply (constant f) i1) i2
  let map3 f i1 i2 i3 = apply (apply (apply (constant f) i1) i2) i3
end

(* integre : float -> (float * float) Flux.t
   Intègre/somme les valeurs successives du flux avec un pas de temps dt
   et une valeur initiale nulle,
   acc_0 = 0; acc_{i+1} = acc_{i} + dt * flux_{i} 
   Paramètres :
     - dt : float, le pas de temps
     - flux : (float * float) Flux.t, le flux à intégrer
   Retour : (float * float) Flux.t, le nouveau flux *)
let integre dt flux = 
  (* valeur initiale de l'intégrateur                         *)
  let init = ( 0., 0.) in
  (* fonction auxiliaire de calcul de acc_{i} + dt * flux_{i} *)
  let iter (acc1, acc2) (flux1, flux2) =
    (acc1 +. dt *. flux1, acc2 +. dt *. flux2) in
  (* définition récursive du flux acc                         *)
  let rec acc =
    Tick (lazy (Some (init, Flux.map2 iter acc flux)))
  in acc;;

(* unless : 'a Flux.t -> ('a -> bool) -> ('a -> 'a Flux.t) -> 'a Flux.t
   Contruit un flux identique jusqu'à ce que la condition cond soit vraie
   pour la valeur courante, auquel cas la suite du flux résultat est modifiée
   par la fonction f
   Paramètres :
     - flux : 'a Flux.t, le flux en entrée
     - cond : 'a -> bool, la condition
     - f_flux : 'a -> 'a Flux.t, la fonction qui modifie le flux si la 
     condition est vraie 
   Retour : 'a Flux.t, le nouveau flux *)
let rec unless : 'a Flux.t -> ('a -> bool) -> ('a -> 'a Flux.t) -> 'a Flux.t = 
  fun flux cond f_flux ->
    Tick(lazy(
    match (Flux.uncons flux) with
    | None -> None
    | Some(v,q) -> if cond v then Some(v,f_flux v)
      else Some(v, unless q cond f_flux)
    ))