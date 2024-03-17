open Ball
open Brick
open Quadtree
open Paddle
open Vector

(* le type des états de la forme balle, liste des briques, raquette, score *)
type state = ball * paddle * brick list * int

(* bounce : ball -> objet option option -> ball
   Calcule le nouvel état de la balle après une collision avec un objet
   Paramètres :
     - ball : ball, la balle
     - objet : objet option option, l'objet avec lequel la balle serait entrée en collision
   Retour : ball, la balle mise à jour *)
let bounce : ball -> objet option option -> ball = fun ((pos,spd,ball_aabb),r) objet ->
  match objet with
  | None -> ((pos,spd,ball_aabb),r)
  | Some(None) -> failwith "bad things happenend!"
  | Some(Some(_,_,aabb)) ->
     
    let (width,height,center) = aabb in
    (*if intersect ball_aabb aabb then*)
      let n =
        if (fst pos) -. r <= (fst center) -. width /. 2. then (-1.0,0.0)
        else if (fst pos) +. r >= (fst center) +. width /. 2. then (1.0,0.0)
        else if (snd pos) -. r <= (snd center) -. height /. 2. then (0.0,-1.0)
        else (0.0,1.0)
      in
      let d = match spd with
        | None -> failwith "ball with no speed, too slow!!!!"
        | Some(s) -> s 
      in
      (*print_endline "bounce";*)
      let new_spd = Some(d +> (-2. *. (d <*> n) *> n)) in
      ((pos,new_spd,ball_aabb),r)
    (*else ((pos,spd,ball_aabb),r)*)

(* collisions_objet : quadtree -> ball -> objet option *)
let collisions_objet : quadtree -> ball -> objet option = fun qtree ball ->
  let ((_,_,ball_aabb),_) = ball in
  let objets = query qtree ball_aabb in
  match objets with
  | [] -> None
  | h::_ -> 
    print_endline "objet detecté";
    Some(h)

(* contact_objet : aabb -> state -> objet option option
  renvoie l'objet avec lequel la balle est entrée en collision, None sinon *)
let contact_objet : aabb -> state -> objet option option = fun boundary (ball, paddle, bricks, _) ->
  let objets = paddle :: (List.map (fun (objet, _) -> objet) bricks) in
  let qtree = insertObjets (Leaf(boundary, [])) (objets) in
  let objet = collisions_objet qtree ball in
  let test_objet = match objet with
    | None -> false
    | Some(_) -> true
  in
  let ((_,_,ball_aabb),_) = ball in
  let test_wall = not (intersect ball_aabb boundary) in
  if test_objet || test_wall then Some(objet)
  else None

(* contact : aabb -> state -> bool
  renvoie true si la balle touche une brique, un mur ou la raquette, false sinon *)
let contact boundary state =
  let wrapped_object = contact_objet boundary state in
  match wrapped_object with
  | None -> false
  | Some(_) -> true