function [moyenne,variance] = estimation_loi_normale(echantillons)
    moyenne = sum(echantillons) / length(echantillons);
    variance = sum((echantillons - moyenne).^2) / length(echantillons);
end