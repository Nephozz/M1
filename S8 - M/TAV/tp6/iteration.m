function [x,y] = iteration(x,y,Fx,Fy,gamma,A)

    indices = sub2ind(size(Fx), floor(y)+1, floor(x)+1);
    B_x = -gamma * Fx(indices);
    B_y = -gamma * Fy(indices);

    x = A*x + B_x;
    y = A*y + B_y;
end