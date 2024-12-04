# TD1 : Liste

---
## 1. Structure de données : liste

### Exercice 1
```ocaml
(* ---Contrat---
deuxieme : renvoie le 2ème elt d'une liste
pre : taille(list) >= 2
paramètres :
list : 'a list - (liste pour laquelle on souhaite récupérer le 2ème elt)

---Tests---
test : l1 = []
l2 = [1]
l3 = [1;2]
l4 = [1;2;3;4;5]
l5 = ['a', 'b', 'c']
  
deuxieme l1 -> "la liste est vide!"
deuxieme l2 -> "la liste contient un seul élement!"
deuxieme l3 -> 2
deuxieme l4 -> 2
deuxieme l5 -> 'b'
*)

let deuxieme list = match list with
| [] -> failwith "la liste est vide!"
| [_] -> failwith "la liste contient un seul élement!"
| _::s::t -> s
```

```ocaml
(* ---Contrat---
n_a_zero : construit la liste des n à zero entier
pre : n >= 0
paramètres :
n : int
  
---Tests---
test :
n_a_zero 0 -> [0]
n_a_zero 1 -> [1;0]
n_a_zero 4 -> [4;3;2;1;0]
*)

let rec n_a_zero n = match n with
| 0 -> [0]
| _ -> n::(n_a_zero (n-1))
  
let zero_a_n n =
let rec aux p list
if p < 0 then list
else aux (p-1) p::list
in aux n []
```

```ocaml
(* ---Contrat---
indice : renvoie la liste des indices d'un elt e dans une liste l
pre : e du même type que les elt de la liste
paramètres :
e : 'a (elt à chercher)
l : 'a list (liste dans laquelle on effectue la recherche)
résultat : une liste d'entiers (int list) correspondant aux indices de l'élément e

---Tests---
test :
indice 5 [] -> []
indice 5 [5;1;2] -> [0]
indice 5 [1;2;3;4] -> []
indice 5 [5;2;5;3] -> [0;2]
indice 'a' ['b';'z';'a';'a'] -> [2;3]
*)

let indice e l =
	let rec aux e l i = match l with
	| [] -> []
	| h::t -> if h = e then i::(aux e l i) else aux e t (i+1)
	in aux e l 0
```
---
### Exercice 2
```ocaml
(*1*)
let map f l = List.fold_right (fun h map_t -> (f h)::map_t) l []

(*2*)
let flatten l = List.fold_right (fun sl fl -> sl@fl) l [] 

(*3*)
let fsts = List.map fst

(*4*)
let split l = List.fold_right (fun (a,b) (l1,l2) -> (a::l1,b::l2)) l []

(*5*)
let remove l = List.fold_right (fun e sort_t -> if (List.mem e sort_t) 
then sort_t else e::sort_t) l []
```
---
## 2. Modules, application aux files

### Exercice 3
```ocaml
```
---
### Exercice 4
```ocaml
```
---
[[0. Sommaire PF|Sommaire]] | [[TD2 Algorithmes combinatoires]]

#TD/PF