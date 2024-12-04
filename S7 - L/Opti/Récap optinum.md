# Récap Optimisation numérique

## I. Rappel de cours

### Existence du minimum:
<font color="red">Théorème:</font> $f: \mathbb{R}^n \longrightarrow \mathbb{R}$ sur $C$ **fermé non vide**. $f \ C^{\infty}$ et **0-coercive** $\Rightarrow \exists \mathrm{min}$
<font color="red">Théorème:</font>  $f \quad C^{\infty}$ sur $C$ **compact** **non** **vide** $\Rightarrow \exists \mathrm{min}$ **0-coercive** : $f(x) \underset{\|x\| \rightarrow+\infty}\longrightarrow +\infty$
### Compact: 
<font color="red">Théorème:</font>  $C$ **fermé borné** $\Rightarrow$ $C$ **compact** 
### $C$ fermé: 
$C$ est l'image réciproque par une application continue d'un fermé <font color="green">( {0} )</font> 
### $C$ borné: 
$$
\exists \alpha, \ \forall x \in C, \ \{\|x\| \leqslant \alpha\}
$$
### Convexe: 
$$
\forall(x, y) \in C^2, \ \forall \alpha \in \mathbb{R}, \ \alpha x+(1-\alpha) y \in C
$$ 
### Forme quadratique généralisée: 
$$
\begin{array}{l}
f(x)=\frac{1}{2} x^{\top}+x-b^{\top} x+c & \nabla f(x)=H x-b \\
& \nabla^2 f(x)=H
\end{array}
$$
et
$$
f(x) \geqslant \frac{1}{2} \lambda_{\min }(H) \cdot\|x\|^2-\|b\| \cdot\|x\|+c
$$
### Unicités :
$f: C \rightarrow \mathbb{R}$ **strictement** **convexe** sur $C$ convexe $\Rightarrow$ **solution** **unique** 
### Convexité: 
<font color="red">Théorème:</font>  $\nabla^2 f(x)$ définie positive $\Rightarrow f$ strictement convexe *(ex : $\it \mathbb{R}^n$ est convexe)*
### Globale: 
$f: C \rightarrow \mathbb{R}$  convexe sur $C$ convexe: $x^{*}$ min local $\Rightarrow x^{*}$ min global.
### <font color="green">Calcul:</font>
$$
\begin{array}{ll}
f(x)=\frac{1}{2} x^{T} A x & \nabla f(x)=A x \quad \textcolor{red}{\text{si A symetrique}} \\
f(x)=\|x\|^2 & \nabla f(x)=2 x \\
f(x)=y^{T} x & \nabla f(x)=y \\
\end{array}


$$

## II. Sans contraintes:

**CN1**: $f$ admet un min local en $x^* \Rightarrow \nabla f\left(x^*\right)=0$
**CN2**: $f$ admet un min local en $x^* \Rightarrow \nabla^2 f\left(x^*\right) \geqslant 0$ (définie positive)
**CS2**: $\nabla^2 f\left(x^*\right) \geqslant 0$ et $\nabla f\left(x^*\right)=0 \Rightarrow x^*$ min focal;  $x^* \in \mathcal{O}$, ouvert de $\mathbb{R}^n$ également convexe 
**CS2**: $\nabla^2 f(x^*)$ est définie positive $\Rightarrow$ $x^*$ est min local de $f$.
$f$ 2 fois différentiable sur $\mathcal{O}$ : $\exists \epsilon > 0$ tq $\mathcal{B}(x^*,\epsilon) \subset \mathcal{O}$ et $\forall x \in \mathcal{B}(x^*,\epsilon)$, $\nabla^2 f(x)$ est semi-défiine positive $\Rightarrow x^*$ est  un min local de $f$.

#### Résolution
1. Existnece et unicité
2. points critiques ($\nabla f(x) = 0$)
3.  Arrêt possible
	- si $f$ convexe sur $\mathcal{O}$ convexe -> sol exactes
	- un seul point critique et existence/unicité de la solution 
4. recherche des minima locaux parmi les pts critiques par une étude du $2^{nd}$ ordre
	- étude de $\nabla^{2} f(x)$, $\forall x$ critiques
5. recherche des sol parmi les minima locaux et points critiques *indéterminés*

## III. Avec contraintes:
### HQC: 
$h$ est affine **ou** $\underbrace{\left(\nabla h_1, \nabla h_2, \ldots, \nabla h_n\right)}_{\text {les contraintes actives}}$ est une famille **libre**. ($\mathcal{T} (\mathcal{C},x) = \mathcal{T}_L(\mathcal{C},x)$)

### CN1 de KKT: *(sans contraintes d'inégalités)*
$$
x^* \text { min local de } f \text{ et } H Q C\left(x^*\right) \Rightarrow\left\{\begin{array}{l}
\nabla L_x\left(x^*, \lambda^*\right) = 0 \\
\nabla L_\lambda\left(x^*, \lambda^*\right) = 0 = \textcolor{red}{h(x^*)}
\end{array}\right.
$$
### CN1 de KKT: *(avec contraintes d'inégalités)*
$$
\begin{array}{ll}
x^* \text { min local et } HQC \left(x^*\right) \Rightarrow
&\nabla_x L\left(x^*, \lambda^*, \mu^*\right) = 0 \\
&\nabla_\lambda L\left(x^*, \lambda^*, \mu^*\right) = 0 = \textcolor{red}{h(x)} \\
&\left. \begin{array}{ll}
& g_i\left(x^*\right) \leq 0 \\
& \mu_i \geqslant 0 \\
& \mu_i g_i\left(x^*\right)=0 \end{array}\right\}  \textcolor{green}{\forall i}
\end{array}
$$

### CN2: 
$x^*$ min local de $f$ et $H Q C\left(x^*\right) \Rightarrow \forall d \in \operatorname{Ker} \ J_n \left(x^*\right): \ d^{\top} \nabla_x^2 L\left(x^*, \lambda^*\right) d \geqslant 0$
$$
\begin{aligned}
& \textcolor{red}{\operatorname{Ker} J_n\left(x^*\right)} =\left\{d \in \mathbb{R}^n,\left(\nabla h_i\left(x^*\right) \mid d\right)=0, \ \forall i\right\} \\
	& L(x, \lambda, \mu)=f(x) + \lambda^{\top} h(x) + \mu^{\top} g(x)
\end{aligned}
$$

### Valeur d'adhérence: *Les limites des sous-suites de $(x_n)$*
<font color="red">Théorème:</font> $(x_n)$ est bornée $\Rightarrow$ elle admet au moins une valeur d'adhérence

### Taylor Lagrange:
$$
\begin{aligned}
& \exists c \in {[x, x+h]} \\
& f(x+h) \leqslant f(x)+\nabla f(x)^{\top} h+\frac{1}{2} h^{\top} \nabla^2 f(x) h
\end{aligned}
$$