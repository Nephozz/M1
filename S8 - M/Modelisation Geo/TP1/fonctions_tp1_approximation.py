import numpy as np
import matplotlib.pyplot as plt 
import matplotlib.cm as cm
import math

## Renvoie nb_ech echantillon entre borne_min et borne_max
def tToEvaluate(borne_min, borne_max, nb_ech):
    x_fonc = []; x_tmp = borne_min
    pas = (borne_max - borne_min)/(nb_ech-1)
    while(x_tmp <= borne_max):
        x_fonc.append(x_tmp)
        x_tmp += pas
    x_fonc.append(borne_max) 
    
    return x_fonc

def echantillonnage(nb_ech):
    #  fonction : echantillonnage                                                  
    #  semantique : génére l'ensemble des temps d'évaluation 
    #               à partir du nombre d'échantillon                 
    #  params :                                                             
    #           - int nb_ech : nombre d'échantillon                 
    #  sortie :                      
    #            - List<float> list_tt : temps d'évaluation  

    list_tt = np.linspace(0, 1, nb_ech)

    return list_tt

def k_parmi_n(k, n):
    #  fonction : k_parmi_n                                                  
    #  semantique : calculs de coefficient binomial           
    
    return math.factorial(n) / (math.factorial(k) * math.factorial(n - k)) 


def build_polys_bernstein(degre_max, list_tt) -> list:
    #  fonction : build_polys_bernstein                                                  
    #  semantique : construit les polynomes de Beisntein jusqu'au degré degre_max                
    #  params :                                                             
    #           - int degre_max : degré max         
    #           - float list_tt : t d'évaluation         
    #  sortie :  - une liste de matrices de taille [len(list_tt) x 2] liste_points: la liste  
    #              contenant degre_max matrices de points 2D, une pour chaque polynome de Bernstein.
    #              Chaque matrice contient len(list_tt) points.
    #     
    
    liste_points = []
    
    for i in range(degre_max + 1):
        liste_poly = np.zeros((len(list_tt),2))
        liste_poly[:,0] = list_tt
        
        for j in range(len(list_tt)):
            t = list_tt[j]
            liste_poly[j,1] = k_parmi_n(i, degre_max) * pow(t,i) * pow((1 - t),(degre_max - i))
            
        liste_points.append(liste_poly)

    return liste_points

def DeCasteljau(DD, tt):
    #  fonction : DeCasteljau                                                  
    #  semantique : applique l'aglgorithme de DCJ sur les valeurs de DD    
    #              pour une courbe définie par les points de controle                  
    #  params :                                                             
    #           - List<float> DD : liste de valeur à approximer (abscisses ou ordonnées)                        
    #           - float tt : temps d'évaluation     
    #                 
    #  sortie : - float d : valeur (abscisses ou ordonnées)  approximée en tt 
    #
    
    n = len(DD)
    
    for k in range(1, n):
        for i in range(n - k):
            DD[i] = (1 - tt) * DD[i] + tt * DD[i + 1]
            
    d = DD[0]
    
    return d
    
def subdivision(X,Y):
    #  fonction : subdivision                                                  
    #  semantique : correspond à 1 étape de subdivision
    #                             
    #  params :                                                             
    #           - List<float> XX : abscisses des point de controle       
    #           - List<float> YY : odronnees des point de controle        
    #                 
    #  sortie :  (List<float> QX, List<float> QY, List<float> RX,
    #            List<float> RY) : 
    #            Listes contenant les abscisses et les ordonnées des
    #             deux nouvelles familles Q et R 

    QX = []
    QY = []
    RX = []
    RY = []
    
    n = len(X)

    for i in range(n+1):
        if (i <= n // 2):
            QX.append((X[max(0,i-1)] + X[i]) / 2.0)
            QY.append((Y[max(0,i-1)] + Y[i]) / 2.0)
        else:
            RX.append((X[i-1] + X[min(i,n-1)]) / 2.0)
            RY.append((Y[i-1] + Y[min(i,n-1)]) / 2.0)

    return QX, QY, RX, RY

def DeCasteljauSub(X, Y, nombreDeSubdivision):
    #  fonction : DeCasteljauSub                                                  
    #  semantique : renvoie la liste des points composant la courbe
    #              approximante selon un nombre de subdivision données                
    #  params :                                                             
    #           - List<float> XX : abscisses des point de controle       
    #           - List<float> YY : odronnees des point de controle  
    #           - int nombreDeSubdivision : nombre de subdivision        
    #                 
    #  sortie :  (List<float>, List<float>) : une liste avec les abscisses 
    #            et une liste avec les ordonnées des points de la courbe  

    if (nombreDeSubdivision == 0):
        return (X, Y)
    else:
        QX, QY, RX, RY = subdivision(X,Y)
        return DeCasteljauSub(QX + RX, QY + RY, nombreDeSubdivision - 1)

def approximation_surface(XX, YY, ZZ, list_tt, nb_point_grille):
    #  fonction : appromation_surface                                                  
    #      semantique : calcule les points atteints par la surface en chauqe temps d'évaluation     
    #                                    
    #      params :                                                             
    #               - Array<float> XX : coorodnnées X des points de controle 3D         
    #               - Array<float> YY : coorodnnées Y des points de controle 3D         
    #               - Array<float> ZZ : coorodnnées Z des points de controle 3D        
    #               - List<float> list_tt : temps d'évaluation                
    #      sortie : 
    #               - Array<vfloat> : coordonnées 3D des points de la surface approximée, 
    #                 la dimension associée est : (nb_echantillon, nb_echantillon, 3)
    
    nb_echantillon = len(list_tt)
    approx_pointsYZ = np.zeros((nb_echantillon, nb_echantillon, 3))
    result_ligne = np.zeros((nb_point_grille, nb_echantillon, 3))

    # Interpolation sur les lignes
    for i in range(nb_point_grille):
        for j in range(nb_echantillon):
            X = DeCasteljau(XX[i,:], list_tt[j])
            Y = DeCasteljau(YY[i,:], list_tt[j])
            Z = DeCasteljau(ZZ[i,:], list_tt[j])
            result_ligne[i,j,0] = X
            result_ligne[i,j,1] = Y
            result_ligne[i,j,2] = Z
    
    # Interpolation sur les colonnes
    for j in range(nb_echantillon):
        for i in range(nb_echantillon):
            X = DeCasteljau(result_ligne[:,j,0], list_tt[i])
            Y = DeCasteljau(result_ligne[:,j,1], list_tt[i])
            Z = DeCasteljau(result_ligne[:,j,2], list_tt[i])
            approx_pointsYZ[i,j,0] = X
            approx_pointsYZ[i,j,1] = Y
            approx_pointsYZ[i,j,2] = Z

    return approx_pointsYZ


