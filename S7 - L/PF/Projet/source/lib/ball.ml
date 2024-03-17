open Vector
open Quadtree
open Graphics

type ball = objet * float

(* createBall : point -> vector option -> float -> ball 
   Créer une balle
   Paramètres :
     - pos : point, la position de la balle
     - spd : vector option, la vitesse de la balle
     - r : float, le rayon de la balle
   Retour : ball, la balle *)
let createBall : point -> vector option -> float -> ball = fun pos spd r ->
  let aabb = (r *. 2., r *. 2., pos) in
  ((pos, spd, aabb), r)

(* draw_ball : color -> ball -> unit 
   Dessine une balle
   Paramètres :
     - color : color, la couleur de la balle
     - b : ball, la balle *)
let draw_ball : color -> ball -> unit = fun color ((pos, _, _), r) ->
  set_color color;
  fill_circle (int_of_float (fst pos)) (int_of_float (snd pos)) (int_of_float r)