clear;
close all;
% Nombre d'images utilisees
nb_images = 36;

% chargement des images
for i = 1:nb_images
    if i<=10
        nom = sprintf('./images/viff.00%d.ppm',i-1);
    else
        nom = sprintf('./images/viff.0%d.ppm',i-1);
    end;
    % im est une matrice de dimension 4 qui contient
    % l'ensemble des images couleur de taille : nb_lignes x nb_colonnes x nb_canaux
    % im est donc de dimension nb_lignes x nb_colonnes x nb_canaux x nb_images
    im(:,:,:,i) = imread(nom);
end;

% Affichage des images
figure('Name','Affichage des images','NumberTitle','off');
subplot(2,2,1); imshow(im(:,:,:,1)); title('Image 1');
subplot(2,2,2); imshow(im(:,:,:,9)); title('Image 9');
subplot(2,2,3); imshow(im(:,:,:,17)); title('Image 17');
subplot(2,2,4); imshow(im(:,:,:,25)); title('Image 25');

%% K-means

%close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A COMPLETER                                             %
% Calculs des superpixels                                 %
% Conseil : afficher les germes + les régions             %
% à chaque étape / à chaque itération                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


I = im(:,:,:,1);

m = 10;
epsilon = 1;
nb_iter_max = 10;
racine_K = 15;
K = racine_K^2;

[hauteur, largeur, nb_canaux] = size(I);

S = sqrt(hauteur * largeur / K);

s_x = floor(largeur / racine_K);
s_y = floor(hauteur / racine_K);

centres = zeros(K,nb_canaux+2);


% Vectorisation de l'image
X = double(reshape(I, hauteur * largeur, 3));

% Ajout des positions
[X1, X2] = meshgrid(1:largeur, 1:hauteur);
X = [X, X1(:), X2(:)];


% Initialisation des centres
for i=1:racine_K
    for j=1:racine_K
        x = floor(s_x/2 + (j-1)*s_x);
        y = floor(s_y/2 + (i-1)*s_y);
        rgb = double(reshape(I(y, x, :), 1, nb_canaux));
        centres((i-1)*racine_K + j,:) = [rgb, x, y];
    end
end

num_pixels = size(X,1);

labels = zeros(num_pixels, 1);

centres_old = zeros(num_pixels, 1);

figure('Name','Calcul des centres des superpixels par k-means','NumberTitle','off');

% K-means
for iter = 1:nb_iter_max
    title("Itération n°"+iter)
    hold on;
    mask = boundarymask(reshape(labels, hauteur, largeur));
    imshow(labeloverlay(I,mask,'Transparency',0));
    hold on;
    scatter(centres(:,nb_canaux+1), centres(:,nb_canaux + 2), 'g', 'filled');
    pause(0.1);

    % Calcul du labels des pixels
    labels = calcul_centres(X, centres, m, S);

    % Mise à jour des centres
    centres_old = centres;
    centres = maj_centres(X, labels, K);

    if norm(centres_old - centres) < epsilon
        break;
    end
end


%% Binarisation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A COMPLETER                                             %
% Binarisation de l'image à partir des superpixels        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fond = [0 0 255];
dino = [255 120 0];

meanColor = zeros(K, 3);

for k=1:K
    mask = labels == k;
    meanColor(k, :) = mean(X(mask, 1:3)); 
end

distance_fond = sum((meanColor - fond).^2, 2);
distance_forme = sum((meanColor - dino).^2, 2);

im_mask = zeros(hauteur, largeur);

for i=1:num_pixels
    if distance_fond(labels(i)) > distance_forme(labels(i))
        im_mask(X(i, nb_canaux + 2), X(i, nb_canaux + 1)) = 1;
    end
end

figure('Name','Masque binaire fait maison','NumberTitle','off');
imshow(im_mask);

%% Calcul de la frontière et du squelette

% ........................................................%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A FAIRE SI VOUS UTILISEZ LES MASQUES BINAIRES FOURNIS   %
% Chargement des masques binaires                         %
% de taille nb_lignes x nb_colonnes x nb_images           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%close all;
nb_images = 36; % Nombre d'images

