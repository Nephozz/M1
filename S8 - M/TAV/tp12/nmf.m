function [D,A] = nmf(S,D_0,A_0,k)
    A = A_0;
    D = D_0;

    for i=1:k
        A = A .* (D' * S) ./ (D' * D * A);
        D = D .* (S * A') ./ ((D * A) * A');
    end
end