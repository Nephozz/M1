open Quadtree
open Graphics

type brick = objet * color

(* create_brick : point -> float -> float -> color -> brick 
   Créer une brique
   Paramètres :
     - pos : point, la position de la brique (son centre)
     - w : float, la largeur de la brique (composante horizontale)
     - h : float, la hauteur de la brique (composante verticale)
     - c : color, la couleur de la brique
   Retour : brick, la brique *)
let create_brick : point -> float -> float -> color -> brick = fun pos w h c ->
  let aabb = (w,h,pos) in
  let objet = (pos, None, aabb) in
  (objet, c)

(* draw_brick : brick -> unit
   Dessine une brique
   Paramètre :
     - brick : brick, la brique *)
let draw_brick brick =
  let ((_,_,(width,height,center)),color) = brick in
  set_color color;
  fill_rect (int_of_float ((fst center) -. width /. 2.)) (int_of_float ((snd center) -. height /. 2.)) (int_of_float width) (int_of_float height)

(* draw_bricks : brick list -> unit 
   Dessine une liste de briques
   Paramètre :
     - brs : brick list, la liste de briques *)
let draw_bricks brs =
  List.iter (draw_brick) brs