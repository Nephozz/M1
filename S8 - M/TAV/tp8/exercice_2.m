clear
close all
clc

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Décomposition par variation totale',...
	'Position',[0.05*L,0.1*H,0.9*L,0.7*H]);

% Lecture de l'image :
u_0 = double(imread('Images/tintin.png'));
[nb_lignes,nb_colonnes,nb_canaux] = size(u_0);
u_max = max(u_0(:));

% Affichage de l'image :
subplot(1,3,1)
	imagesc(max(0,min(1,u_0/u_max)),[0 1])
	if nb_canaux==1
		colormap gray
	end
	axis image off
	title('Image originale','FontSize',20)

% Affichage de l'image décomposée a l'iteration 0 :
subplot(1,3,2)
	imagesc(max(0,min(1,u_0/u_max)),[0 1])
	if nb_canaux==1
		colormap gray
	end
	axis image off
	title('Structure (iteration 0)','FontSize',20)
drawnow nocallbacks

% Vectorisation des canaux de u_0 :
nb_pixels = nb_lignes*nb_colonnes;
u_0 = reshape(u_0,[nb_pixels nb_canaux]);

% Parametre pour garantir la differentiabilite de la variation totale :
epsilon = 0.01;

% Operateur gradient :
e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
Dx(end-nb_lignes+1:end,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes:nb_lignes:end,:) = 0;

% Second membre b du systeme :
b = u_0;
		
% Point fixe :
lambda = 200;			% Poids de la regularisation
u_k = u_0;
convergence = +Inf;
iteration = 0;

while iteration < 20

	% Incrementation du nombre d'iterations :
	iteration = iteration + 1;

	% Iteration (6) :
	u_kp1 = debruitage(b,u_k,lambda,Dx,Dy,epsilon);	

	% Test de convergence :
	convergence = norm(u_kp1(:)-u_k(:))/norm(u_k(:));

	% Mise a jour de l'image courante u_k :
	u_k = u_kp1;

	% Affichage de l'image restauree a chaque iteration :
	subplot(1,3,2)
		u_b = max(0,min(1,reshape(u_k,[nb_lignes nb_colonnes nb_canaux])/u_max));
		% Cap the values of the image
		u_b = u_b + 0.05;
		u_b(u_b<0.3) = 0.3;
		u_b(u_b>1) = 1;
		imagesc(u_b)
		if nb_canaux==1
			colormap gray
		end
		axis image off
		title(['Structure (iteration ' num2str(iteration) ')'],'FontSize',20)
        
    subplot(1,3,3)
		u_c = max(0,min(1,(reshape(u_0-u_k,[nb_lignes nb_colonnes nb_canaux])/u_max+1)/2));
		% Remove colors from the texture
		u_c = mean(u_c,3);
		% Threshold the texture
		u_c(u_c<0.5) = 0;
		u_c(u_c>=0.5) = 1;
		%u_c = im2gray(u_c);

        imshow(u_c)
		if nb_canaux==1
			colormap gray
		end
		axis image off
        title(['Soustraction de la solution, Texture (iteration ' num2str(iteration) ')'],'FontSize',20)    
        
	drawnow nocallbacks
	pause(0.1)

end
