function [config, T, lambda] = morts_naissances(lambda,gamma,S,config_init,T)
    config = config_init;

    % Naissances
    N = poissrnd(lambda);

    for i=1:N
        c_i = [nb_colonnes*rand nb_lignes*rand];
        config(end + 1) = c_i; 
    end

    % Tri des disques
    I_moyen = calcul_I_moyen();

    expo = exp(-gamma .* (I_moyen ./ S - 1));
    U_i = 2 / (1 + expo);
    U_i = 1 - U_i;

    sorted_config = sortrows([config U_i], 3);
    U_i = sorted_config(:,3);
    config = sorted_config(:,1:2);

    % Morts
    config_pre_death = config;
    for i=1:length(config)
        proba = lambda / (lambda + exp(U_i(i) / T));

        if rand(1) < proba
            config(i) = [];
        end
    end

    % Test de convergance
    if prod(config == config_pre_death, 'all')
        lambda = alpha * lambda;
        T = alpha * T;
    end

end