function k = recuit_simule(ks, AD, beta, T)
    [height, width, N] = size(AD); 

    k = ks;

    for i = 1:height
        for j = 1:width
            ks_prime = randi(N);
            while ks_prime == k(i,j)
                ks_prime = randi(N);
            end
            AD_ks = AD(i, j, ks(i, j));
            AD_ks_prime = AD(i, j, ks_prime);

            voisins = ks(max(i-1, 1):min(i+1, height), max(j-1, 1):min(j+1, width));
            voisins_prime = voisins == ks_prime;
            voisins = voisins == ks(i,j);

            Us = AD_ks + beta * (sum(1 - voisins(:)) - 1);
            Us_prime = AD_ks_prime + beta * (sum(1 - voisins_prime(:)) - 1);

            if Us_prime < Us
                k(i, j) = ks_prime;
            else
                if rand(1) < exp(-(Us_prime - Us) / T)
                    k(i, j) = ks_prime;
                end
            end

        end
    end

end