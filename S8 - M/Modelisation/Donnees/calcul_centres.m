function labels = calcul_centres(X, centres, m, S)

X_rgb = X(:, 1:3);
X_pos = X(:, 4:5);
centres_rgb = centres(:, 1:3);
centres_pos = centres(:, 4:5);

% (X - C)^2 = X^2 - 2 * X * C' + C^2
distances_rgb = sum((X_rgb.^2), 2) - 2 * X_rgb * centres_rgb' + sum((centres_rgb.^2), 2)';
distances_pos = sum((X_pos.^2), 2) - 2 * X_pos * centres_pos' + sum((centres_pos.^2), 2)';
distances = distances_rgb + m/S * distances_pos;

[~, labels] = min(distances, [], 2);

end
