%% Récupération Données
matriceDonnees_low = readmatrix("topology_low.csv");
matriceDonnees_avg = readmatrix("topology_avg.csv");
matriceDonnees_high = readmatrix("topology_high.csv");

addpath('matlab_bgl');      

matriceDonnees_low = matriceDonnees_low(:,2:4);
name = matriceDonnees_low(:,1);
name = num2str(name);
nombrePoints = size(matriceDonnees_low, 1);
matriceDistances_low = zeros(nombrePoints);
for i = 1:nombrePoints
    for j = 1:nombrePoints
        matriceDistances_low(i, j) = sqrt(sum((matriceDonnees_low(i, :) - matriceDonnees_low(j, :)).^2));
    end
end

A_low = matriceDistances_low < 20000;
B_low = matriceDistances_low < 40000; 
C_low = matriceDistances_low < 60000;

matriceDonnees_avg = matriceDonnees_avg(:,2:4);
nombrePoints = size(matriceDonnees_avg, 1);
matriceDistances_avg = zeros(nombrePoints);
for i = 1:nombrePoints
    for j = 1:nombrePoints
        matriceDistances_avg(i, j) = sqrt(sum((matriceDonnees_avg(i, :) - matriceDonnees_avg(j, :)).^2));
    end
end

A_avg = matriceDistances_avg < 20000;
B_avg = matriceDistances_avg < 40000; 
C_avg = matriceDistances_avg < 60000;

matriceDonnees_high = matriceDonnees_high(:,2:4);
nombrePoints = size(matriceDonnees_high, 1);
matriceDistances_high = zeros(nombrePoints);
for i = 1:nombrePoints
    for j = 1:nombrePoints
        matriceDistances_high(i, j) = sqrt(sum((matriceDonnees_high(i, :) - matriceDonnees_high(j, :)).^2));
    end
end

A_high = matriceDistances_high < 20000;
B_high = matriceDistances_high < 40000; 
C_high = matriceDistances_high < 60000;

