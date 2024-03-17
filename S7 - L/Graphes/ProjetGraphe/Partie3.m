close all
run donnees.m

[~,~,~,~,~,~,~,~,Low_d] = etude_graphes_values(C_low, matriceDistances_low);
[~,~,~,~,~,~,~,~,Avg_d] = etude_graphes_values(C_avg, matriceDistances_avg);
[~,~,~,~,~,~,~,~,High_d] = etude_graphes_values(C_high, matriceDistances_high);


%% Etude des graphes valués

%Longueur
afficher_heatmap(Low_d,'Low (60km) Carte de chaleur des plus courts chemins','','',false,"value_carte_low.png")
afficher_heatmap(Avg_d,'Avg (60km) Carte de chaleur des plus courts chemins','','',false,"value_carte_avg.png")
afficher_heatmap(High_d,'High (60km) Carte de chaleur des plus courts chemins','','',false,"value_carte_high.png")

%Distribution
Low_d(Low_d == 0) = []; 
Avg_d(Avg_d == 0) = []; 
High_d(High_d == 0) = []; 
afficher_histogramme(Low_d,Avg_d,High_d,10,10,10,"Distribution des plus courts chemins valués pour différentes distances ",false,"histo_chemin_value.png")
