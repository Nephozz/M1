function overlap = is_overlaping(circle, circle_list, R)
    overlap = false;
    for j = 1:length(circle_list)
        c_k = circle_list(j,:) - circle;
        if c_k(1)^2 + c_k(2)^2 <= 2 * R^2
            overlap = true;
            break
        end
    end
end