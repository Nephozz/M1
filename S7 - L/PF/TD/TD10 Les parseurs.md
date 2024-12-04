# TD10 : Les parseurs

### 1. Reconnaissance de langage

"a b" -> |a, b| -> { $\Lambda$ }
"a b c" -> |a, b| -> {"c"}
"c d" -> |a, b| -> $\phi$
{"a b c", "a b d", "a e"} -> |a, b| -> {"c", "d"}

"ax" -> |a + b| -> {"x"}
"bx" -> |a + b| -> {"x"}
{"axy", "bz"} -> |a + b| -> {"xy", "z"}

```ocaml
let F x = ...
let F = fun x -> ...
```

-> p1 -> p2 ->

```ocaml
let psequence p1 p2 = fun flux ->
	Solution.(p1 flux >>= p2)

let pchoix p1 p2 = fun flux ->
	Solution.(p1 flux ++ p2 flux)
```

### 2. Les parseur comme dénotations de langages
```ocaml
let rec eval lang =
	match lang with
	| Nothing -> perreur
	| Empty -> pvide
	| Letter a -> ptest ((=) a)
	| Sequence (l1, l2) -> psequence (eval l1) (eval l2)
	| Choice (l1, l2) -> pchoix (eval l1) (eval l2)
	| Repeat l -> eval (Choice (Empty, Sequence(l, Repeat(l))))

let belongs : 'a language -> 'a Flux.t -> bool = 
	fun l f -> let p = eval l in
	Solution.uncons(Solution.filter (fun f' -> Flux.uncons f' = None))
```

### 3. Parsing plus général 
'a Flux.t -> |('a, 'b)parser| -> ('b * 'a Flux.t) Solution.t

```ocaml
let perreur = fun f -> zero f

let pnul = fun f -> (return ()) f

let pvide = fun f -> 
	match Flux.uncons f with
	| None -> Solution.return ((),f)
	| Some _ -> Solution.zero

let ptest (p, 's -> bool) = fun f ->
	match Flux.uncons f with
	| None -> Solution.zero
	| Some(t,q) -> if p t then Solution.return(t,q) else Solution.zero

let pchoix p1 p2 = (p1 ++ p2)

let psequence p1 p2 = 
	p1 >>= (fun ra -> p2 >>= (fun rb -> return (ra,rb)))
```

```ocaml
type ast = Plus of ast *bast | Var of char
```

Expr -> Var
Expr -> '(' Expr '+' Expr ')'
Var -> char

```ocaml
let paro = ptest ((=) '(')
let parf = ptest ((=) ')')
let plus = ptest ((=) '+')
let pchar = ptest (fun x -> 'a' <= x && x <= 'z')

let var = pchar >>= fun c -> return (Var(c))
let rec expr flux = 
	(var ++ (paro >>= fun _ -> expr >>= fun e1 -> plus >> fun _ -> 
		expr >>= fun e2 -> parf >>= fun _ -> return (Plus(e1,e2))
	)) flux
```

---
[[TD9 Les continuations]] | [[0. Sommaire PF|Sommaire]]

#TD/PF 
