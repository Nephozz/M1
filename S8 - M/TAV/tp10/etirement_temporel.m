function y_modifie = etirement_temporel(y, f_ech, pourc)
    
    Y = TFCT(y,f_ech,2048,512,'hann');

    C = 1:pourc:size(Y,2);
    ang = angle(Y(:,1));
    y_modifie = zeros(size(Y,1),length(C));

    for i = 1:length(C)-1
        c = floor(C(i));
        alpha = C(i) - c;
        rho = (1-alpha)*abs(Y(:,c)) + alpha*abs(Y(:,c+1));
        y_modifie(:,i) = rho.*exp(1j.*ang);
        d_ang = (angle(Y(:,c+1)) - angle(Y(:,c)));
        ang = ang + d_ang;
    end
    y_modifie = ITFCT(y_modifie,f_ech,2048,512,'hann');
end