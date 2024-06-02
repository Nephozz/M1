function Y_modifie = compression_avance(Y)

    %Y_modifie_1 = compression(Y,100);
    Y_modifie_1 = Y;

    for i = 1:2:size(Y_modifie_1,2)
        Y_modifie(:,i) = Y_modifie_1(:,i);
    end

end