close all
run donnees.m

%% Modélisation sous forme de graphe

afficher(matriceDonnees_low,A_low,"Tracer de la configuration low avec 20km",false)
afficher(matriceDonnees_low,B_low,"Tracer de la configuration low avec 40km",false)
afficher(matriceDonnees_low,C_low,"Tracer de la configuration low avec 60km",false)

afficher(matriceDonnees_avg,A_avg,"Tracer de la configuration avg avec 20km",false)
afficher(matriceDonnees_avg,B_avg,"Tracer de la configuration avg avec 40km",false)
afficher(matriceDonnees_avg,C_avg,"Tracer de la configuration avg avec 60km",false)

afficher(matriceDonnees_high,A_high,"Tracer de la configuration high avec 20km",false)
afficher(matriceDonnees_high,B_high,"Tracer de la configuration high avec 40km",false)
afficher(matriceDonnees_high,C_high,"Tracer de la configuration high avec 60km",false)  