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
q_max = 200;
nb_affichages = 1000;
pas_entre_affichages = floor(q_max/nb_affichages);
temps_pause = 0.0001;
S = 140;
gamma = 5;
T = 0.1;
lambda = 100;
alpha = 0.99;
beta = 1;

% Lecture et affichage de l'image :
I = imread('colonie.png');
I = rgb2ycbcr(I);
I = double(I(:,:,1));
[nb_lignes,nb_colonnes] = size(I);
figure1 = figure('Name','Detection de flamants roses','Position',[0,0,L,0.58*H]);

% Initialisation :
c = zeros(0,2);

liste_q = 0;
Uc = 0;
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

	[c, T, lambda, Uc] = morts_naissances(lambda,gamma,S,c,T,alpha,beta,I,R);

	set(figure1,'Name',['Detection de ' num2str(length(c)) ' flamants roses']);

	hold off;
	subplot(1,2,1);
	imagesc(I);
	axis image;
	axis off;
	colormap gray;
	hold on;
	for j = 1:length(c)
		x_affich = c(j,1)+R*cos(theta);
		y_affich = c(j,2)+R*sin(theta);
		indices = find(x_affich>0 & x_affich<nb_colonnes & y_affich>0 & y_affich<nb_lignes);
		plot(x_affich(indices),y_affich(indices),'Color',rose,'LineWidth',3);
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
