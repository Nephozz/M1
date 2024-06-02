function I_moyen = calcul_I_moyen_ellipse(I, c_i, R, theta)
    a = R; % semi-major axis
    b = 3 * R / 4; % semi-minor axis
    
    [nb_lignes, nb_colonnes] = size(I);
    abscisse = c_i(1);
    ordonnee = c_i(2);
    
    % Random points within a circle of radius R
    N_test = 1000;
    P_test = R * (2 * rand(N_test, 2) - 1);
    inside_circle = (P_test(:, 1).^2 + P_test(:, 2).^2 <= R^2);
    P_test = P_test(inside_circle, :);
    
    % Transformation for the ellipse
    cos_theta = cos(theta);
    sin_theta = sin(theta);
    
    X_ellipse = abscisse + P_test(:, 1) * cos_theta - P_test(:, 2) * sin_theta;
    Y_ellipse = ordonnee + P_test(:, 1) * sin_theta + P_test(:, 2) * cos_theta;
    
    % Filter points inside the ellipse
    points_inside_ellipse = ((X_ellipse - abscisse).^2 / a^2 + (Y_ellipse - ordonnee).^2 / b^2) <= 1;
    
    X_ellipse = X_ellipse(points_inside_ellipse);
    Y_ellipse = Y_ellipse(points_inside_ellipse);

    % Round the indices
    X_ellipse = round(X_ellipse);
    Y_ellipse = round(Y_ellipse);
    
    % Check if indices are within bounds
    valid_indices = X_ellipse > 0 & X_ellipse <= nb_colonnes & Y_ellipse > 0 & Y_ellipse <= nb_lignes;
    X_ellipse = X_ellipse(valid_indices);
    Y_ellipse = Y_ellipse(valid_indices);
    
    % Compute the mean intensity
    I_moyen = mean(I(sub2ind([nb_lignes, nb_colonnes], Y_ellipse, X_ellipse)));
end
