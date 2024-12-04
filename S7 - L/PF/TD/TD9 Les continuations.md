# TD9 : Les continuations

## 3. Continuations natives

```ocaml
let append l1 l2 =
	let rec app_X_l2 l1 =
		match l1 with
		| [] -> l2 (* shift (fun k -> k l2) *)
		| t1::q1 -> let app_q1_l2 = app_X_l2 q1
			in t1::app_X_l2
	 in app_X_l2 l1 (* in reset(app_X_l2 l1) *)
```

`shift (fun k -> k l2)` est une fermeture

*Ex : `let plus n = fun x -> x + n`
si on appelle `plus 3` on obtient la fonction `fun x -> x + 3`, la valeur 3 est sauvegardée, c'est une fermeture.*

`shift` va de paire avec `reset`

---
## 4. Application : optimisation de code

### Exercice 1
```ocaml
let rec prod_int_list l =
	match l with
	| [] -> 1
	| t::q -> t * (prod_int_list q)

let rec prod_int_list' l = 
	match l with
	| [] -> 1
	| 0::q -> 0
	| t::q -> t * (prod_int_list q)

let rec prod_int_list_cc l =
	match l with
	| [] -> 1
	| 0::q -> shift prompt0 (fun _ -> 0)
	| t::q -> t * prod_int_list_cc q

let prod_int_list_rap l =
	push.prompt0                       (* reset s'appelle push dans Delimcc ​*)
		(fun () -> prod_int_list_cc l)
```

---
## 5. Application : Resumable Exceptions
### Exercice 2
```ocaml
let leccture_cas_nominal nom =
	let f = open_in (if Sys.file_exists nom then nom
		else shift prompt0 (fun k -> Request k)) in
	let l = input_line f in close_in f; Done l

let lecture_cas_erreur nom k =
	printf "gngngn %s \n" nom;
	let nom' = read_line () in
		k nom'

let main nom =
	match push_prompt prompt0 (fun () -> lecture_cas_nominal nom) with
	| Done l -> l
	| Request k -> match lecture_cas_erreur nom k with
		| Done l -> l
		| Request k -> assert false
```

---
## 6. Application :  programmation concurrente et Green Threads
### Exercice 3
```ocaml
let ping () =
	begin
		for i = & to 10 do
			print_endline "ping!";
			shift p (fun k -> Request k)
		done;
	Done ()
	end

let pong () =
	begin
		for i = & to 10 do
			print_endline "pong!";
			shift p (fun k -> Request k)
		done;
	Done ()
	end
```

### Exercice 4
```ocaml
let scheduler () =
	let rec loop file =
		match file with
		| [] -> ()
		| proc::q -> 
			let yield = push_prompt p proc in
			match yield with
			| Done () -> loop q
			| Request k -> loop (q @ [k])
	in loop (ping,pong)
```

---
## Application :  coroutine et *yield*
### Exercice 5

---
[[TD7 Structures monadiques]] | [[0. Sommaire PF|Sommaire]] | [[TD10 Les parseurs]]

#TD/PF 

