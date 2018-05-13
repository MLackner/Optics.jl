using Optics
# using RefractiveIndex
using Base.Test


# write your own tests here
# materials = Material[]
push!(materials, getdata("main", "au", "babar")) # tabulated nk
push!(materials, getdata("glass", "ami", "amtir-2")) # formula 1 / tabulated k
push!(materials, getdata("glass", "schott", "k7")) # formula 2 / tabulated k
push!(materials, getdata("glass", "hoya", "bac4")) # formula 3 / tabulated k
push!(materials, getdata("main", "Ag3AsS3", "Hulme-e.yml")) # formula 4
push!(materials, getdata("glass", "misc", "soda-lime/Rubin-bronze.yml")) # formula 5
push!(materials, getdata("main", "Ar", "Bideau-Mehu.yml")) # formula 6
push!(materials, getdata("main", "Si", "Edwards.yml")) # formula 7
push!(materials, getdata("main", "AgBr", "Schroter.yml")) # formula 8
push!(materials, getdata("organic", "CH4N2O - urea", "Rosker-e.yml")) # formula 9

# write your own tests here
@testset "Reflection Test" begin
    @test round(snellius(1.0, 1.5, deg2rad(60.0)), 5) == 0.61548
    @test reflection(materials[1], 4.6, deg2rad(60.0)) .* 1e5 .|> round == (99748, 98997)
    Φ = phaseangle(materials[1], 4.6, deg2rad(60.0))
    @test round.(rad2deg.(Φ), 3) == (-178.184, 7.261)
end

@testset "Transmittance Test" begin
    transmittance(n\underbar, d)
end
