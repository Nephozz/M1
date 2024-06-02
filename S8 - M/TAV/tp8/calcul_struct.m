function [u_kp1] = calcul_struct(u_k,u,Dx,Dy,phi,epsilon,mu_prime,gamma)

    nb_lignes = size(u_k,1);
    nb_colonnes = size(u_k,2);
    
    u_kp1 = reshape(u_k,[],1);
    ux_barre = Dx * u_kp1;
    uy_barre = Dy * u_kp1;
    uxx_barre = -Dx'*Dx*u_kp1;
    uyy_barre = -Dy'*Dy*u_kp1;
    uxy_barre = -Dx'*Dy*u_kp1;

    div = (uxx_barre.*(uy_barre.^2 + epsilon) + uyy_barre.*(ux_barre.^2 + epsilon) - 2.*ux_barre.*uy_barre.*uxy_barre)./((ux_barre.^2 + uy_barre.^2 + epsilon).^(3/2));
    div = reshape(div,nb_lignes,nb_colonnes);

    u_kp1 = u_k - gamma .* real(ifftshift(ifft2(phi*(fftshift(u_k) - fftshift(u)))) - mu_prime .* div);
    u_kp1 = reshape(u_kp1,nb_lignes,nb_colonnes);
end