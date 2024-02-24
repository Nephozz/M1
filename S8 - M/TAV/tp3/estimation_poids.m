function [P,argument] = estimation_poids(mu_test,sigma_test,liste_nvg,F)
    expo = exp(-((repmat(liste_nvg',1,size(mu_test,2)) - mu_test).^2)./(2*(sigma_test.^2)));

    A = (expo./(sigma_test.*(sqrt(2*pi))));

    P = A\F';

    somme_classe = sum(A*P,2);

    argument = sum(F' - somme_classe,1);
end