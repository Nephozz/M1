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
        L = 1
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
                                                      
    xx = []
    yy = []
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
    while tToEval[-1] < T[-1]:
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
    for i in range(nb_elt - 1):
        norm_P = math.dist([XX[i],YY[i]],[XX[i+1],YY[i+1]])
        T.append(T[i] + norm_P)
    
    tToEval = [T[0]]
    while tToEval[-1] < T[-1]:
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
    for i in range(nb_elt-1):
        norm_P = math.dist([XX[i],YY[i]],[XX[i+1],YY[i+1]])
        T.append(T[i] + math.sqrt(norm_P))

    tToEval = [T[0]]
    while tToEval[-1] < T[-1]:
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
    for i in range(nb_elt):
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
    
    P = XX + YY
    n = len(XX)
    
    for i in range(n - 1):
        for j in range(n - (i + 1)):
            td = TT[j]
            tg = TT[i+j+1]
            TG = (tg - tt)/(tg - td)
            TD = (tt - td)/(tg - td)
            
            P[j] = TG * P[j] + TD * P[j+1]
            P[j+n] = TG * P[j+n] + TD * P[j+n+1]
    
    x = P[0]
    y = P[n]
    
    return x,y


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

    xx = []
    yy = []
    
    for tt in list_tt:
        x, y = neville(XX,YY,TT,tt)
        xx.append(x)
        yy.append(y)
        
    return xx, yy


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
    #               il faut plutôt une matrice cubique n*n*3

    nb_echantillon = len(list_tt)
    mat_out = np.zeros((nb_echantillon,nb_echantillon,3))
    
    LX = np.zeros((nb_point_grille,nb_echantillon))
    LY = np.zeros((nb_point_grille,nb_echantillon))
    LZ = np.zeros((nb_point_grille,nb_echantillon))

    for i in range(nb_point_grille):    
        for k in range(nb_echantillon):
            t = list_tt[k]
            LX[i,k] = lagrange(TT,XX[i,:],t)
            LY[i,k] = lagrange(TT,YY[i,:],t)
            LZ[i,k] = lagrange(TT,ZZ[i,:],t)
        
    for j in range(nb_echantillon):
        for k in range(nb_echantillon):
            t = list_tt[k]
            mat_out[k,j,0] = lagrange(TT,LX[:,j],t)
            mat_out[k,j,1] = lagrange(TT,LY[:,j],t)
            mat_out[k,j,2] = lagrange(TT,LZ[:,j],t)
    
    return mat_out