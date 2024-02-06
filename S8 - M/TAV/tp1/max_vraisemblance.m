function out = max_vraisemblance(D_app,parametres)
    n = length(parametres);

    vraisemblance = zeros(1,n);
    for i = 1:n
        r = calcul_r(D_app,parametres(i,:));
        vraisemblance(i) = sum(r.^2);
    end
    [~, i] = min(vraisemblance);

    out = parametres(i,:);
end