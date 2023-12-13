function bool = isEulerien(G)
%ISEULERIEN Summary of this function goes here
%   Detailed explanation goes here
    bool = false;
    A = G > 0;
    isConnected = prod(graphPower(A,size(A,1)),"all");
    if isConnected
        bool = true;
        degG = sum(A, 1);
        nbImpair = 0;
        for i = 1:length(degG)
            if mod(degG(i),2)
                nbImpair = nbImpair + 1;
            end
        end
        if nbImpair ~= 2 && nbImpair ~= 0 
            bool = false;
        end
    end
end

