close all
run donnees.m

%% Etude des graphes non valués

%% Récupération des différents résultats
[degre1,degre_moyen1,C1,clust_moyen1,nombre_clique1,ordre_clique1,nombre_connexe1,ordre_connexe1,A1,nb_plus_court_chemins1] = etude_graphes_non_values(A_low);
[degre2,degre_moyen2,C2,clust_moyen2,nombre_clique2,ordre_clique2,nombre_connexe2,ordre_connexe2,A2,nb_plus_court_chemins2] = etude_graphes_non_values(A_avg);
[degre3,degre_moyen3,C3,clust_moyen3,nombre_clique3,ordre_clique3,nombre_connexe3,ordre_connexe3,A3,nb_plus_court_chemins3] = etude_graphes_non_values(A_high);
[degre12,degre_moyen12,C12,clust_moyen12,nombre_clique12,ordre_clique12,nombre_connexe12,ordre_connexe12,A12,nb_plus_court_chemins12] = etude_graphes_non_values(B_low);
[degre22,degre_moyen22,C22,clust_moyen22,nombre_clique22,ordre_clique22,nombre_connexe22,ordre_connexe22,A22,nb_plus_court_chemins22] = etude_graphes_non_values(B_avg);
[degre32,degre_moyen32,C32,clust_moyen32,nombre_clique32,ordre_clique32,nombre_connexe32,ordre_connexe32,A32,nb_plus_court_chemins32] = etude_graphes_non_values(B_high);
[degre13,degre_moyen13,C13,clust_moyen13,nombre_clique13,ordre_clique13,nombre_connexe13,ordre_connexe13,A13,nb_plus_court_chemins13] = etude_graphes_non_values(C_low);
[degre23,degre_moyen23,C23,clust_moyen23,nombre_clique23,ordre_clique23,nombre_connexe23,ordre_connexe23,A23,nb_plus_court_chemins23] = etude_graphes_non_values(C_avg);
[degre33,degre_moyen33,C33,clust_moyen33,nombre_clique33,ordre_clique33,nombre_connexe33,ordre_connexe33,A33,nb_plus_court_chemins33] = etude_graphes_non_values(C_high);



%% Degré

afficher_histogramme(degre1,degre12,degre13,10,20,40,"Low : Distribution des dégrés pour différentes distances ",false,"histo_degre_low.png")
afficher_histogramme(degre2,degre22,degre23,10,20,40,"Avg : Distribution des dégrés pour différentes distances ",false,"histo_degre_avg.png")
afficher_histogramme(degre3,degre32,degre33,10,20,40,"Avg : Distribution des dégrés pour différentes distances ",false,"histo_degre_high.png")
Low = [degre_moyen1,degre_moyen12,degre_moyen13];
Avg = [degre_moyen2,degre_moyen22,degre_moyen23];
High = [degre_moyen3,degre_moyen32,degre_moyen33];
afficher_superposition(Low,Avg,High,"Evolution du degré moyen",'Degré moyen',false,'degre_evolution.png')


%% Clustering

Low = [clust_moyen1,clust_moyen12,clust_moyen13];
Avg = [clust_moyen2,clust_moyen22,clust_moyen23];
High = [clust_moyen3,clust_moyen32,clust_moyen33];
afficher_superposition(Low,Avg,High,"Evolution du clustering moyen",'Clustering moyen',false,'degre_clustering.png')

afficher_histogramme(C1,C12,C13,40,40,40,"Low : Distribution des degrés de clustering pour différentes distances",false,"histo_clust_low.png")
afficher_histogramme(C2,C22,C23,40,40,40,"Avg : Distribution des degrés de clustering pour différentes distances",false,"histo_clust_avg.png")
afficher_histogramme(C3,C32,C33,40,40,40,"High : Distribution des degrés de clustering pour différentes distances",false,"histo_clust_high.png")