% chargement des masques (pour l'elimination des fonds bleus)
% de taille nb_lignes x nb_colonnes x nb_images
load mask;
fprintf('Chargement des donnees termine\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A DECOMMENTER ET COMPLETER                              %
% quand vous aurez les images segmentées                  %
% Affichage des masques associes                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Affichage des masques associes
figure('Name','Calcul du squelette','NumberTitle','off');
im_mask = 1 - im_mask;

k = 1;
warning ('off','all');
a_afficher = [1 9 17 25];
for p=1:length(a_afficher)
    i = a_afficher(p);
    row = floor(hauteur / 2);
    [~, col] = find(im_mask(row,:,i),1);
    front = bwtraceboundary(im_mask(:,:,i), [row,col], 'NW');
    front = smoothdata(front,"gaussian", 20);
    [vx, vy] = voronoi(front(1:end,2),front(1:end,1));
    vx_clean = [];
    vy_clean = [];
    for j=1:length(vx)
        y1 = floor(vy(1,j));
        y2 = floor(vy(2,j));
        x1 = floor(vx(1,j));
        x2 = floor(vx(2,j));
        if inpolygon(x1, y1, front(:, 2), front(:, 1)) && inpolygon(x2, y2, front(:, 2), front(:, 1))
            vx_clean = [vx_clean vx(:, j)];
            vy_clean = [vy_clean vy(:, j)];
        end
    end
    
    if i == 1 || i == 9 || i == 17 || i == 25
        subplot(2,2,k);
        imshow(im_mask(:,:,i)); title(['Masque image ' num2str(i)]);
        hold on;
        plot(front(:,2),front(:,1),'g','LineWidth',2);
        hold on;
        plot(vx_clean, vy_clean, 'r');
        hold on;
        k = k + 1;
    end
end
warning ('on','all');


%% Chargement des points 3D
% chargement des points 2D suivis
% pts de taille nb_points x (2 x nb_images)
% sur chaque ligne de pts
% tous les appariements possibles pour un point 3D donne
% on affiche les coordonnees (xi,yi) de Pi dans les colonnes 2i-1 et 2i
% tout le reste vaut -1
pts = load('viff.xy');
% Chargement des matrices de projection
% Chaque P{i} contient la matrice de projection associee a l'image i
% RAPPEL : P{i} est de taille 3 x 4
load dino_Ps;

% Reconstruction des points 3D
X = []; % Contient les coordonnees des points en 3D
color = []; % Contient la couleur associee
% Pour chaque couple de points apparies
for i = 1:size(pts,1)
    % Recuperation des ensembles de points apparies
    l = find(pts(i,1:2:end)~=-1);
    % Verification qu'il existe bien des points apparies dans cette image
    if size(l,2) > 1 & max(l)-min(l) > 1 & max(l)-min(l) < 36
        A = [];
        R = 0;
        G = 0;
        B = 0;
        % Pour chaque point recupere, calcul des coordonnees en 3D
        for j = l
            A = [A;P{j}(1,:)-pts(i,(j-1)*2+1)*P{j}(3,:);
            P{j}(2,:)-pts(i,(j-1)*2+2)*P{j}(3,:)];
            R = R + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),1,j));
            G = G + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),2,j));
            B = B + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),3,j));
        end;
        [U,S,V] = svd(A);
        X = [X V(:,end)/V(end,end)];
        color = [color [R/size(l,2);G/size(l,2);B/size(l,2)]];
    end;
end;
fprintf('Calcul des points 3D termine : %d points trouves. \n',size(X,2));

%affichage du nuage de points 3D
figure('Name','Nauge de points 3D','NumberTitle','off');
hold on;
for i = 1:size(X,2)
    scatter3(X(1,i),X(2,i),X(3,i),'.','col',color(:,i)/255);
end
axis equal;

