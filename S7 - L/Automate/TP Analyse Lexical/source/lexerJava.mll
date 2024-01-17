{

  open TokenJava
(*  open String *)
(*  open Str *)
  exception LexicalError

}

(* Macro-definitions *)
let minuscule = ['a'-'z']
let majuscule = ['A'-'Z']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let underscores = '_'+

let chiffreNonZero = ['1' - '9']
let chiffre = '0' | chiffreNonZero
let chiffreHexa = ['0' - '9'] | ['a' - 'f'] | ['A' - 'F']
let chiffreOctal = ['0' - '7']
let chiffreBin = '0' | '1'

let chiffreOuUnderscore = chiffre | '_'
let chiffreHexaOuUnderscore = chiffreHexa | '_'
let chiffreOctalOuUnderscore = chiffreOctal | '_'
let chiffreBinOuUnderscore = chiffreBin | '_'
let chiffreEtUnderscores = chiffreOuUnderscore+
let chiffreHexaEtUnderscores = chiffreHexaOuUnderscore+
let chiffreOctalEtUnderscores = chiffreOctalOuUnderscore+
let chiffreBinEtUnderscores = chiffreBinOuUnderscore+

let chiffres = chiffre | chiffre chiffreEtUnderscores? chiffre
let chiffresHexa = chiffreHexa | chiffreHexa chiffreHexaEtUnderscores? chiffreHexa
let chiffresOctal = chiffreOctal | chiffreOctal chiffreOctalEtUnderscores? chiffreOctal
let chiffresBin = chiffreBin | chiffreBin chiffreBinEtUnderscores? chiffreBin
let chiffresSigne = signe? chiffres

let indiceExpo = 'e' | 'E'
let indiceExpoBin = 'p' | 'P'
let signe = '+' |'-'
let typeSuffixFlottant = 'f' | 'F' | 'd' | 'D'
let partieExpo = indiceExpo chiffresSigne
let expoBin = indiceExpoBin chiffresSigne
let hexaSignificatif = nombreHexa '.'? | '0' ('x'|'X') chiffresHexa? '.' chiffresHexa

let nombreDecimal = '0' | chiffreNonZero chiffre? | chiffreNonZero underscores chiffres
let nombreHexa = '0' ('x'|'X') chiffresHexa
let nombreOctal = '0' chiffresOctal
let nombreBin = '0' ('b'|'B') chiffresBin

let pointFlottantDecimal = chiffres '.' chiffres? partieExpo? typeSuffixFlottant?
  | '.' chiffres partieExpo? typeSuffixFlottant?
  | chiffres partieExpo typeSuffixFlottant?
  | chiffres partieExpo? typeSuffixFlottant
let pointFlottantHexa = hexaSignificatif expoBin typeSuffixFlottant?

let simpleCarater = caractereEntre ([^"'"] | [^'\'])


let commentaireBloc = "/*" [^'*']* '*'+ ([^'/''*'] [^'*']* '*')* '/'
let commentaireLigne = "//" [^'\n']* '\n'

(* Analyseur lexical : expression reguliere { action CaML } *)
rule lexer = parse
(* Espace, tabulation, passage a ligne, etc : consommes par l'analyse lexicale *)
  | ['\n' '\t' ' ']+    { lexer lexbuf }
(* Commentaires consommes par l'analyse lexicale *)
  | commentaireBloc  	{ lexer lexbuf }
  | commentaireLigne	{ lexer lexbuf }
(* Structures de blocs *)
  | "("                 { PAROUV }
  | ")"                 { PARFER }
  | "["                 { CROOUV }
  | "]"                 { CROFER }
  | "{"                 { ACCOUV }
  | "}"                 { ACCFER }
(* Separateurs *)
  | ","                 { VIRG }
  | ";"                 { PTVIRG }
(* Operateurs booleens *)
  | "||"                { OPOU }
  | "&&"                { OPET }
  | "!"                 { OPNON }
(* Operateurs comparaisons *)
  | "=="                { OPEG }
  | "!="                { OPNONEG }
  | "<="                { OPSUPEG }
  | "<"                 { OPSUP }
  | ">="                { OPINFEG }
  | ">"                 { OPINF }
(* Operateurs arithmetiques *)
  | "+"                 { OPPLUS }
  | "-"                 { OPMOINS }
  | "*"                 { OPMULT }
  | "/"                 { OPDIV }
  | "%"                 { OPMOD }
  | "."                 { OPPT }
  | "="                 { ASSIGN }
  | "new"               { NOUVEAU }
(* Mots cles : types *)
  | "bool"              { BOOL }
  | "char"              { CHAR }
  | "float"             { FLOAT }
  | "int"               { INT }
  | "String"            { STRING }
  | "void"              { VOID }
(* Mots cles : instructions *)
  | "while"		{ TANTQUE }
  | "if"		{ SI }
  | "else"		{ SINON }
  | "return"		{ RETOUR }
(* Mots cles : constantes *)
  | "true"		{ (BOOLEEN true) }
  | "false"		{ (BOOLEEN false) }
  | "null"		{ VIDE }
(* Nombres entiers : A COMPLETER *)
  | (nombreDecimal | nombreHexa | nombreOctal | nombreBin) as texte   { (ENTIER (int_of_string texte)) }
(* Nombres flottants : A COMPLETER *)
  | (pointFlottantDecimal | pointFlottantHexa) as texte     { (FLOTTANT (float_of_string texte)) }
(* Caracteres : A COMPLETER *)
  | "'" (simpleCarater | sequenceEchap) "'" as texte                   { CARACTERE texte.[1] }
(* Chaines de caracteres : A COMPLETER *)
  | '"' _* '"' as texte                  { CHAINE texte }
(* Identificateurs *)
  | majuscule alphanum* as texte              { TYPEIDENT texte }
  | minuscule alphanum* as texte              { IDENT texte }
  | eof                                       { FIN }
  | _                                         { raise LexicalError }

{

}
