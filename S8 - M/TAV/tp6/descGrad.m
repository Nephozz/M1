function [x,y] = descGrad(x, y, Nx, Ny, g)
    kappa = div(Nx,Ny);
    
    beta_x = g*kappa - (gradient(g) * Nx);
    beta_y = (g*kappa) - (gradient(g) * Ny);

    x = x + beta_x;
    y = y + beta_y;
end