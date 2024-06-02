clear;
close all;

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);


% Parametres :
N = 50;					% Nombre de disques d'une configuration
R = 7;					% Rayon des disques
nb_points_affichage_disque = 30;
increment_angulaire = 2*pi/nb_points_affichage_disque;
theta = 0:increment_angulaire:2*pi;
rose = [253 108 158]/255;
q_max = 160;
nb_affichages = 1000;
pas_entre_affichages = floor(q_max/nb_affichages);
temps_pause = 0.0001;
T0 = 0.1;
lambda0 = 100;

% Lecture et affichage de l'image :
I = imread('colonie.png');
I = rgb2ycbcr(I);
I = double(I(:,:,1));
[nb_lignes,nb_colonnes] = size(I);
figure1 = figure('Name','Detection de flamants roses','Position',[0,0,L,0.58*H]);

% Initialisation :
c = zeros(0,3);

liste_q = 0;
Uc = 0;
T = T0;
lambda = lambda0;
liste_Uc = Uc;

% Affichage de la configuration initiale :
subplot(1,2,1);
imagesc(I);
axis image;
axis off;
colormap gray;
hold on;
pause(temps_pause);

% Courbe d'evolution d'énergie :
subplot(1,2,2);
plot(liste_Uc,liste_q,'.','Color',rose);
axis([0 q_max -400 0]);
set(gca,'FontSize',20);
xlabel('Nombre d''iterations','FontSize',20);
ylabel('Énergie','FontSize',20);


% Recherche de la configuration optimale :
for q = 1:q_max

	[c, T, lambda, Uc] = morts_naissances_ellipse(lambda,c,T,I,R);

	set(figure1,'Name',['Detection de ' num2str(length(c)) ' flamants roses']);

	hold off;
	subplot(1,2,1);
	imagesc(I);
	axis image;
	axis off;
	colormap gray;
	hold on;
	for i = 1:size(c, 1)
        ellipse(R, 3*R/4, c(i, 3), c(i, 1), c(i, 2), 'r');
    end
	pause(temps_pause);

	% Courbe d'evolution du niveau d'énergie :

	liste_q = [liste_q q];
	liste_Uc = [liste_Uc Uc];
	subplot(1,2,2);
	plot(liste_q,liste_Uc,'.','Color',rose,'LineWidth',3);
	axis([0 q_max -400 0]);
	set(gca,'FontSize',20);
	xlabel('Nombre d''iterations','FontSize',20);
	ylabel('Énergie','FontSize',20);
end

function ellipse(a, b, theta, x0, y0, color)
    % Dessiner une ellipse sur une image
    t = linspace(0, 2*pi, 100);
    X = a * cos(t);
    Y = b * sin(t);
    
    x = x0 + X * cos(theta) - Y * sin(theta);
    y = y0 + X * sin(theta) + Y * cos(theta);
    
    plot(x, y, color, 'LineWidth', 1.5);
end