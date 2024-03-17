function afficher(matriceDonnees,Adj, titre, enregistre)
% Afficher la représentation 3D d'un graphe à partir de sa matrice
% d'adjacence et des coordonnées

figure;
plot3(matriceDonnees(:, 1), matriceDonnees(:, 2), matriceDonnees(:, 3), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'b');
grid on
xlabel('X');
ylabel('Y');
zlabel('Z');
title(titre);
[x, y, z] = find(triu(Adj));
arcs = [x y z];
hold on;
for i = 1:size(arcs, 1)
    plot3([matriceDonnees(arcs(i, 1), 1), matriceDonnees(arcs(i, 2), 1)], ...
          [matriceDonnees(arcs(i, 1), 2), matriceDonnees(arcs(i, 2), 2)], ...
          [matriceDonnees(arcs(i, 1), 3), matriceDonnees(arcs(i, 2), 3)], 'r-');
end
hold off;
if enregistre
    saveas(gcf,"tracer/" + titre + ".png")
end

end
