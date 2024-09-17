import matplotlib.pyplot as plt
import mpl_toolkits.mplot3d
import numpy as np
import scipy.sparse as scps
import scipy.sparse.linalg as ssl
import scipy.linalg as sl
import math


def maillage(n):
#
# Une discretisation possible d'une EDP elliptique sur le domaine ]0,1[ x ]0,1[
# Le carre [0,1]x[0,1] est maille uniquement avec des triangles; 
# Les conditions limites sont de type Dirichlet uniquement   => neumann  =[];
#
# Entrees :
# n : nombre de points par cote du care => Npts points de discretisation au
# total
#
# Sorties :
# coordinates : matrice a deux colonnes. Chaque ligne contient les 
# coordonnes 2D d'un des points de la discretisation. Ces sommets seront 
# identifies a l'indice de la ligne correspondante dans la matrice
# coordinates.
# elements3 : matrice a trois colonnes. Chaque ligne contient les indices 
# des sommets d'un element triangle, dans le sens antihoraire. 
# dirichlet : vecteur colonne des indices des sommets de la frontiere de
# Dirichlet.
# neumann : matrice a deux colonnes. Chaque ligne contient les indices 
# des deux sommets d'une arete de la frontiere de Neumann.
# (neumann est vide sur cet exemple)
#
##################################################################################
    h=1/(n-1)
    npoin       = n*n ; 
    nelem       = 2*(n-1)*(n-1) ;
    coordinates = np.zeros((npoin,2)); 
    elements3   = (np.zeros((nelem,3))).astype(int) ;
    neumann     = [];
    dirichlet=(np.zeros((4*n-4,1))).astype(int)
    # Coordonnees et connectivites :
    e = -1 ; 
    p = -1 ;
    x=np.zeros((n+1,1))
    x[n,0]=1.
    for l in range (n+1):
        x[l,0]=l*h
    for j in range (n):
            for i in range(n):
                p = p + 1  
                coordinates[p,0] = x[i,0]  
                coordinates[p,1] = x[j,0] 
                if ((i != n-1) & (j != n-1)):
                    p1 = p
                    p2 = p1 + 1 
                    p3 = p1 + n 
                    p4 = p2 + n
                    e = e + 1 
                    elements3[e,0] = p1 
                    elements3[e,1] = p2 
                    elements3[e,2] = p3 
                    e = e + 1
                    elements3[e,0] = p4 
                    elements3[e,1] = p3 
                    elements3[e,2] = p2 
    #Liste des sommets de la frontiere de Dirichlet:
    p=-1
    for j in range(n):
        p=p+1
        dirichlet[p,0] = j  
    for j in range(n*2-1,n*(n-1),n):
        p=p+1
        dirichlet[p,0] = j 
    for j in range(n*n-1,n*n-n-1,-1):
        p=p+1
        dirichlet[p,0] = j 
    for j in range(n*n-2*n,n-1,-n):
        p=p+1
        dirichlet[p,0] = j 

    return coordinates, elements3,dirichlet, neumann




def show(coordinates,u):
#
# Fonction d'affichage de la solution u sur le maillage defini par
# elements3, coordinates.
#
# Entrees:
# elements3 : matrice a trois colonnes contenant les elements triangles
# de la discretisation, identifies par les indices de leurs trois
# sommets.
# coordinates : matrice a deux colonnes contenant les coordonnes 2D des
# points de la discretisation.
# u : vecteur colonne de longueur egale au nombre de lignes de
# coordinates contenant les valeurs de la solution a afficher aux
# points de la discretisation.
#
# Sorties : Aucune, mais la fonction doit s'afficher dans une figure.
##########################################################################
    ax= plt.figure().add_subplot(projection='3d')
    ax.plot_trisurf(coordinates[:,0],coordinates[:,1],u,linewidth=0.2,antialiased=True)
    plt.show()
    

def alpha(x,y):
        return (x[1]-x[0])*(y[2]-y[0]) - (x[2]-x[0])*(y[1]-y[0])

def grad_eta(x, y, j):
    a = alpha(x,y)
    res = np.array([ [ y[(j+1)%3] - y[(j+2)%3] ] ,[ x[(j+2)%3] - x[(j+1)%3] ] ]) * 1 / a
    return res


def calcul_integral(x,y,i,j):
    return (alpha(x,y) / 2) * np.matmul(np.transpose(grad_eta(x,y,i)), grad_eta(x,y,j))


def calcul_M(x,y):
    M = np.zeros((3,3))
    for i in range(3):
        for j in range(3):
            M[i][j] = calcul_integral(x,y,i,j)
    
    return M

def f(x,y):
    return 1

def u_d(x,y):
    return 1

def g(x,y):
    return 1


def jacob(x,y):
    J = np.zeros((2,2))
    J[0][0] = x[1] - x[0]
    J[0][1] = x[3] - x[0]
    J[1][0] = y[1] - y[0]
    J[1][1] = y[3] - y[0]
    return J

def inv2D(M):
    alpha = M[0][0]
    beta = M[0][1]
    gamma = M[1][1]
    coef = 1 / (alpha * gamma - beta ** 2)
    return coef * np.array([[gamma, -beta], [-beta, alpha]])

def calcul_M_quad(x,y):
    J = jacob(x,y)
    J_J_inv = inv2D(np.matmul(np.transpose(J), J))
    det_J = np.linalg.det(J)
    a = J_J_inv[0][0]
    b = J_J_inv[0][1]
    c = J_J_inv[1][1]
    M11 = 2*a + 3*b + 2*c
    M21 = -2*a + c
    M31 = -a - 3*b - c
    M41 = a - 2*c
    M22 = 2*a - 3*b + 2*c
    M32 = a - 2*c
    M42 = -a + 3*b - c
    M33 = 2*a + 3*b + 2*c
    M43 = -2*a +c
    M44 = 2*a - 3*b + 2*c
    res = det_J / 6 * np.array([[M11, M21, M31, M41],
                                [M21, M22, M32, M42],
                                [M31, M32, M33, M43],
                                [M41, M42, M43, M44]])

    return res