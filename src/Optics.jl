__precompile__(false)

module Optics

import RefractiveIndex: Material

include("reflection.jl")
include("transmittance.jl")

export phaseangle, reflection, snellius, transmittance

end # module
