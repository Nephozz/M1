open Iterator
open Input
open Quadtree
open Graphics

type paddle = objet

(* create_paddle : point -> float -> float -> paddle
   Créer une raquette
   Paramètres :
     - pos : point, la position de la raquette
     - w : float, la largeur de la raquette
     - h : float, la hauteur de la raquette 
   Retour : paddle, la raquette *)
let create_paddle : point -> float -> float -> paddle = fun pos w h ->
  let aabb = (w,h,pos) in
  (pos,None,aabb)

(* draw_paddle : color -> paddle -> unit
   Dessine une raquette
   Paramètres :
     - color : color, la couleur de la raquette
     - p : paddle, la raquette *)
let draw_paddle : color -> paddle -> unit = fun color (_,_,(width,height,center)) ->
  set_color color;
  draw_rect (int_of_float ((fst center) -. width /. 2.)) (int_of_float ((snd center) -. height /. 2.)) (int_of_float width) (int_of_float height)

(*let check_inside v =
  let (min_value, max_value) = (Box.infx,Box.supx) in
  if (v+.40./.2.) <= max_value && (v-.40./.2.) >= min_value then true else false*)

(* filter : 'a Flux.t -> 'b Flux.t -> float -> 'a Flux.t
  filtre la position de la souris en fonction de si c'est cliqué ou non :
    - flux : flux de la position
    - cond : flux booléen condition si bouton appuyé
    - init : position initiale du paddle
  Retour : ball, le nouvel état de la balle après la collision *)
let filter : 'a Flux.t -> 'b Flux.t -> float -> 'a Flux.t = 
fun flux cond init ->
  let rec help flux cond stock =
  Tick(lazy(
  match (Flux.uncons flux), (Flux.uncons cond) with
  | Some(v,q), Some(c,d) -> if c(*&&(check_inside v)*) then Some(v, help q d v)
    else Some(stock, help q d stock)
  | _, _ -> None
  )) in
  help flux cond init