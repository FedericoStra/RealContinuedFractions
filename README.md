# RealContinuedFractions

<!-- ![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg) -->
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://FedericoStra.github.io/RealContinuedFractions.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://FedericoStra.github.io/RealContinuedFractions.jl/dev)
[![Build Status](https://github.com/FedericoStra/RealContinuedFractions.jl/workflows/CI/badge.svg)](https://github.com/FedericoStra/RealContinuedFractions.jl/actions)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)

## Examples

```julia
julia> using RealContinuedFractions

julia> fromcontfrac(contfrac(π, 4))
355//113

julia> fromcontfrac(contfrac(big(π), 25))
8958937768937//2851718461558

julia> cf = contfrac(6283//2000)
ContinuedFraction{Vector{Int64}}([3, 7, 14, 1, 8, 2])

julia> fromcontfrac(cf)
6283//2000

julia> fromcontfrac(Float64, cf)
3.1415
```
