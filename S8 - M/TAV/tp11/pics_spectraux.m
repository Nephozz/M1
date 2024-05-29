function [pics_t, pics_f] = pics_spectraux(S, eta_t, eta_f, epsilon)
    voisins = strel("rectangle", [eta_t, eta_f]);

    Smax = imdilate(S, voisins);

    [pics_f, pics_t] = find((Smax == S) & (S > epsilon));
end