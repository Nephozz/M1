function afficher_superposition(Low,Avg,High,titre,y,enregistrer,nom_fichier)

figure();
distance = [20,40,60];
plot(distance,Low, 'r')
hold on
plot(distance,High,'g')
plot(distance,Avg, 'b')
s1 =scatter(distance, Low, 'r', 'filled', 'DisplayName', 'Low');
s2 =scatter(distance, Avg, 'b', 'filled', 'DisplayName', 'Average');
s3 =scatter(distance, High, 'g', 'filled', 'DisplayName', 'High');
xlim([15,65])
legend([s1, s2, s3], 'Location', 'best')
title(titre)
xlabel('Distance')
ylabel(y)
hold off
if enregistrer
    saveas(gcf, nom_fichier);
end