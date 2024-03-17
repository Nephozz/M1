(* ouvre la bibliotheque de modules definis dans lib/ *)
open Libnewtonoid
open Iterator
open Ball
open Paddle
open Brick
open Quadtree
open State
open Input

(* exemple d'ouvertue d'un tel module de la bibliotheque : *)
open Game

module Init = struct
  let dt = 1. /. 60. (* 60 Hz *)
end

module Box = struct
  let marge = 10.
  let infx = 10.
  let infy = 10.
  let supx = 790.
  let supy = 590.
end

let graphic_format =
  Format.sprintf
    " %dx%d+50+50"
    (int_of_float ((2. *. Box.marge) +. Box.supx -. Box.infx))
    (int_of_float ((2. *. Box.marge) +. Box.supy -. Box.infy))

let draw_state etat = 
  let (balle, raquette, lb, score) = etat in
  draw_ball Graphics.black balle;
  draw_paddle Graphics.black raquette;
  draw_bricks lb;
  Graphics.draw_string ("Score : " ^ (string_of_int score))

(* extrait le score courant d'un etat : *)
let score etat : int =
  let (_, _, _, s) = etat in
  s

let draw flux_etat =
  let rec loop flux_etat last_score =
    match Flux.(uncons flux_etat) with
    | None -> last_score
    | Some (etat, flux_etat') ->
      Graphics.clear_graph ();
      (* DESSIN ETAT *)
      draw_state etat;
      (* FIN DESSIN ETAT *)
      Graphics.synchronize ();
      Unix.sleepf Init.dt;
      loop flux_etat' (last_score + score etat)
    | _ -> assert false
  in
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let score = loop flux_etat 0 in
  Format.printf "Score final : %d@\n" score;
  Graphics.close_graph ()

let boundary = ((Box.supx-.Box.infx),(Box.supy-.Box.infy),((Box.supx-.Box.infx)/.2.,(Box.supy-.Box.infy)/.2.))

(* run_FF : state -> state Flux.t
   Génère le flux d'état du jeu pour une balle en chute libre
   Paramètre :
     - state0 : state, l'état initial
   Retour : state Flux.t, le flux d'état généré *)
let run_FF : state -> state Flux.t = fun ((((x0,y0),spd,_),r),((xp0,yp0),_,(width,height,_)),brick,score) ->
  match spd with
  | None -> failwith ""
  | Some(s) -> let (vx0,vy0) = s in 
  let acc = (Flux.constant (0.,-9.81)) in
  let vit = Flux.map (fun (vx,vy) -> (vx+.vx0,vy+.vy0)) (integre Init.dt acc) in
  let pos = Flux.map (fun (x,y) -> (x+.x0,y+.y0)) (integre Init.dt vit) in
  let mouse_pos = Flux.map fst mouse in
  let mouse_cond = Flux.map snd mouse in
  let filtered_mouse_pos = filter mouse_pos mouse_cond xp0 in
  Flux.map3 (fun p v x -> (((p,Some(v),(r,r,p)),r),((x,yp0),None,(width,height,(x,yp0))),brick,score)) pos vit filtered_mouse_pos

(* run : state -> aabb -> state Flux.t 
   Génère le flux d'état du jeu
   Paramètres :
     state0 : state, l'état initial du jeu
     boundary : aabb, la limite du terrain de jeu
   Retour : state Flux.t, l'état du jeu généré*)
let rec run : state -> aabb -> state Flux.t = fun state0 boundary ->
  unless (run_FF state0) (contact boundary) (fun (b, p, bricks, s) -> run ((bounce b (contact_objet boundary (b, p, bricks, s))),p,bricks,s) boundary)


let () = draw (run state0 boundary)
