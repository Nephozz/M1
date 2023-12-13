%%%%% SET ENV %%%%%

addpath('matlab_bgl');      %load graph libraries
addpath('matlab_tpgraphe'); %load tp ressources

load TPgraphe.mat;          %load data

%%%%%% DISPLAY INPUT DATA ON TERMINAL %%%%%

cities %names of cities
D      %distance matrix bw cities
pos    %x-y pos of the cities

%%%%%%EXO 1 (modeliser et afficher le graphe) %%%%%

A=D <= 500; %adj matrix
%viz_adj(D,A,pos,cities);
%viz_adj(D,graphPower(A,2),pos,cities);
%viz_adj(D,graphPower(A,3),pos,cities);
%viz_adj(D,graphPower(A,10),pos,cities);
%viz_adj(D,graphPower(A,12),pos,cities);

%%%%%% EXO 2 %%%%%

%Q1 - existence d'un chemin de longueur 3
existance_chemin_longueur3 = bmul(A,bmul(A,A));
%viz_adj(D,existance_chemin_longueur3,pos,cities)

%Q2 - nb de chemins de 3 sauts
nbCheminde3 = A*A*A;
sum(nbCheminde3,"all")

%Q3 - nb de chemins <=3
nbCheminInf3 = A + A*A + A*A*A;
sum(nbCheminInf3,"all")

%%%%%%%% EXO 3 %%%%%
c=[18 13 9]; %la chaine 18 13 9 est t dans le graphe?
possedechaine(A,c)
c=[18 6 3]; %la chaine 18 6 3 est t dans le graphe?
possedechaine(A,c)
c=[26 5 17]; %la chaine 26 5 17 est t dans le graphe?
possedechaine(A,c)

%%%%%%%% EXO 4%%%%%
isEulerien(A)

%%%%%%%% EXO 5%%%%%
porteeEulerien(D)
