using LinearAlgebra
"""
Approximation de la solution du problème 

    min qₖ(s) = s'gₖ + 1/2 s' Hₖ s, sous la contrainte ‖s‖ ≤ Δₖ

# Syntaxe

    s = gct(g, H, Δ; kwargs...)

# Entrées

    - g : (Vector{<:Real}) le vecteur gₖ
    - H : (Matrix{<:Real}) la matrice Hₖ
    - Δ : (Real) le scalaire Δₖ
    - kwargs  : les options sous formes d'arguments "keywords", c'est-à-dire des arguments nommés
        • max_iter : le nombre maximal d'iterations (optionnel, par défaut 100)
        • tol_abs  : la tolérence absolue (optionnel, par défaut 1e-10)
        • tol_rel  : la tolérence relative (optionnel, par défaut 1e-8)

# Sorties

    - s : (Vector{<:Real}) une approximation de la solution du problème

# Exemple d'appel

    g = [0; 0]
    H = [7 0 ; 0 2]
    Δ = 1
    s = gct(g, H, Δ)

"""
function gct(g::Vector{<:Real}, H::Matrix{<:Real}, Δ::Real; 
    max_iter::Integer = 100, 
    tol_abs::Real = 1e-10, 
    tol_rel::Real = 1e-8)

    j = 0
    g₀ = g
    s = 0*g
    p = -g
    gⱼ = g₀

    while j < max_iter && norm(gⱼ) > max(norm(g₀)*tol_rel,tol_abs)
        
        κ = p' * H * p

        a = norm(p)^2
        b = 2* s' * p
        c = (norm(s)^2 - Δ^2)
        σ1 = (-b -sqrt(b^2 - 4*a*c))/(2*a)
        σ2 = (-b +sqrt(b^2 - 4*a*c))/(2*a)

        if κ <= 0
            r1 = s + σ1 * p
            r2 = s + σ2 * p

            q1 = r1' * g + 1/2 * r1' * H * r1
            q2 = r2' * g + 1/2 * r2' * H * r2

            if q1 < q2
                σ = σ1
            else
                σ = σ2
            end
            return s + σ * p
        end
        α = gⱼ' * gⱼ / κ

        if norm(s + α * p) >= Δ
            σ = max(σ1,σ2)
            return s + σ * p
        end

        s = s + α * p
        gⱼ_plus_un = gⱼ + α * H * p
        β = (gⱼ_plus_un' * gⱼ_plus_un) / (gⱼ' * gⱼ)
        p = -gⱼ_plus_un + β * p
        gⱼ = gⱼ_plus_un
        j += 1
    end
        
    return s
end
