function probas = probabilites_EM(D_app,parametres,proportion_1,proportion_2,sigma)
    n = length(D_app);
    probas = zeros(2,n);

    r1 = calcul_r(D_app,parametres(1,:));
    r2 = calcul_r(D_app,parametres(2,:));

    expo1 = exp(-(r1.^2)/(2 * sigma^2));
    p1 = (proportion_1 / sigma) .* expo1;
    
    expo2 = exp(-(r2.^2)/(2 * sigma^2));
    p2 = (proportion_2 / sigma) .* expo2;

    probas(1,:) = p1 ./ (p1 + p2);
    probas(2,:) = p2 ./ (p1 + p2);
end