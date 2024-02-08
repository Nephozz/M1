function X = moindres_carres_ponderes(D_app,probas)
    n = length(D_app);

    A = zeros(n,6);
    A(:,1) = D_app(1,:)' .^2;
    A(:,2) = D_app(1,:)' .* D_app(2,:)';
    A(:,3) = D_app(2,:)' .^2;
    A(:,4) = D_app(1,:)';
    A(:,5) = D_app(2,:)';
    A(:,6) = ones(1,n);

    A = A .* probas'; 
    new_A = [A; 1 0 1 0 0 0];

    B = [zeros(n,1); 1];

    X = new_A\B;
end

