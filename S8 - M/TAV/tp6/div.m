function f = div(nx,ny)
    [nxx,~]=gradient(nx);  
    [~,nyy]=gradient(ny);
    f=nxx+nyy;
end