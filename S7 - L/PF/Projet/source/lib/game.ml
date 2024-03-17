open State
open Iterator
open Ball
open Paddle
open Brick

let game_hello () = print_endline "Hello, Newtonoiders!"

(*On initialise l'origin de la balle, sur la raquette (pos,spd,r,aabb)*)
let ball0 : ball = createBall (390., 50.) (Some((0.,0.))) 5.
(*On initialise la raquette au milieu de l'écran (centre,largeur,hauteur)*)
let paddle0 : paddle = create_paddle (390.,30.) 40. 5.
(*On initialise les briques, cad brick list, on veut chaque éléments*)

let brick_height = 20.
let brick_width = 25.
let bricks0 : brick list =
  [(create_brick (50.,500.) brick_width brick_height Graphics.yellow);(create_brick (120.,500.) brick_width brick_height Graphics.yellow);(create_brick (190.,500.) brick_width brick_height Graphics.yellow);
  (create_brick (260.,500.) brick_width brick_height Graphics.yellow);(create_brick (330.,500.) brick_width brick_height Graphics.yellow);(create_brick (400.,500.) brick_width brick_height Graphics.yellow);
  (create_brick (470.,500.) brick_width brick_height Graphics.yellow);(create_brick (540.,500.) brick_width brick_height Graphics.yellow);(create_brick (610.,500.) brick_width brick_height Graphics.yellow);
  (create_brick (680.,500.) brick_width brick_height Graphics.yellow);(create_brick (750.,500.) brick_width brick_height Graphics.yellow);(create_brick (820.,500.) brick_width brick_height Graphics.yellow);
  (create_brick (50.,400.) brick_width brick_height Graphics.blue);(create_brick (120.,400.) brick_width brick_height Graphics.blue);(create_brick (190.,400.) brick_width brick_height Graphics.blue);
  (create_brick (260.,400.) brick_width brick_height Graphics.blue);(create_brick (330.,400.) brick_width brick_height Graphics.blue);(create_brick (400.,400.) brick_width brick_height Graphics.blue);
  (create_brick (470.,400.) brick_width brick_height Graphics.blue);(create_brick (540.,400.) brick_width brick_height Graphics.blue);(create_brick (610.,400.) brick_width brick_height Graphics.blue);
  (create_brick (680.,400.) brick_width brick_height Graphics.blue);(create_brick (750.,400.) brick_width brick_height Graphics.blue);(create_brick (820.,400.) brick_width brick_height Graphics.blue);
  (create_brick (50.,300.) brick_width brick_height Graphics.red);(create_brick (120.,300.) brick_width brick_height Graphics.red);(create_brick (190.,300.) brick_width brick_height Graphics.red);
  (create_brick (260.,300.) brick_width brick_height Graphics.red);(create_brick (330.,300.) brick_width brick_height Graphics.red);(create_brick (400.,300.) brick_width brick_height Graphics.red);
  (create_brick (470.,300.) brick_width brick_height Graphics.red);(create_brick (540.,300.) brick_width brick_height Graphics.red);(create_brick (610.,300.) brick_width brick_height Graphics.red);
  (create_brick (680.,300.) brick_width brick_height Graphics.red);(create_brick (750.,300.) brick_width brick_height Graphics.red);(create_brick (820.,300.) brick_width brick_height Graphics.red)]
(*Enfin on initialise l'état 0*)
let score0 = 0
let state0 = (ball0, paddle0, bricks0, score0)