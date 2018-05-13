

function reflectioncoeff(n₁::T, n₂::T, θᵢ::Real) where T <: Number
    θₜ = snellius(n₁, n₂, θᵢ)
    rₛ = (n₁*cos(θᵢ) - n₂*cos(θₜ)) ./ (n₁*cos(θᵢ) + n₂*cos(θₜ))
    rₚ = (n₂*cos(θᵢ) - n₁*cos(θₜ)) ./ (n₁*cos(θₜ) + n₂*cos(θᵢ))
    rₛ, rₚ
end

function reflection(n₁::Number, n₂::Number, θᵢ::Real)
    rₛ, rₚ = reflectioncoeff(n₁, n₂, θᵢ)
    Rₛ = abs(rₛ).^2
    Rₚ = abs(rₚ).^2
    Rₛ, Rₚ
end

function reflection(m::RefractiveIndex.Material, λ::Real, θ::Real)
    k₂ = m.kfun(λ)
    typeof(k₂) == Void ? (n₂ = m.nfun(λ)) : (n₂ = m.nfun(λ) + k₂*im)
    reflection(one(typeof(n₂)), n₂, θ) 
end

function phaseangle(n₁::Number, n₂::Number, θᵢ::Real)
    rₛ, rₚ = reflectioncoeff(n₁, n₂, θᵢ)
    Φₛ = angle(rₛ)
    Φₚ = angle(rₚ)
    Φₛ, Φₚ
end

function phaseangle(m::RefractiveIndex.Material, λ::Real, θ::Real)
    k₂ = m.kfun(λ)
    typeof(k₂) == Void ? (n₂ = m.nfun(λ)) : (n₂ = m.nfun(λ) + k₂*im)
    phaseangle(one(typeof(n₂)), n₂, θ) 
end

function get_complex_ior(m::RefractiveIndex.Material, λ::Real)
    n = m.nfun(λ)
    k = m.kfun(λ)
    n̲ = n + k*im
end

function snellius(n₁::Number, n₂::Number, θᵢ::Real)
    θₜ = asin(n₁ ./ n₂ .* sin(θᵢ))
end