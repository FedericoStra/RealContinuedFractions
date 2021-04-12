using RealContinuedFractions
using Test
using TestSetExtensions

@testset ExtendedTestSet "RealContinuedFractions.jl" begin
    @testset "constructor" begin
        @test ContinuedFraction(Float64[1,2,3]) == ContinuedFraction{Vector{Float64}}([1,2,3])
        @test ContinuedFraction(Float64[1,2,3]) != ContinuedFraction{Vector{Float64}}([1,2,3,4])
    end
    @testset "contfrac" begin
        @testset "0" begin
            @test contfrac(0) == ContinuedFraction{Vector{Int}}([0])
            @test contfrac(0.) == ContinuedFraction{Vector{Int}}([0])
            @test contfrac(0//1) == ContinuedFraction{Vector{Int}}([0])
            @test contfrac(Int8, 0) == ContinuedFraction{Vector{Int8}}([0])
            @test contfrac(Float64, 0) == ContinuedFraction{Vector{Float64}}([0])
        end
        @testset "π" begin
            @test contfrac(π, 5) == ContinuedFraction([3, 7, 15, 1, 292])
            @test_throws InexactError contfrac(Int8, π, 5)
            @test contfrac(Float64, π, 5) == ContinuedFraction([3., 7, 15, 1, 292])
            @test contfrac(big(π), 75) == ContinuedFraction{Vector{Int}}([
                3, 7, 15, 1, 292, 1, 1, 1, 2, 1, 3, 1, 14, 2, 1, 1, 2, 2,
                2, 2, 1, 84, 2, 1, 1, 15, 3, 13, 1, 4, 2, 6, 6, 99, 1, 2,
                2, 6, 3, 5, 1, 1, 6, 8, 1, 7, 1, 2, 3, 7, 1, 2, 1, 1, 12,
                1, 1, 1, 3, 1, 1, 8, 1, 1, 2, 1, 6, 1, 1, 5, 2, 2, 3, 1, 2])
        end
    end
    @testset "fromcontfrac" begin
        @test fromcontfrac(contfrac(π, 4)) == 355//113
        @test fromcontfrac(Int32, contfrac(big(π), 15)) == 245850922//78256779
        @test_throws OverflowError fromcontfrac(Int32, contfrac(big(π), 25))
        @test fromcontfrac(contfrac(big(π), 25)) == 8958937768937//2851718461558
        @test fromcontfrac(Int, contfrac(big(π), 25)) == 8958937768937//2851718461558
        @test_throws OverflowError fromcontfrac(Int, contfrac(big(π), 35))
        @test_throws OverflowError fromcontfrac(Int128, contfrac(big(π), 80))
        @test fromcontfrac(Float64, contfrac(big(π), 25)) == 3.141592653589793
    end
    @testset "roundtrip" begin
        @testset "contfrac ∘ fromcontfrac" begin
            for T in (UInt8, Int8, UInt16, Int16, UInt32, Int32, UInt64, Int64), len in 1:50
                q = filter(r -> r > 0, rand(T, len))
                isempty(q) && (q = T[0])
                q[end] == 1 && (q[end] = 2)
                cf = ContinuedFraction{Vector{T}}(q)
                @test contfrac(T, fromcontfrac(BigInt, cf)) == cf
            end
        end
        @testset "fromcontfrac ∘ contfrac" begin
            for _ in 1:100
                x = randn()
                @test fromcontfrac(Float64, contfrac(x, 1024)) ≈ x
                r = rationalize(x)
                @test fromcontfrac(contfrac(r)) == r
            end
        end
    end
    @testset "convergents" begin
        @test convergents(contfrac(π, 12)) == [
            3//1, 22//7, 333//106, 355//113, 103993//33102, 104348//33215, 208341//66317,
            312689//99532, 833719//265381, 1146408//364913, 4272943//1360120, 5419351//1725033]
        @test convergents(contfrac(big(π), 25))[end-5:end] == [
            14885392687//4738167652, 21053343141//6701487259, 1783366216531//567663097408,
            3587785776203//1142027682075, 5371151992734//1709690779483, 8958937768937//2851718461558]
    end
    @testset "convergent" begin
        cf = contfrac(big(π), 35)
        @test convergent(cf) == convergents(cf)[end]
        @test convergent(cf) == -6844906428587781119//7849984890429250040
        @test convergent(BigInt, cf) == 265099323460521503743//84383735478118508040
    end
end
