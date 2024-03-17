function afficher_heatmap(Adj,titre,x,y,enregistrer,nom_fichier)
new_colormap = [0 0 0; jet(64)]; 

figure; 
imagesc(Adj); 
colormap(new_colormap); 
colorbar; 
title(titre);
xlabel(x); 
ylabel(y);
if enregistrer
    saveas(gcf,nom_fichier);
end