# TD3 : Arbres lexicographiques

---
## 1. Structure arborescente n-aire

### Exercice 1 (Définition des types)
Node {- Liste de branche | - Bool}
Edge {- symbole 'a | - 'a Node}

```ocaml
type 'a arbre = Node of bool * ('a Edge list)
	and 'a Edge = 'a * 'a arbre
```

---
### Exercice 2 (Test d'appartenance)
```ocaml
val appartient = 'a list -> 'a arbre -> bool

let rec appartient l (Node(value, edges)) = match l with
| [] -> value
| h::t -> match edges with
	| [] -> false
	| (ce,ae)::te ->
		if h = ce then appartient ae
		else if h < ce then false
		else appartient l (Node(value, te))

(* Mellieur version *)
let rec recherche ch lc =
	match lc with 
		| [] -> None
		| (ce,ae)::te ->
			if ch = ce then Some ae
			else if ch < ce then None
			else recherche ch te

let rec appartient l (Node(value, edges)) = match l with
| [] -> value
| c::t -> match (recherche c edges) with
	| None -> false
	| Some a -> appartient t a
```

---
### Exercice 3 (Ajout)
```ocaml
val ajout = 'a list -> 'a arbre -> 'a arbre

let rec ajout l (Node(true, edges)) = match l with
| [] -> Node(true, edges)
| h::t -> match (recherche h edges) with
	| None -> ajout (Node(value, insert h edges (Node(false,[]))))
	| Some a -> ajout t a

val insert 'a -> [('a * 'a arbre)] -> 'a arbre -> [('a * 'a arbre)]

let rec insert ch edges new_e = match edges with
| [] -> [(ch,new_e)]
| (ce,ae)::t -> if ch > ce then (ce,ae)::(insert ch t new_e)
	else (ch,new_e)::edges
```

---
## 2. Arbres lexicographiques
*voir TD*

### Exercice 4

---
### Exercice 5 (Test d'appartenance)

---
### Exercice 6 (Ajout)

---
[[TD2 Algorithmes combinatoires]] | [[0. Sommaire PF|Sommaire]] | [[TD4 Les modules]]

#TD/PF 