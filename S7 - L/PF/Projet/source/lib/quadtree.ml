open Vector

(* définition du type point *)
type point = vector

(* définition du type aabb (axis aligned bounding box) *)
type aabb = float * float * vector

type objet = point * vector option * aabb

(* belongsTo : objet list -> aabb -> bool
   renvoie true le centre de la boite est dans la liste de objets
   Parametres : objets : objet list
               aabb : aabb
   Resultat : bool *)
let belongsTo : objet list -> aabb -> bool = fun objets aabb ->
  let (_, _, center) = aabb in
  List.for_all (fun (p, _, _) -> p = center) objets

(* définition du type quadtree *)
type quadtree = 
| Leaf of aabb * objet list
| Node of aabb * quadtree * quadtree * quadtree * quadtree

(* containt : aabb -> objet -> bool
   renvoie true si le objet est dans la boite englobante
   Parametres : boundary : aabb
               (x,y) : objet
   Resultat : bool *)
let containt : aabb -> objet -> bool = fun (width,height,center) ((x,y),_,_) ->
  x > ((fst center) -. width) && x < ((fst center) +. width)
  && y > ((snd center) -. height) && y < ((snd center) +. height)

  (* intersect : aabb -> aabb -> bool
   renvoie true si les boites s'intersectent
   Parametres : boundary1 : aabb
               boundary2 : aabb
   Resultat : bool *)
let intersect : aabb -> aabb -> bool = fun (w1,h1,c1) (w2,h2,c2) ->
  let x1 = fst c1 in
  let y1 = snd c1 in
  let x2 = fst c2 in
  let y2 = snd c2 in
  x1 -. w1 /. 2. <= x2 +. w2 /. 2. || x1 +. w1 /. 2. >= x2 -. w2 /. 2.
  || y1 -. h1 /. 2. <= y2 +. h2 /. 2. || y1 +. h1 /. 2. >= y2 -. h2 /. 2.

(* filterObjets : aabb -> objet list -> objet list
   insere les objets dans la boite englobante
   Parametres : boundary : aabb
               objets : objet list
   Resultat : objet list *)
let filterObjets : aabb -> objet list -> objet list = fun boundary objets ->
  List.filter (containt boundary) objets

(* subdivide : quadtree -> quadtree
   subdivise le quadtree en 4
   Parametres : qtree : quadtree
   Resultat : quadtree *)
let subdivide : quadtree -> quadtree = fun qtree ->
  match qtree with
  | Leaf ((width,height,center), objets) -> 
    (* creation des cadrans*)
    let nw = (height /. 2., 
      width /. 2.,
      (fst center -. width /. 2., snd center -. height /. 2.)) in
    let ne = (height /. 2.,
      width /. 2., 
      (fst center +. width /. 2., snd center -. height /. 2.)) in
    let sw = (height /. 2., 
      width /. 2.,
      (fst center -. width /. 2., snd center +. height /. 2.)) in
    let se = (height /. 2., 
      width /. 2.,
      (fst center +. width /. 2., snd center +. height /. 2.)) in
    Node ((width,height,center), 
      Leaf (nw, filterObjets nw objets),
      Leaf (ne, filterObjets ne objets),
      Leaf (sw, filterObjets sw objets),
      Leaf (se, filterObjets se objets))
  | _ -> qtree

(* insertQtree : quadtree -> objet -> quadtree
   insere un objet dans le quadtree
   Parametres : qtree : quadtree
               objet : objet
   Resultat : quadtree *)
let rec insertQtree : quadtree -> objet -> quadtree = fun qtree objet ->
  match qtree with
  | Leaf (boundary, objets) -> 
    if not (containt boundary objet) then qtree
    else
      if List.length objets < 4 then
        Leaf (boundary, objet :: objets)
      else
        insertQtree (subdivide qtree) objet
  | Node (boundary, q1, q2, q3, q4) ->
    if not (containt boundary objet) then qtree
    else
      Node (boundary, insertQtree q1 objet, insertQtree q2 objet, insertQtree q3 objet, insertQtree q4 objet)

(* query : quadtree -> aabb -> objet list
    renvoie la liste des objets dans la portée
    Parametres : qtree : quadtree
                range : aabb
    Resultat : objet list *)
let rec query : quadtree -> aabb -> objet list = fun qtree range ->
  match qtree with
  | Leaf (boundary, objets) -> 
    if not (intersect range boundary) then []
    else
      filterObjets range objets
  | Node (boundary, q1, q2, q3, q4) -> 
    if not (intersect range boundary) then []
    else
      query q1 range @ query q2 range @ query q3 range @ query q4 range

let rec insertObjets : quadtree -> objet list -> quadtree = fun qtree objets ->
  match objets with
  | [] -> qtree
  | h::t -> insertObjets (insertQtree qtree h) t