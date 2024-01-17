let rec fibo n =
  match n with
  | 0 -> 0
  | 1 -> 1
  | _ -> (fibo (n-1)) + (fibo (n-2))

let hd list =
  match list with
  | [] -> raise (Foo "liste vide")
  | head::_ -> head

let tl list =
  match list with
  | [] -> raise (Foo "liste vide")
  | _::tail -> tail

let rec size list =
  match list with
  | [] -> 0
  | _::tail -> size tail + 1

let rec append list_a list_b =
  match list_a with
  | [] -> list_b
  | h::t -> h::(append t list_b)

let rec map f list =
  match list with
  | [] -> []
  | h::t -> (f h)::(map f t)

let string_of_int_list = map string_of_int

let append list_a list_b = fold_right (fun h t_list_b -> h::t_list_b) list_a list_b
let append = fold_right  (::)

let size list = fold_right (fun _ size_t -> 1 + size_t) list 0

let sum list = fold_right (fun h size_t -> h + size_t) list 0
let sum list = fold_right (+) list 0

let map f list = fold_right (fun h map_t -> (f h)::map_t) list []

"('a -> 'b -> 'b) -> 'a list -> 'b -> 'b"
let rec fold_right f list e =
  match list with
  | [] -> e
  | h::t -> f h (fold_right f t e)

let rev list = fold_right (fun h nt -> nt@[h]) list []

"('a -> 'b -> 'a) -> 'a -> 'b list -> 'a"
let rec fold_left f e list =
  match list with
  | [] -> e
  | h::t -> fold_left f (f e h) t

let rev = fold_left (fun acc l -> l::acc) []