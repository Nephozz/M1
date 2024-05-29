function resultats = recherche_avancee(identifiants, paires, bdd)
    resultats = [];

    for i = 1:size(identifiants, 1)
        id = identifiants(i);
        
        if bdd.isKey(id)
            resultat = bdd(id);
            for j = 1:size(resultat,1)
            resultats = [resultats; [resultat(j,2) resultat(j,1) - paires(i)]];
        end
    end
end