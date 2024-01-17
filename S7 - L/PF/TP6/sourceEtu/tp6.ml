type zero = private Dummy1
type _ succ = private Dummy2
type nil = private Dummy3
type 'a list = Nil | Cons of 'a * 'a list


(* Exercice 1 *)
type ('a, 'n) nlist = 
| Nil : ('a, zero) nlist
| Cons : 'a * ('a, 'n) nlist -> ('a, 'n succ) nlist

let rec map : type n . ('a -> 'b) -> ('a, n) nlist -> (('b, n) nlist) =
  fun f l ->
    match l with
    | Nil -> Nil
    | Cons(t,q) -> Cons(f t, map f q)


let rec snoc : type n . 'a -> ('a, n) nlist -> ('a, n succ) nlist =
  fun e l ->
      match l with
      | Nil -> Cons(e, Nil)
      | Cons(t,q) -> Cons(t, snoc e q)

let tail : type n . ('a, n succ) nlist -> ('a, n) nlist =
  fun l ->
    match l with
    | Cons(t,q) -> q

let rec rev : type n . ('a, n) nlist -> ('a, n) nlist =
  fun l ->
    match l with
    | Nil -> Nil
    | Cons(t,q) -> snoc t (rev q)

(* Exercice 2 *)
let rec insert : type n . 'a -> ('a, n) nlist -> ('a, n succ) nlist =
  fun e l -> match l with
  | Nil -> Cons(e, Nil)
  | Cons(t,q) -> if t < e then Cons(t, insert e q) else Cons(e, l)

let rec insertion_sort : type n . ('a, n) nlist -> ('a, n) nlist =
  fun l -> match l with
  | Nil -> Nil
  | Cons(t,q) -> insert t (insertion_sort q)

(* Exercice 3 *)
type 'p hlist = 
| Nil : nil hlist
| Cons : 'p * 'a hlist -> ('p * 'a) hlist

let tail : type p . ('a * p) hlist -> p hlist =
  fun l -> match l with
  | Cons(t,q) -> q 

let add : type p . (int * (int * p)) hlist -> (int * p) hlist =
  fun l -> match l with
  | Cons(a,Cons(b,q))-> Cons(a+b,q)

(* Exercice 4 *)
type 't expr = 
| Entier : int -> int expr
| Booleen : bool -> bool expr
| Plus : int expr * int expr -> int expr
| Egal : 't expr * 't expr -> bool expr


let rec eval : type t . t expr -> t =
  fun exp -> match exp with
  | Entier v -> v
  | Booleen v -> v
  | Plus (e1, e2) -> (eval e1) + (eval e2)
  | Egal (e1, e2) -> (eval e1) = (eval e2)

(* Exercice 5 *)
type valeur =
| Int of int 
| Bool of bool

type code =
| PushI of int 
| PushB of bool 
| Add 
| Equ 
| Seq of code * code

let rec compile : type t . t expr -> code = 
  fun exp -> match exp with
  | Entier v -> PushI v
  | Booleen v -> PushB v
  | Plus (e1, e2) -> Seq(compile e1, Seq(compile e2, Add))
  | Egal (e1, e2) -> Seq(compile e1, Seq(compile e2, Equ))

let exec : type valeur . code -> valeur list -> valeur list =
  fun c vl -> match c with
  | PushI v -> Cons(Int v,vl)
  | PushB v -> Cons(Bool v,vl)
  | Seq(_, Add) -> let Cons(e1,Cons(e2,q)) = vl in
    Cons((e1 + e2),q)
  | Seq(_, Equ) -> let Cons(e1,Cons(e2,q)) = vl in
    Cons((e1 = e2),q)
  | Seq(e1, e2) -> Cons((exec e2 vl),Cons((exec e1 vl),vl))