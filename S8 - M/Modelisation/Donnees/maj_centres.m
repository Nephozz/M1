function centres = maj_centres(X, labels, K)
[~, n] = size(X);
centres = zeros(K, n);

for k = 1:K
    cluster_pixels = X(labels == k, :);
    centres(k,:) = mean(cluster_pixels, 1);
end

end
