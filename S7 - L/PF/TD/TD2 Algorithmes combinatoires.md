# TD2 : Algorithmes combinatoires

---
## 1. Parties d'un ensemble

### Exercice 1
<div><i>E = {}<br>
P<sub>E</sub> = {{}} -> 2⁰<br>
<br>
E = {...}<br>
P<sub>E</sub> = {E<sub>1</sub>,...,E<sub>n</sub>} -> 2<sup>n</sup><br>
<br>
E + {e} = E'<br>
P<sub>E'</sub> = {E<sub>1</sub>, {e} U E<sub>1</sub>,..., E<sub>n</sub>, {e} U E<sub>n</sub>} -> 2<sup>n+1</sup></i></div>

---
### Exercice 2
```ocaml
let ajout e l = List.fold_right(fun h ft = h::((e::h)::ft)) l []

let rec parties l = match l with
| [] -> [[]]
| h::t -> ajout h (parties t)

let parties l = List.fold_right ajout l [[]]
```
---
## 2. Permutation d'une liste

### Exercice 4
```ocaml
let rec insertions e l = match l with
| [] -> [[e]]
| h::t -> (e::l)::List.map (fun x -> t::x) (insertions e t)

let permutations l = List.fold_right
	(fun h perm_t -> List.flatten(List.map (insertions h perm_t))) l [[]]
```
---
## 3. Combinaisons

### Exercice 5
<div><i>C(n,0) = 1<br>
C(0, k+1) = 0<br>
C(n+1, k+1) = C(n, k+1) + C(n, k)</i></div>

---
### Exercice 6
*Non Traité*

---
[[TD1 Listes]] | [[0. Sommaire PF]] | [[TD3 Arbres lexicographiques]]

#TD/PF 