function [P,argument] = estimation_poids(mu_test,sigma_test,liste_nvg,F)
    n = length(liste_nvg);
    N = length(mu_test);

    A = zeros(n, N);

    for i=1:N
        A(:,i) = exp((liste_nvg - mu_test(i)).^2 ./ (2 * sigma_test(i).^2)) ./ (sqrt(2) * sigma_test(i));
    end

    P = A\F;

    argument = sum(A*P);
end