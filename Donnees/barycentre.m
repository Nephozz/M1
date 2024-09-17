function barycentre = barycentre(T, i)

idx_pts = T.ConnectivityList(i, :);
barycentre = mean(T.Points(idx_pts, :), 1);

end

