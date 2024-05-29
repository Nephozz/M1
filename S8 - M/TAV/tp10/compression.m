function [Y_modifie,taux_compression] = compression(Y, m)
    Y_modifie = zeros(size(Y,1),size(Y,2));

    [~, ind] = maxk(abs(Y), m, 1);

    for i = 1:size(Y,2)
        Y_modifie(ind(:,i), i) = Y(ind(:,i),i);
    end

    taux_compression = size(Y,1) / m;
end