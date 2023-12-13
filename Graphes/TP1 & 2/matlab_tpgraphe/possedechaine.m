function bool = possedechaine(G,c)
%POSSEDECHAINE Summary of this function goes here
%   Detailed explanation goes here
    bool = true;
    i = 2;
    while bool && i <= length(c)
        bool = G(c(i-1), c(i));
        i = i + 1;
    end
end

