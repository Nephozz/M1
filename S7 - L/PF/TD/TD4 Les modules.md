# TD4 : Les modules

---
## 2. Utilisation des modules

### Exercice 1
```ocaml
module type Collection =
sig
	type 'a t
	execption CollectionVide
	val empty: 'a t
	val isEmpty: 'a t -> bool
	val add: 'a -> 'a t -> 'a t
	val pop: 'a t -> ('a * 'a t)
end

module Pile: Collection =
struct
	type 'a t = 'a list
	execption CollectionVide
	let empty = []
	let isEmpty p = (p = empty)
	let add e p = e::p          (*f@[e] pour les files*)
	let pop e p = match p with
	| empty -> raise CollectionVide
	| h::t -> (h, t)
end
```
---
### Exercice 2
```ocaml
module type Fold =
sig
	type a
	type b
	val cas_de_base: b
	val traitre_et_combine: a -> b -> b
end

module CreerListe: Fold with type a = int and type b = int list =
struct
	type a = int
	type b = int list
	let cas_de_base = []
	let traite_et_combine elt lt = elt::lt
end

module TrouvePair: Fold with type a = int and type b = int Option =
struct
	type a = int
	type b = int Option
	let cas_de_base = None
	let traite_et_combine elt t  = if ((elt mod 2) = 0)
		then Some elt
		else t
end
```

---
## 3. Les foncteurs
### Exercice 3
```ocaml
module FoldList (F: Fold) =
struct
	let rec fold_right l = match l with
	| [] -> F.cas_de_base
	| h::t -> F.traite_et_combine h (foldright t)
end

module FoldCollection (C: Collection) (F: Fold)
struct
	let rec fold col =
		if C.isEmpty col then F.cas_de_base
		else let (h, t) = pop col in
			F.traite_et_combine h (fold t)
end

module FoldPile = FoldCollection (Pile)
module CreerListePile = FoldPile (CreerListe)

let%test _ = CreerListePile(Pile.(add 1)(add 2 (add 3))) = [1;2;3]
```

---
[[TD3 Arbres lexicographiques]] | [[0. Sommaire PF|Sommaire]] | [[TD5 Typage Avancé]]

#TD/PF 
