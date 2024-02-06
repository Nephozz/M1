function out = max_vraisemblance_2(D_app,parametres,sigma)
    n = length(parametres);

    vraisemblance = zeros(1,n);
    for i = 1:n
        r1 = calcul_r(D_app,parametres(i,1,:));
        expo1 = exp(-(r1.^2)./(2 * sigma^2));
        p1 = (0.5 / sigma) .* expo1;

        r2 = calcul_r(D_app,parametres(i,2,:));
        expo2 = exp(-(r2.^2)./(2 * sigma^2));
        p2 = (0.5 / sigma) .* expo2;

        vraisemblance(i) = sum(log(p1 + p2));
    end
    [~, i] = max(vraisemblance);

    out = parametres(i,:,:);
end