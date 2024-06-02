function [x,y] = EF(x,y,Nx,Ny,Fx,Fy)
    % Matrice de rotation
    R = [0 1; -1 0];

    F = [Fx Fy];
    A = R' * F;

    S = A * [Nx Ny];

    x = x + S(1) * Nx;
    y = y + S(2) * Ny;
end