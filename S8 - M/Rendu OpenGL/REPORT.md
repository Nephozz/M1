# TPs Rendu-2 | OpenGL

_Samy Afker / Thomas Bocandé_

## TP 1-2

### 3.3.2 Display

1. Quand on remplace `glutWireTeapot` par `glutSolidTeapot`, on passe d'un modèle avec les arrètes de dessinées à un modèle avec les arrètes et les faces.
   Pour rendre le rendu plus réaliste il faudrait ajouter de l'éclairage voir une texture.

2. On remarque que lorque que l'on augmente le nombre de `slices` et de `stacks`, l'objet dessiné ressemble de plus en plus à une sphère.

### 3.2.3 Viewport

1. Quand on essaye de redimensioner la fenêtre la théière est déformée pour que les dimensions du Viewport correspondent à celles de la fenâtre.
   On peut conserver la plus petite valeur entre la hauteur et la largeur et l'utilliser pour redimensionner le Viewport.

### 3.2.4 Keyboard

1. _voir code_

### 4.2.1 The perspective transformation

1. Quand on augmente l'angle du `fovy` on voit une partie plus grande de la scène simillaire au 'dézoom' sur un ojectif, et quand on la diminue un 'zoom' dans la scène.

2. Quand on agmente le paramètre `zNear` la théière est d'abord coupé puis disparait, c'est normal puisque que l'on dessine les modèles présents dans le volume compris entre les plan `zNear` et `zFar`.

### 4.2.2 The viewing transformation

1. En mettant le _up vector_ à la valeur (0, -1, 0) on inverse le haut et le bas de la scène.

2. Pour la vue (a) nous avons mis le _up vector_ à la valeur (1, 0, 0) pour qu'il ne soit pas colinéaire à la direction de la caméra.
   Pour la vue (b) nous avons mis le _up vector_ à la valeur (1, 1, 0) pour orienter correctement la théière.

### 4.3.2 Teapots!

1. Si on enlève le deuxième `glPopMatrix`, on observe dans un premier temps les théière du haut et du milieu. En changeant la taille de la fenêtre, les 3 théières disparaissent. En effet, en retirant le deuxième `glPopMatrix`, on accumule des matrices dans la stacks après chaque rechargement de la fenêtre. Ceci a un effet de cumuler les différentes transformations de chaque matrice ce qui fait disparaître les théières après quelques rechargements.

2. Si on met `gluLookAt(0.0,0.0,5.0,0.0,0.0,0.0,0.0,1.0,0.0)` après le deuxième `glPopMatrix`, la théière du bas disparaît. En effet, pour les théière du haut et du milieu, le `LookAt` est bien défini ce qui permet de voir les théières. Par contre, le `LookAt` ne sera pas bien défini pour la theière du bas car les `gluPopMatrix` remettent la matrice de transformation initiale (qui ne contient pas le bon `LookAt`) en haut de la `stack`.

3. Si on met `glLoadIdentity` avant le commentaire "draw scene", on n'arrive pas à bien visualise les 3 théières car le `LookAt` a été écrasé par `glLoadIdentity`.
