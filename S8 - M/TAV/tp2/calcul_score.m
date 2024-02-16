function score = calcul_score(Y_pred,Y)
    perm = perms(unique(Y));
    n = length(perm);
    scores = zeros(n,1);

    for i = 1:n
        permuted = perm(i,:);
        new_Y = Y;
        for j = 1:length(permuted)
            new_Y(Y == j) = permuted(j);
        end
        scores(i) = sum(new_Y == Y_pred) / length(Y);
    end

    score = max(scores);
end