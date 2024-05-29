function paires = appariement(pics_t, pics_f, n_v, delta_t, delta_f)
    paires = [];

    for i = 1:size(pics_t, 1)
        diff_t = pics_t - pics_t(i);
        diff_f = pics_f - pics_f(i);
        voisins = find((abs(diff_f)<= delta_f) & (0 < diff_t ) & (diff_t < delta_t),n_v);

        for ind = 1:size(voisins, 1)
            j = voisins(ind);
            paires = [paires ; [pics_f(i) pics_f(j) pics_t(i) pics_t(j)]];
        end
    end
end