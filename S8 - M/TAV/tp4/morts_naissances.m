function [config, T, lambda, Uc] = morts_naissances(lambda,config_init,T,I,R)
    alpha = 0.99;
    beta = 1;
    S = 140;
    gamma = 5;
    config = config_init;

    [nb_lignes,nb_colonnes] = size(I);

    % Naissances
    N = poissrnd(lambda);
    for i=1:N
        c_i = [nb_colonnes*rand nb_lignes*rand];
        config(end + 1,:) = c_i; 
    end

    N = length(config);

    % Tri des disques
    I_moyen = arrayfun(@(i) calcul_I_moyen(I, config(i,:), R), 1:N);

    expo = exp(-gamma .* (I_moyen ./ S - 1));
    U_i = 2 ./ (1 + expo);
    U_i = 1 - U_i;

    [~, sorted_indices] = sort(U_i);
    config = config(sorted_indices, :);
    U_i = U_i(sorted_indices);
    % Morts
    config_pre_death = config;
    i = 1;
    voisins = [];
    while i < length(config)
        c_k = config - config(i,:);
        voisins(end + 1) = sum(c_k(:,1).^2 + c_k(:,2).^2 <= 2 * R^2) - 1;
        proba = lambda / (lambda + exp( -1 * ((U_i(i) + beta * voisins(end)) / T)));
        
        if rand < proba
            config(i,:) = [];
            voisins(end) = [];
            continue
        end
        i = i + 1;
    end

    Uc = sum(U_i) + beta * sum(voisins);

    % Test de convergance
    if isequal(size(config), size(config_pre_death)) && isequal(config, config_pre_death)
            return
    end

    lambda = alpha * lambda;
    T = alpha * T;

end