function Y_modifie = passe_haut(Y, valeurs_f, fc)
    f_mask = find(valeurs_f < fc);
    
    Y(f_mask, :) = 0;

    Y_modifie = Y;
end