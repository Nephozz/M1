# Ecrire les tests de l'algorithme du pas de Cauchy
using Test

function tester_cauchy(cauchy::Function)

    # tolérence pour les testset
    tol_erreur = sqrt(eps())

    # option pour Cauchy
    Δ = 1.0

	@testset "Pas de Cauchy" begin
        @testset "test normal" begin
            H, g = [7 0 ; 0 2], [-1; 0]
            s = cauchy(g, H, Δ)
            s_exacte_1 = [0.14285714285714285; 0.0]

            @test s ≈ s_exacte_1 atol=tol_erreur
        end

        @testset "test a < 0" begin
            H, g = [-2 0 ; -7 0], [1; 1]
            s = cauchy(g, H, Δ)
            s_exacte_2 = - (Δ / norm(g)) * g

            @test s ≈ s_exacte_2 atol=tol_erreur
        end

        @testset "test g = 0" begin
            H, g = [4 7 ; 7 4], [0; 0]
            s = cauchy(g, H, Δ)

            @test s ≈ g atol=tol_erreur
        end

        @testset "test t_opt > Δ" begin
            H, g = [0.01 0 ; 0 1], [4; 0]
            s = cauchy(g, H, Δ)
            s_exacte_3 = - (Δ / norm(g)) * g

            @test s ≈ s_exacte_3 atol=tol_erreur
        end
    end

end