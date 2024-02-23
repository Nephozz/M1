function AD = attache_aux_donnees(I,moyennes,variances)
    N = length(moyennes);
    [height, width] = size(I);
    AD = zeros(height, width, N);

    for i=1:N
        AD(:,:,i) = 0.5 * (log(variances(i)) + (I - moyennes(i)).^2 ./ variances(i));
    end
end