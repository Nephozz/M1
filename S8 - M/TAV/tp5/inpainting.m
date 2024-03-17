function u_kp1 = inpainting(b,u_k,lambda,Dx,Dy,epsilon,u_D)
    N = size(u_k,1);

    grad_Ux = Dx * u_k;
    grad_Uy = Dy * u_k;

    e = 1 ./ sqrt(grad_Ux.^2 + grad_Uy.^2 + epsilon);
    Wk = spdiags(e,0,N,N);

    Xd = double(u_D == 0);
    Xd = Xd(:);
    WoD = spdiags(Xd,0,N,N);

    Ak = WoD - lambda * (-(Dx' * Wk * Dx) - (Dy' * Wk * Dy));
    b = WoD * b;

    u_kp1 = Ak\b;
end
