function [config, T, lambda, Uc] = morts_naissances_ellipse(lambda, config_init, T, I, R)
    alpha = 0.99;
    beta = 1;
    S = 140;
    gamma = 5;
    config = config_init;

    [nb_lignes, nb_colonnes] = size(I);

    % Naissances
    N = poissrnd(lambda);
    for i = 1:N
        c_i = [nb_colonnes * rand, nb_lignes * rand, pi * rand]; % ajout de l'angle aléatoire theta
        config(end + 1, :) = c_i;
    end

    N = size(config, 1);

    % Tri des disques en fonction de la nouvelle marque
    I_moyen = arrayfun(@(i) calcul_I_moyen_ellipse(I, config(i, 1:2), R, config(i, 3)), 1:N);

    expo = exp(-gamma * (I_moyen / S - 1));
    U_i = 2 ./ (1 + expo);
    U_i = 1 - U_i;

    [~, sorted_indices] = sort(U_i);
    config = config(sorted_indices, :);
    U_i = U_i(sorted_indices);

    % Morts
    config_pre_death = config;
    i = 1;
    voisins = [];
    while i <= size(config, 1)
        c_k = config(:, 1:2) - config(i, 1:2);
        distances = sqrt(sum(c_k.^2, 2));
        voisins(end + 1) = sum(distances <= sqrt(2) * R) - 1;
        proba = lambda / (lambda + exp(-1 * ((U_i(i) + beta * voisins(end)) / T)));

        if rand < proba
            config(i, :) = [];
            voisins(end) = [];
            continue
        end
        i = i + 1;
    end

    Uc = sum(U_i) + beta * sum(voisins);

    % Test de convergence
    if isequal(size(config), size(config_pre_death)) && isequal(config, config_pre_death)
        return
    end

    lambda = alpha * lambda;
    T = alpha * T;
end
