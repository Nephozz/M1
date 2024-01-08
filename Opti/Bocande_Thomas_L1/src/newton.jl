using LinearAlgebra
"""
Approximation d'une solution du problème min f(x), x ∈ Rⁿ, en utilisant l'algorithme de Newton.

# Syntaxe

   x_sol, f_sol, flag, nb_iters, xₛ = newton(f, gradf, hessf, x₀; kwargs...)

# Entrées

   - f       : (Function) la fonction à minimiser
   - gradf   : (Function) le gradient de la fonction f
   - hessf   : (Function) la Hessienne de la fonction f
   - x₀      : (Union{Real,Vector{<:Real}}) itéré initial
   - kwargs  : les options sous formes d'arguments "keywords"
      • max_iter : (Integer) le nombre maximal d'iterations (optionnel, par défaut 1000)
      • tol_abs  : (Real) la tolérence absolue (optionnel, par défaut 1e-10)
      • tol_rel  : (Real) la tolérence relative (optionnel, par défaut 1e-8)
      • ε  : (Real) le ε pour les tests de stagnation (optionnel, par défaut 1)

# Sorties

   - x_sol : (Union{Real,Vector{<:Real}}) une approximation de la solution du problème
   - f_sol : (Real) f(x_sol)
   - flag  : (Integer) indique le critère sur lequel le programme s'est arrêté
      • 0  : convergence
      • 1  : stagnation du xₖ
      • 2  : stagnation du f
      • 3  : nombre maximal d'itération dépassé
   - nb_iters : (Integer) le nombre d'itérations faites par le programme
   - xₛ    : (Vector{Vector{<:Real}}) les itérés

# Exemple d'appel

   f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
   gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
   hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
   x₀ = [1; 0]
   x_sol, f_sol, flag, nb_iters, xₛ = newton(f, gradf, hessf, x₀)

"""
function newton(f::Function, gradf::Function, hessf::Function, x₀::Union{Real,Vector{<:Real}}; 
    max_iter::Integer = 1000, 
    tol_abs::Real = 1e-10, 
    tol_rel::Real = 1e-8, 
    epsilon::Real = 1)

    #
    x_sol = x₀
    f_sol = f(x_sol)
    flag  = -1
    nb_iters = 0
    xₛ = [x₀] # vous pouvez faire xₛ = vcat(xₛ, [xₖ]) pour concaténer les valeurs

    if norm(gradf(x_sol)) > tol_abs # Si x₀ n'est pas la solution optimale
      while flag == -1
         xₖ = x_sol
         d = - hessf(xₖ) \ gradf(xₖ)

         x_sol = xₖ + d
         f_sol = f(x_sol)
         xₛ = vcat(xₛ, [x_sol])

         nb_iters = nb_iters + 1

         if norm(gradf(x_sol)) <= max(tol_rel*norm(gradf(x₀)), tol_abs)
            flag = 0 # CN1
         elseif norm(x_sol - xₖ) <= epsilon*max(tol_rel*norm(xₖ), tol_abs)
            flag = 1 # stagnation de l'itéré
         elseif abs(f(x_sol) - f(xₖ)) <= epsilon*max(tol_rel*abs(f(xₖ)), tol_abs)
            flag = 2 # stagnation de la fonction
         elseif nb_iters == max_iter
            flag = 3 # nombre d'iterations dépassé
         end
      end
   else
      flag = 0 # On a directement la solution
   end

    return x_sol, f_sol, flag, nb_iters, xₛ
end