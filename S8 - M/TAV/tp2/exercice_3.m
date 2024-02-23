clear;
close all;

% Chargement des données
image = imread('Donnees/piments.png');
[height, width, channels] = size(image);

% Extraction des caractérisques de l'image 
features = zeros(height, width, channels + 2);
for i=1:channels % Couleurs RGB
    features(:,:, i) = image(:,:,i);
end

for i=1:height % Position du pixel
    for j=1:width
        features(i,j,4:5) = [i,j];
    end
end

features = reshape(features, height * width, channels + 2);
features = features ./ max(features);

% Evaluation numérique du nombre du cluster
range = 2:10;
eval_result = evalclusters(features, 'kmeans', 'CalinskiHarabasz', 'KList', range);

% Algorithme de K-means et reconstruction de l'image segmentée
k = eval_result.OptimalK;
[idx, ~] = kmeans(features, 9);
segmented_image = reshape(idx, [height, width]);

% Affichage
figure;

subplot(1, 2, 1);
imshow(image);
title('Image originale');

subplot(1, 2, 2);
imagesc(segmented_image);
title('Image segmentée');

colormap(gca, 'jet');
colorbar;

% Force l'image segmentée à être correctement affiché
axis equal;