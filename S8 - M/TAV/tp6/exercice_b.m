clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load force_externe_bis;

nb_cycles_max = 3;
nb_iter_max = 300;

% Autres parametres :
N = 200;				% Nombre de points du contour actif
pas_affichage = 1000;			% Nombre d'iterations entre deux affichages

figure('Name','Champ de force externe','Position',[0.1*L,0.1*H,0.9*L,0.7*H]);
subplot(1,2,1);
imagesc(I);
colormap gray;
axis image off;
title('Image a segmenter','FontSize',20);

% Definition des points de controle :
fprintf('Definissez des points de controle par clics, puis tapez Entree !\n');
[x_P,y_P] = ginput;
plot(x_P,y_P,'r*','MarkerSize',10,'LineWidth',3);

% Coordonnees initiales (x0,y0) du contour actif par interpolation des points de contrôle :
x_P = [x_P ; x_P(1)];			% Duplication du premier point de controle
y_P = [y_P ; y_P(1)];			% Idem
nb_P = length(x_P);
xy_0 = interp1(1:nb_P,[x_P,y_P],1:(nb_P-1)/N:nb_P,'spline');
x_0 = xy_0(:,1);
y_0 = xy_0(:,2);

% Affichage du contour actif initial :
plot(x_0,y_0,'b-','LineWidth',2);
drawnow;
title('Iteration 0','FontSize',20);

% evolution du contour actif :
x = x_0(1:end-1);
y = y_0(1:end-1);
x_precedent = x;
y_precedent = y;
c = 0;
while c < nb_cycles_max
    k = 0;
    while k < nb_iter_max
        % Caclul des vecteurs normaux à la courbe
        [Nx,Ny] = normaux(x,y);
        
        if mod(c,2) == 0
            [x,y] = descGrad(x,y,Nx,Ny,g);
        else
            [x,y] = EF(x,y,Nx,Ny,g);
        end
        k = k + 1;
    end
    c = c + 1;
end

% Affichage du contour actif final :
subplot(1,2,2);
imagesc(I);
axis image off;
colormap gray;
hold on;
plot([x ; x(1)],[y ; y(1)],'r-','LineWidth',2);
title('Resultat de la segmentation','FontSize',20);

% Fonction de calcul des vecteurs normaux à la courbe :
function [Nx,Ny] = normaux(x,y)
    N = length(x);
    Nx = zeros(N,1);
    Ny = zeros(N,1);
    for i = 1:N
        if i == 1
            Nx(i) = y(2) - y(N);
            Ny(i) = x(N) - x(2);
        elseif i == N
            Nx(i) = y(1) - y(N-1);
            Ny(i) = x(1) - x(N-1);
        else
            Nx(i) = y(i+1) - y(i-1);
            Ny(i) = x(i-1) - x(i+1);
        end
    end
    norme = sqrt(Nx.^2 + Ny.^2);
    Nx = Nx./norme;
    Ny = Ny./norme;
end