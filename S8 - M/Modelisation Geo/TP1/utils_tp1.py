import numpy as np
import pandas as pd
import matplotlib.pyplot as plt 
import matplotlib.cm as cm
import itertools

from fonctions_tp1_interpolation import lagrange, lagrange_param, neville_param
#from fonctions_tp1_approximation import *

### Variable globale Interpolation
pas = 1/100

borne_max = 1000
epsilon = 1/10
liste_couleurs = ['blue', 'cyan', 'green', 'magenta', 'red', 'yellow']

### Genere un ensemble de point sans ambuigité des abscisses
def generate_points(nb_pts, b_max= borne_max, p=pas):
    X = [np.round(i*p,2)/(borne_max*pas) for i in np.random.randint(b_max, size=(nb_pts))]
    Y = [np.round(i*p,2)/(borne_max*pas) for i in np.random.randint(b_max, size=(nb_pts))]
    # Vérification : Non double absicisses 
    while (len(list(pd.Series(X).value_counts().to_dict().values())) != nb_pts):
        X = [np.round(i*p,2)/(borne_max*pas) for i in np.random.randint(b_max, size=(nb_pts))]
    return X,Y

### Genere un ensemble de point sur une sphère
def generate_sphere(sections=8, radio=1, points_section=8, orientation=1):
    points = list()

    for x in np.linspace(-radio, radio, sections):
        radio_section = np.sqrt(radio**2 - x**2)
        row = list()
        for y in np.linspace(-radio_section, radio_section, points_section):
            z = np.sqrt(radio_section**2 - y**2)
            row.append((x, y, z*orientation))
        points.append(row)

    return points


###################################################################################################################
################################################## INTERPOLATION ##################################################
###################################################################################################################

### CAS FONCTIONNEL
### Ensemble d'abscisses des points de la courbe en construction.
def get_x_fonc(borne_min, borne_max):
    x_fonc = []; x_tmp = borne_min
    while(x_tmp <= borne_max):
        x_fonc.append(x_tmp)
        x_tmp += pas
    x_fonc.append(borne_max) 
    
    return x_fonc

