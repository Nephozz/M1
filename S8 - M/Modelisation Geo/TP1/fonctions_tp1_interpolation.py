import math 
import numpy as np

################################################################################################
###################################### Interpolation - FONCTIONNEL ####################################
################################################################################################

def lagrange(XX, YY, x_int):
    #  fonction : lagrange                                                  
    #  semantique : calcule la valeur en x_int du polynome de Lagrange passant  
    #               par les points de coordonnées (XX,YY)                     
    #  params :                                                             
    #           - float x_int : point dont on cherche l'ordonnée                
    #           - List<float> XX : liste des abscisses des points            
    #           - List<float> YY : liste des ordonnées des points            
    #  sortie : valeur en x_int du polynome de Lagrange passant                 
    #           par les points de coordonnées (XX,YY)                         

    Pn_x = 0
    for i in range(len(YY)):
        L  = 1
        for j in range(len(XX)):
            if j != i:
                L *= (x_int - XX[j]) / (XX[i] - XX[j])
        Pn_x += L * YY[i]

    return Pn_x

################################################################################################
###################################### Interpolation - PARAMETRIQUE ###################################
################################################################################################

def lagrange_param(XX, YY, TT, list_tt):
    #  fonction : lagrange_param                                 
    #  semantique : applique la subdivion de Lagrange aux points (XX, YY)      
    #               placés en paramètres en suivant les temps indiqués      
    #  params :                                                             
    #           - List<float> XX : liste des abscisses des points            
    #           - List<float> YY : liste des ordonnées des points            
    #           - List<float> TT : temps de la subdivision                   
    #           - List<float> list_tt : échantillon des temps sur TT         
    #  sortie : points (xx, yy) de la courbe interpolée
    #     
                                                      
    xx, yy = [], []
    for t in list_tt:
        xx.append(lagrange(TT,XX,t))
        yy.append(lagrange(TT,YY,t))

    return xx, yy

def parametrisation_reguliere(nb_elt, pas_tps):
    #  fonction : parametrisation_reguliere                                                  
    #  semantique : construit la subdivision reguliere et les échantillons  
    #               de temps selon cette subdivision                 
    #  params :                                                             
    #           - int nb_elt : nombre d'elements de la subdivision          
    #           - float pas_tps : pas d'échantillonage          
    #  sortie :  - List<float> T : subdivision reguliere                     
    #            - List<float> tToEval : echantillon sur la subdivision  

    T = [i for i in range(nb_elt)]
    
    tToEval = [T[0]]
    while tToEval[-1] < nb_elt:
        tToEval.append(tToEval[-1] + pas_tps)
    
    return T,tToEval

def parametrisation_distance(nb_elt, pas_tps, XX, YY):
    #  fonction : parametrisation_distance                                                  
    #  semantique : construit la subdivision sur les distances et les échantillons  
    #               de temps selon cette subdivision                 
    #  params :                                                             
    #           - int nb_elt : nombre d'elements de la subdivision          
    #           - float pas_tps : pas d'échantillonage          
    #  sortie :  - List<float> T : subdivision reguliere                     
    #            - List<float> tToEval : echantillon sur la subdivision  

    T = [0]
    for i in range(len(XX)):
        norm_P = math.dist([XX[i],YY[i]],[XX[i-1],YY[i-1]])
        T.append(T[i] + norm_P)
    
    tToEval = [T[0]]
    while tToEval[-1] < nb_elt:
        tToEval.append(tToEval[-1] + pas_tps)
    
    return T, tToEval

def parametrisation_racinedistance(nb_elt, pas_tps, XX, YY):
    #  fonction : parametrisation_reguliere                                                  
    #  semantique : construit la subdivision sur les racines distances et les échantillons  
    #               de temps selon cette subdivision                 
    #  params :                                                             
    #           - int nb_elt : nombre d'elements de la subdivision          
    #           - float pas_tps : pas d'échantillonage          
    #  sortie :  - List<float> T : subdivision reguliere                     
    #            - List<float> tToEval : echantillon sur la subdivision  

    T = [0]
    for i in range(nb_elt):
        norm_P = math.dist([XX[i],YY[i]],[XX[i-1],YY[i-1]])
        T.append(T[i] + math.sqrt(norm_P))

    tToEval = [T[0]]
    while tToEval[-1] < nb_elt:
        tToEval.append(tToEval[-1] + pas_tps)
    
    return T, tToEval

def parametrisation_Tchebycheff(nb_elt, pas_tps):
    #  fonction : subdivision_reguliere                                                  
    #  semantique : construit la subdivision basée sur Tchebycheff et les échantillons  
    #               de temps selon cette subdivision                 
    #  params :                                                             
    #           - int nb_elt : nombre d'elements de la subdivision          
    #           - float pas_tps : pas d'échantillonage          
    #  sortie :  - List<float> T : subdivision reguliere                     
    #            - List<float> tToEval : echantillon sur la subdivision  

    T = []
    for i in range(nb_elt + 1):
        cosi = math.cos((2*i+1)*math.pi / (2 * nb_elt + 2))
        T.append(cosi)

    tToEval = [min(T)]
    while tToEval[-1] < max(T):
        tToEval.append(tToEval[-1] + pas_tps)
    
    return T, tToEval


def neville(XX, YY, TT, tt):
    #  fonction : neville                                                  
    #      semantique : calcule le point atteint par la courbe en tt sachant     
    #                   qu'elle passe par les (XX,YY) en TT                       
    #      params :                                                             
    #               - List<float> XX : liste des abscisses des points            
    #               - List<float> YY : liste des ordonnées des points            
    #               - List<float> TT : liste des temps de la subdivision         
    #               - tt : temps ou on cherche le point de la courbe             
    #      sortie : point atteint en t de la courbe 
    
    #TODO
    return 0,0


def neville_param(XX, YY, TT, list_tt):
    # fonction : neville_param                                   
    #  semantique : applique la subdivion de Neville aux points (XX,YY)       
    #               placés en paramètres en suivant les temps indiqués      
    #  params :                                                             
    #           - List<float> XX : liste des abscisses des points            
    #           - List<float> YY : liste des ordonnées des points            
    #           - List<float> TT : temps de la subdivision                   
    #           - List<float> list_tt : échantillon des temps sur TT         
    #  sortie : points (xx,yy) de la courbe interpolée                                                        

    #TODO
    return 0,0


################################################################################################
###################################### Interpolation - SURFACE FONCTIONNEL #####################
################################################################################################

def interpolate_surface(XX, YY, ZZ, TT, list_tt, nb_point_grille):
    #  fonction : interpolate_surface                                                  
    #      semantique : calcule le point atteint par la surface en tt sachant     
    #                   qu'elle passe par les (XX,YY) en TT                       
    #      params :                                                             
    #               - Array<float> XX : coorodnnées X des points 3D         
    #               - Array<float> YY : coorodnnées Y des points 3D         
    #               - Array<float> ZZ : coorodnnées Z des points 3D        
    #               - List<float> TT : temps de la subdivision
    #               - List<float> list_tt : échantillon des temps sur TT                
    #      sortie : (Array<float> points 3D des courbes interpolées en fixant Y,
    #                   Array<float> points 3D des courbes interpolées en fixant X)


    #TODO
    return 0,0



