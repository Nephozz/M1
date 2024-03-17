function [degre,degre_moyen,C,clust_moyen,nombre_clique,ordre_clique,nombre_connexe,ordre_connexe,A, nb_plus_court_chemins] = etude_graphes_non_values(Adj)

    %% Degré 
    degre = sum(Adj - eye(size(Adj)),2);
    degre_moyen = mean(degre);

    %% Clustering    
    C = clustering_coefficients(sparse(Adj));
    clust_moyen = mean(C);

    %% Clique
    % Ancien algorithme
    % https://fr.mathworks.com/matlabcentral/fileexchange/34202-k-clique-algorithm
    %[~,Y,~] = k_clique(100, Adj);

    % Nouveau
    %https://fr.mathworks.com/matlabcentral/fileexchange/47524-find-maximal-cliques-for-large-sparse-network
    MC = ELSclique(Adj -eye(size(Adj)) );
    sommes_colonnes = sum(MC, 1);
    colonnes_a_garder = sommes_colonnes >= 2;
    MC = MC(:, colonnes_a_garder);
    nombre_clique = size(MC,2);
    ordre_clique = sum(MC, 1);
    ordre_clique(ordre_clique == 1) = 0;

    %% Composantes connexes
    [ci ,sizes] = components(sparse(Adj));
    nombre_connexe = max(ci);
    ordre_connexe = sizes;

    %% Plus court chemin 
    D = all_shortest_paths(sparse(double(Adj)), struct('algname', 'auto'));
    % Nombre de plus court chemin depuis chaque sommet
    D(isinf(D)) = 0;
    D(D == 0) = 0;
    nb_plus_court_chemins = sum(D ~= 0, 2);
    A = sparse(D);
    
end