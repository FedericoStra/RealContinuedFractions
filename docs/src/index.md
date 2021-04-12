```@meta
CurrentModule = RealContinuedFractions
```

# RealContinuedFractions

Documentation for [RealContinuedFractions.jl](https://github.com/FedericoStra/RealContinuedFractions.jl).

```@contents
Depth = 3
```

## Examples

```jldoctest
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

julia> convergents(contfrac(π, 5))
5-element Vector{Rational{Int64}}:
      3//1
     22//7
    333//106
    355//113
 103993//33102
```

## Library

```@index
```

### Public

```@autodocs
Modules = [RealContinuedFractions]
Private = false
```

### Private

```@autodocs
Modules = [RealContinuedFractions]
Public = false
```
