function probas = probabilites_EM(D_app,parametres,sigma)
    n = length(D_app);
    probas = zeros(2,n);

    r1 = calcul_r(D_app,parametres(1,:));
    r2 = calcul_r(D_app,parametres(2,:));

    for i = 1:n
        expo1 = exp(-(r1(i)^2)/(2 * sigma^2));
        p1 = (0.5 / sigma) * expo1;
        probas(1,i) = p1;

        expo2 = exp(-(r2(i)^2)/(2 * sigma^2));
        p2 = (0.5 / sigma) * expo2;
        probas(2,i) = p2;
    end
end