function x = moyenne_3D(I)

% Conversion en flottants :
I = single(I);

% Calcul des couleurs normalisees :
somme_canaux = max(1,sum(I,3));
r = I(:,:,1)./somme_canaux;
v = I(:,:,2)./somme_canaux;

% Calcul des couleurs moyennes :
r_barre = mean(r(:));
v_barre = mean(v(:));

% Création du masque circulaire :
[ny,nx] = size(r);
[X,Y] = meshgrid(1:nx,1:ny);
masque = (X-nx/2).^2 + (Y-ny/2).^2 < (min(nx,ny)/4)^2;

% Calcul des couleurs moyennes dans le masque :
r_c_barre = mean(r(masque));

% Calcul des couleurs moyennes hors du masque :
r_h_barre = mean(r(~masque));

x = [r_barre v_barre r_c_barre-r_h_barre];
