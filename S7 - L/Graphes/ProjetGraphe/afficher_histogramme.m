function afficher_histogramme(donnee1,donnee2,donnee3,coef1,coef2,coef3, titre,enregistrer,nom_fichier)

figure;
h1 = histogram(donnee1, coef1, 'FaceColor', 'r', 'FaceAlpha', 0.5);
hold on;
h2 = histogram(donnee2, coef2, 'FaceColor', 'b', 'FaceAlpha', 0.5);
h3 = histogram(donnee3, coef3, 'FaceColor', 'g', 'FaceAlpha', 0.5);
legend('20km','40km','60km')
title(titre)
if enregistrer
    saveas(gcf,nom_fichier);
end
hold off;