%% Tetraedrisation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A COMPLETER                  %
% Tetraedrisation de Delaunay  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = delaunayTriangulation(X(1:3,:)');

% A DECOMMENTER POUR AFFICHER LE MAILLAGE
fprintf('Tetraedrisation terminee : %d tetraedres trouves. \n',size(T,1));
% Affichage de la tetraedrisation de Delaunay
figure('Name','Tétraèdre','NumberTitle','off');
tetramesh(T);

%% Calcul des barycentres

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A DECOMMENTER ET A COMPLETER %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul des barycentres de chacun des tetraedres
poids = ones(1,4) / 4;
nb_barycentres = 1;
for i = 1:size(T,1)
    % Calcul des barycentres differents en fonction des poids differents
    % En commencant par le barycentre avec poids uniformes
    C_g(:,i,1) = [barycentre(T, i) 1]';
end
%%
% A DECOMMENTER POUR VERIFICATION
% A RE-COMMENTER UNE FOIS LA VERIFICATION FAITE
% Visualisation pour vérifier le bon calcul des barycentres
%for i = 1:nb_images
%   for k = 1:nb_barycentres 
%       o = P{i}*C_g(:,:,k);
%       o = o./repmat(o(3,:),3,1);
%       imshow(im_mask(:,:,i));
%       hold on;
%       plot(o())
%       pause;
%       close;
%   end
%end

%% Filtrage des barycentres

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A DECOMMENTER ET A COMPLETER %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Copie de la triangulation pour pouvoir supprimer des tetraedres
tri=T.ConnectivityList;
% Retrait des tetraedres dont au moins un des barycentres
% ne se trouvent pas dans au moins un des masques des images de travail
% Pour chaque barycentre
to_delete = [];
already_eleminated = zeros(1, size(T,1));
for k=1:nb_barycentres
    barycentre_k = C_g(:,:,k);
    for i=1:nb_images
        bary_proj = P{i}*barycentre_k;
        bary_proj = bary_proj./repmat(bary_proj(3,:),3,1);
        for j=1:size(bary_proj,2)
            if ~ already_eleminated(1,j)
                x = floor(bary_proj(1, j));
                y = floor(bary_proj(2, j));
                if ~im_mask(x, y , i)
                    to_delete = [to_delete j];
                    already_eleminated(1, j) = 1;
                end
            end
        end
    end
end


to_delete = unique(to_delete);

tri(to_delete, :) = [];

%% Affichage

% A DECOMMENTER POUR AFFICHER LE MAILLAGE RESULTAT
% Affichage des tetraedres restants
fprintf('Retrait des tetraedres exterieurs a la forme 3D termine : %d tetraedres restants. \n',size(tri,1));
figure('Name','Après filtrage des tétraèdres','NumberTitle','off');
trisurf(tri,X(1,:),X(2,:),X(3,:));

%% Construction maillage final
% Sauvegarde des donnees
% save donnees;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSEIL : A METTRE DANS UN AUTRE SCRIPT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calcul des faces du maillage à garder
FACES = zeros(size(tri,1)*size(tri,2),3);

for tetra=1:size(tri,1)
    FACES((tetra - 1)*4 + 1,:) = tri(tetra,1:3);
    FACES((tetra - 1)*4 + 2,:) = [tri(tetra,1:2) tri(tetra,4)];
    FACES((tetra - 1)*4 + 3,:) = [tri(tetra,1) tri(tetra,3:4)];
    FACES((tetra - 1)*4 + 4,:) = tri(tetra,2:4);
end

FACES = sort(FACES,2);
FACES_TRIEES = sortrows(FACES);

face = 1;
faceP1del = false;
to_delete = [];
while face < size(FACES,1)
    if (faceP1del)
        if (sum(FACES_TRIEES(face,:) == FACES_TRIEES(face+1,:)) == 3)
            to_delete = [to_delete face+1];
            faceP1del = true;
        else
            faceP1del = false;
        end
    else
        if (sum(FACES_TRIEES(face,:) == FACES_TRIEES(face+1,:)) == 3)
            to_delete = [to_delete face face+1];
            faceP1del = true;
        end
    end
    face = face + 1;
end

FACES_TRIEES(to_delete,:) = [];
FACES = FACES_TRIEES;

fprintf('Calcul du maillage final termine : %d faces. \n',size(FACES,1));

% Affichage du maillage final
figure('Name','Maillage final','NumberTitle','off');
hold on
grid on
for i = 1:size(FACES,1)
   plot3([X(1,FACES(i,1)) X(1,FACES(i,2))],[X(2,FACES(i,1)) X(2,FACES(i,2))],[X(3,FACES(i,1)) X(3,FACES(i,2))],'r');
   plot3([X(1,FACES(i,1)) X(1,FACES(i,3))],[X(2,FACES(i,1)) X(2,FACES(i,3))],[X(3,FACES(i,1)) X(3,FACES(i,3))],'r');
   plot3([X(1,FACES(i,3)) X(1,FACES(i,2))],[X(2,FACES(i,3)) X(2,FACES(i,2))],[X(3,FACES(i,3)) X(3,FACES(i,2))],'r');
end