### Interpolation de lagrange fonctionnel sur plusieurs exemples
def multiple_affichage_lagrange(nb_pts_controle):
    nb_test = 10
    fig, axs = plt.subplots(nb_test//2, 2, figsize = (20,12))
    fig.suptitle('Interpolation fonctionnelle de Lagrange', fontsize=20)
    pos = 0
    for n in range(nb_test):
        # Points de contrôles
        X_pts_controles_n, Y_pts_controles_n = generate_points(nb_pts_controle)
        # Interpolation 
        x_fonc_n = get_x_fonc(min(X_pts_controles_n), max(X_pts_controles_n))
        y_fonc_n = []
        for i in range(0, len(x_fonc_n)):
            y_fonc_n.append(lagrange(X_pts_controles_n, Y_pts_controles_n, x_fonc_n[i]))

        axs[pos, n%2].scatter(X_pts_controles_n, Y_pts_controles_n, c=cm.rainbow(np.linspace(0, 1, len(X_pts_controles_n))))
        axs[pos, n%2].plot(x_fonc_n, y_fonc_n)
        # Ligne suivante
        if n%2 !=0 : pos = pos +1

## Affichage du cas problèmatique à partir de deux jeux de données de 5 points chacun
def configuration_problematique(X1, X2, Y1, Y2):
    ## Cas sans problème
    x_fonc1 = get_x_fonc(min(X1), max(X2))
    y_fonc1 = []
    for i in range(0, len(x_fonc1)):
        y_fonc1.append(lagrange(X1, Y1, x_fonc1[i]))


    ## Cas avec problème
    x_fonc2 = get_x_fonc(min(X2), max(X2))
    y_fonc2 = []
    for i in range(0, len(x_fonc2)):
        y_fonc2.append(lagrange(X2, Y2, x_fonc2[i]))

    ## Affichage
    fig, axs = plt.subplots(2, 2, figsize = (20,8))
    fig.suptitle('Identification du cas limite')
    ### Sans problème
    axs[0,0].scatter(X1,Y1, c = ['b', 'r', 'r', 'b', 'b'])
    axs[0,1].scatter(X1,Y1, c = ['b', 'r', 'r', 'b', 'b'])
    axs[0,1].plot(x_fonc1,y_fonc1)

    ### Avec probleme 
    axs[1,0].scatter(X2,Y2, c = ['b', 'r', 'r', 'b', 'b'])
    axs[1,1].scatter(X2,Y2, c = ['b', 'r', 'r', 'b', 'b'])
    axs[1,1].plot(x_fonc2,y_fonc2)

    ## Supperposition
    plt.figure(figsize=(15, 3))
    plt.xlabel('Abscisses')
    plt.ylabel('Ordonnées')
    plt.title('Points de contrôle')
    plt.plot(x_fonc1, y_fonc1, label= 'Sans probleme')
    plt.plot(x_fonc2, y_fonc2, label= 'Avec probleme')
    plt.legend()
    plt.show()

## Affiche l'interpolation avec les 4 paramétrisations différentes
## La paramétre booléen meme_intervalle permet d'afficher les 4 courbes dans le mêne intervalle
def comparaison_paramétrisation(methode, T, list_t, X_pts_controles, Y_pts_controles, meme_intervalle):

    labels_param = ['Regulière', 'Distance', 'Racine de distance', 'Tchebycheff']
    fig, axs = plt.subplots(2, 2, figsize = (15,12))
    fig.suptitle("Interpolation paramétrique")
    pos = 0

    if meme_intervalle:
        ## Recherche du min/max pour les 2 axes
        X_param = []; Y_param = []
        for k in range(len(T)):
            if ((methode == 'lagrange') & (T[k]!=[])) :
                x_param, y_param = lagrange_param(X_pts_controles, Y_pts_controles, T[k], list_t[k])

            elif ((methode == 'neville') & (T[k]!=[])) :  
                x_param, y_param = neville_param(X_pts_controles, Y_pts_controles, T[k], list_t[k])

            else : x_param = [0]; y_param=[0]
            X_param.append(x_param); Y_param.append(y_param)

        X_mini = min(list(itertools.chain(*X_param)))
        X_maxi = max(list(itertools.chain(*X_param)))
        Y_mini = min(list(itertools.chain(*Y_param)))
        Y_maxi = max(list(itertools.chain(*Y_param)))   

        for k in range(len(X_param)):
            # Affichage 
            axs[pos,k%2].scatter(X_pts_controles, Y_pts_controles, c=cm.rainbow(np.linspace(0, 1, len(X_pts_controles))))
            axs[pos,k%2].plot(X_param[k], Y_param[k])
            axs[pos,k%2].set_title('Paramètrisation '+labels_param[k])
            axs[pos,k%2].set_xlim([X_mini-epsilon, X_maxi+epsilon])
            axs[pos,k%2].set_ylim([Y_mini-epsilon, Y_maxi+epsilon])
            if k%2 !=0 : pos = pos +1  

    else :
        for k in range(len(T)):
            if ((methode == 'lagrange') & (T[k]!=[])) :
                x_param, y_param = lagrange_param(X_pts_controles, Y_pts_controles, T[k], list_t[k])
            elif ((methode == 'neville') & (T[k]!=[])) :  
                x_param, y_param = neville_param(X_pts_controles, Y_pts_controles, T[k], list_t[k])
            else : x_param = [0]; y_param=[0]
    
            # Affichage 
            axs[pos,k%2].scatter(X_pts_controles, Y_pts_controles, c=cm.rainbow(np.linspace(0, 1, len(X_pts_controles))))
            axs[pos,k%2].plot(x_param,y_param)
            axs[pos,k%2].set_title('Paramètrisation '+labels_param[k])
            if k%2 !=0 : pos = pos +1


### Affiche toutes les étapes de la surface 3D en produit tensoriel
def show_surface(X, Y, Z, interpolated_surface):

    fig = plt.figure(figsize=(18,6))
    ax = fig.add_subplot(131, projection='3d')
    ax.set_title('Points de contrôle')
    ax.scatter(X, Y, Z)

    if interpolated_surface[0].shape[0] != 0:
        ax3 = fig.add_subplot(132, projection='3d')
        ax3.set_title('Echantillonnage')
        ax3.scatter(interpolated_surface[:,:,0].reshape(-1,1),interpolated_surface[:,:,1].reshape(-1,1), interpolated_surface[:,:,2].reshape(-1,1))
        for i in range(interpolated_surface.shape[0]):
            ax3.plot(interpolated_surface[i,:,0], interpolated_surface[i,:,1], interpolated_surface[i,:,2])
            ax3.plot(interpolated_surface[:,i,0], interpolated_surface[:,i,1], interpolated_surface[:,i,2])
            
        ax5 = fig.add_subplot(133, projection='3d')
        ax5.set_title('Surface interpolante')
        ax5.plot_surface(interpolated_surface[:,:,0], interpolated_surface[:,:,1], interpolated_surface[:,:,2], cmap='viridis', edgecolor='k')


    plt.show()



