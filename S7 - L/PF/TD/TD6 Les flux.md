# TD6 : Les flux
#TODO 

## 1 Type Abstrait : les flux
les listes on les déconstruit
les flux on les construit

`uncons` récupère la tête et la queue d'un flux et renvoie une option


unfold est le dual de fold :
`Fold::('a -> 'b -> 'b) -> 'b -> 'a list -> 'b`
`unFold::('b -> ('a * 'b) option) -> 'b -> 'a t`

```ocaml
let flux_nul = Flux.unfold (fun c -> Some(c,c)) 0
```
### Exercice 1
```ocaml
val constant : 'a -> 'a flux

let constant c = Flux.unfold (fun a -> Some(a,a)) c
let constant' c = Flux.unfold (fun () -> Some(a,())) c

val apply : ('a -> 'b) -> 'a t -> 'b t

let map f flux = apply (constant f) flux
let map2 f flux1 flux2 = apply (map f flux1) flux2
```

Un flux est une valeur *récursive* (`x = 0::x`)
`Tick` -> machine à friandises

Les constructeurs en Ocaml ne sont pas des fonctions et interviennent autre part dans la compilation.

```ocaml
type 'a t = Tick of (('a * 'a t) option) Lazy.t

let vide = Tick (lazy None)

let cons t q = Tick (lazy Some(t,q))

(* lazy 5 -> int Lazy.t
 * lazy Some(3, lazy None)
 *)

let uncons (Tick fp) = Lazy.force fp
(* fait fondre les glacon est force le calcul *)

let rec unfold f e =
	Tick (lazy (
	match f e with
	| None -> None
	| Some(t, e') -> Some(t, unfold f e')
	))
```

On *considère* `lazy` comme un constructeur

---
## 2 Applications

### Exercice 2
La suite de *Fibonacci* est défini de la manière suivante :
$$
(f_{n})_{n \in \mathbb{N}} \left\{ \begin{aligned}
&f_{0} = f_{1} = 0 \\
&f_{n+2} =  f_{n+1} + f_{n}
\end{aligned}
\right.
$$

```ocaml
let f01 = cons 0 (cons 1 vide)

let fib = unfold (fun (fn, fn_plus_un)
	-> Some(fn (fn_plus_un, fn + fn_plus_un)))
	(0,1)

(* Idée
 * << f0, f1, f2, ...
 * << f1, f2, f3, ...
 * ------------------
 * (+) << f0+f1, f1+f2, f2+f3
 *)
let tail f = 
	match uncons f with
	| None -> failwith "flux vide :("
	| Some(_,q) -> q

let rec fib =
	Tick (lazy (Some(0, Tick (lazy (Some(1, map2 (+) fib (tail fib))))))

(* fib est une valeur récursive *)
```

### Exercice 3
#TODO 

---
[[TD5 Typage Avancé]] | [[0. Sommaire PF|Sommaire]] | [[TD7 Structures monadiques]] 

#TD/PF 