%% Clique
afficher_histogramme(ordre_clique1,ordre_clique12,ordre_clique13,10,10,10,"Low : Distribution des cliques pour différentes distances ",false,"histo_clique_low.png")
afficher_histogramme(ordre_clique2,ordre_clique22,ordre_clique23,10,20,20,"Avg : Distribution des cliques pour différentes distances ",false,"histo_clique_avg.png")
afficher_histogramme(ordre_clique3,ordre_clique32,ordre_clique33,10,10,10,"High : Distribution des cliques pour différentes distances ",false,"histo_clique_high.png")

Low = [nombre_clique1,nombre_clique12,nombre_clique13];
Avg = [nombre_clique2,nombre_clique22,nombre_clique23];
High = [nombre_clique3,nombre_clique32,nombre_clique33];
afficher_superposition(Low,Avg,High,"Evolution du nombre de clique",'Nombre de clique',false,'clique__evolution.png')


%% Composante connexes 
% Nombre de composantes connexes
Low = [nombre_connexe1,nombre_connexe12,nombre_connexe13];
Avg = [nombre_connexe2,nombre_connexe22,nombre_connexe23];
High = [nombre_connexe3,nombre_connexe32,nombre_connexe33];
afficher_superposition(Low,Avg,High,"Evolution du nombre de composantes connexes",'Nombre de composantes connexes',false,'composante_connexe_comp.png')

% Distribution ordre composantes connexes 
afficher_histogramme(ordre_connexe1,ordre_connexe12,ordre_connexe13,40,40,40,"Low : Distribution des ordres des composantes connexes ",false,"histo_connexe_low.png")
afficher_histogramme(ordre_connexe2,ordre_connexe22,ordre_connexe23,40,40,40,"Avg : Distribution des ordres des composantes connexes ",false,"histo_connexe_avg.png")
afficher_histogramme(ordre_connexe3,ordre_connexe32,ordre_connexe33,40,40,40,"High : Distribution des ordres des composantes connexes ",false,"histo_connexe_high.png")


%% Cout chemin

%LOW
afficher_heatmap(A1,'Low (20km) Carte de chaleur des plus courts chemins','','',false,"carte_low_20.png")
afficher_heatmap(A12,'Low (40km) Carte de chaleur des plus courts chemins','','',false,"carte_low_40.png")
afficher_heatmap(A13,'Low (60km) Carte de chaleur des plus courts chemins','','',false,"carte_low_60.png")
A1(A1 == 0) = []; 
A12(A12 == 0) = []; 
A13(A13 == 0) = []; 
afficher_histogramme(triu(A1),triu(A12),triu(A13),10,10,10,"Low : Distribution des plus courts chemins pour différentes distances ",false,"histo_chemin_low.png")

%AVG
afficher_heatmap(A2,'Avg (20km) Carte de chaleur des plus courts chemins','','',false,"carte_Avg_20.png")
afficher_heatmap(A22,'Avg (40km) Carte de chaleur des plus courts chemins','','',false,"carte_Avg_40.png")
afficher_heatmap(A23,'Avg (60km) Carte de chaleur des plus courts chemins','','',false,"carte_Avg_60.png")
A2(A2 == 0) = []; 
A22(A22 == 0) = []; 
A23(A23 == 0) = []; 
afficher_histogramme(triu(A2),triu(A22),triu(A23),10,10,10,"Avg : Distribution des plus courts chemins pour différentes distances ",false,"histo_chemin_avg.png")

%HIGH
afficher_heatmap(A3,'High (20km) Carte de chaleur des plus courts chemins','','',false,"carte_High_20.png")
afficher_heatmap(A32,'High (40km) Carte de chaleur des plus courts chemins','','',false,"carte_High_40.png")
afficher_heatmap(A33,'High (60km) Carte de chaleur des plus courts chemins','','',false,"carte_High_60.png")
A3(A3 == 0) = []; 
A32(A32 == 0) = []; 
A33(A33 == 0) = []; 
afficher_histogramme(triu(A3),triu(A32),triu(A33),10,10,10,"High : Distribution des plus courts chemins pour différentes distances ",false,"histo_chemin_high.png")


