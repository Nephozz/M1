import numpy as np
import trimesh 
from tqdm import tqdm

from utils_tp2_curvature import make_pca, lstsq_quadrics_fitting

# Objectif : Charger les attributs principaux d'un maillage 3D à partir d'un fichier.
# Paramètres :
# - path_to_model (str) : Chemin vers le fichier du maillage 3D.
# Retour :
# - maillage (objet trimesh) : Objet représentant le maillage.
# - dict_attribut_base (dictionnaire) : Dictionnaire contenant les attributs de base du maillage.
def load_mesh(path_to_model):
    # Load model with Trimesh
    maillage = trimesh.load(path_to_model, force='mesh')
    ## Coordonnées de sommets : np.array nx3
    sommets = np.array(maillage.vertices)
    nsommets = sommets.shape[0]
    ## Indices de chaque face : np.array mx3
    faces = np.array(maillage.faces)
    ## Arêtes : ensemble de tuples correspondants aux deux indices des deux sommets de chaque arête
    aretes = np.array(maillage.edges)

    ## Stockage 
    dict_attribut_base = {}
    dict_attribut_base["faces"] = faces
    dict_attribut_base["aretes"] = aretes
    dict_attribut_base["sommets"] = sommets
    dict_attribut_base['nsommets'] = nsommets

    return maillage, dict_attribut_base

# Objectif : Obtenir les voisins directs de chaque sommet.
# Paramètres :
# - nsommets (int) : Nombre de sommets dans le maillage.
# - aretes (ensemble de tuples d'indices) : Ensemble des arêtes du maillage.
# Retour :
# - neighbors (dictionnaire) : Dictionnaire où chaque clé est l'indice 
# d'un sommet et la valeur correspondante est un ensemble contenant 
# les indices de ses voisins directs.
def get_direct_neighbors(nsommets, aretes):
    neighbors = {i: set() for i in range(nsommets)}

    for i, j in aretes:
        neighbors[i].add(j)
        neighbors[j].add(i)

    return neighbors


# Objectif : Calculer les k plus proches voisins pour chaque sommet du maillage.
# Paramètres :
# - profondeur_k (int) : Profondeur pour la recherche des k plus proches voisins.
# - nsommet (int) : Nombre de sommets dans le maillage.
# voisins_directs (dictionnaire) : Dictionnaire contenant les voisins directs de chaque sommet.
# Retour :
# - knn_dict (dictionnaire) : Dictionnaire où chaque clé est l'indice d'un sommet et la valeur 
# correspondante est un ensemble contenant les indices de ses k plus proches voisins.
def compute_knn(profondeur_k, nsommet, voisins_directs):
    knn_dict = {i: {ind for ind in get_k_neighbors(voisins_directs, profondeur_k, i, set())}
                for i in range(nsommet)}
    return knn_dict


# Objectif : Fonction auxiliaire pour obtenir les k plus proches voisins d'un sommet donné.
# Paramètres :
# - voisins_directs (dictionnaire) : Dictionnaire contenant les voisins directs de chaque sommet.
# - profondeur_k (int) : Profondeur pour la recherche des k plus proches voisins.
# - point_index (int) : Indice du sommet pour lequel on cherche les k plus proches voisins.
# - n_set (ensemble) : Ensemble des indices des k plus proches voisins.
# Retour :
# - n_set (ensemble) : Ensemble des indices des k plus proches voisins.
def get_k_neighbors(voisins_directs, profondeur_k, point_index, n_set):
    # Condition de base : profondeur_k atteint zéro
    if profondeur_k == 0:  
        n_set = set()
    ## Voisins direct avec k == 1
    elif profondeur_k == 1:
        n_set = voisins_directs[point_index]
    else:
        for p in voisins_directs[point_index]:
            n_set = set.union(n_set, get_k_neighbors(voisins_directs, profondeur_k - 1, p, n_set))
    return n_set


# Objectif : Calculer la courbure moyenne à partir des coefficients de la meilleure quadrique.
# Paramètres :
# - quadrics (tableau numpy 6x1) : Coefficients de la quadrique.
# Retour :
# - curv (float) : Valeur de la courbure moyenne calculée.
def curvature_meynet(quadrics):
    a, b, c, d, e, f = quadrics
    
    curv = ((1 + d**2)*a + (1 + e**2)*b - 4*b*c) / (1 + e**2 + d**2)**(1.5)
    return curv


# Objectif : Estimer la meilleure quadrique approximant la surface en chaque sommet 
# et approximer la courbure moyenne en chaque point ainsi que l'erreur quadratique associée.
# Paramètres :
# - sommets (tableau numpy nx3) : Coordonnées des sommets du maillage.
# - knn (dictionnaire) : Dictionnaire contenant les k plus proches voisins pour chaque sommet.
# Retour :
# - outputs (tableau numpy nx2) : Tableau contenant la courbure moyenne et l'erreur associée à chaque sommet.
def compute_mean_curvature(sommets, knn):
    outputs = np.zeros((sommets.shape[0],2))
    ## Pour chaque sommet
    for i in tqdm(knn):
        ## Coordonnées du point i
        xyz = sommets[i]
        ## Coordonnées de ses voisins
        neighbors_i = []
        for voisin in knn[i]:
            neighbors_i.append(sommets[voisin])
            
        ## Projection dans le nouveau repère 
        new_coord = make_pca(neighbors_i, xyz, 3)
        ## Calculs des coefficents de la meilleure quadric par moindre carrés
        Q, error = lstsq_quadrics_fitting(new_coord)
        ## Courbure et erreur/residus associées au point i 
        curv = curvature_meynet(Q)
        ## Sauvegarde de la valeur de la courbure et du résidus
        outputs[i,0] = curv; outputs[i,1] = error; 
    return outputs

print('Fin import fonctions_tp2_curvature')