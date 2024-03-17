function u_kp1 = debruitage(b,u_k,lambda,Dx,Dy,epsilon)
    N = size(u_k,1);

    grad_Ux = Dx * u_k;
    grad_Uy = Dy * u_k;

    e = 1 ./ sqrt(grad_Ux.^2 + grad_Uy.^2 + epsilon);
    Wk = spdiags(e,0,N,N);

    Ak = speye(N) - lambda * (-(Dx' * Wk * Dx) - (Dy' * Wk * Dy));

    u_kp1 = Ak\b;
end
