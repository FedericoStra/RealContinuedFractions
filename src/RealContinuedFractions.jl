module RealContinuedFractions

export ContinuedFraction, contfrac, fromcontfrac, quotients, convergents

"""
    ContinuedFraction(q::Q)

Type representing a continued fraction, storing the terms with the type `Q`.
"""
struct ContinuedFraction{Q}
    q::Q # quotients
end

import Base: ==, eltype, length

==(a::ContinuedFraction, b::ContinuedFraction) = a.q == b.q

eltype(cf::ContinuedFraction) = eltype(cf.q)
length(cf::ContinuedFraction) = length(cf.q)

"""
    contfrac(x::Real)
    contfrac(x::Real, n::Integer)
    contfrac(T::Type, x::Real)
    contfrac(T::Type, x::Real, n::Integer)

Compute the first `n` terms of the continued fraction of `x`, representing it with type `T`
(defaults to `Int`).
"""
function contfrac end

contfrac(x::Real) = contfrac(Int, x)
contfrac(x::Real, n::Integer) = contfrac(Int, x, n)

function contfrac(T::Type, x::Real)
    q = T[]
    while true
        fpart, ipart = modf(x)
        push!(q, T(ipart))
        fpart == 0 && return ContinuedFraction(q)
        x = inv(fpart)
    end
end

function contfrac(T::Type, x::Real, n::Integer)
    q = T[]
    for _ in 1:n
        fpart, ipart = modf(x)
        push!(q, T(ipart))
        fpart == 0 && return ContinuedFraction(q)
        x = inv(fpart)
    end
    ContinuedFraction(q)
end

"""
    fromcontfrac(cf::ContinuedFraction)
    fromcontfrac(T::Type, cf::ContinuedFraction)

Evaluate the continued fraction `cf` using the type `T` (defaults to the rational type
associated with `eltype(cf)`).
"""
function fromcontfrac end

fromcontfrac(cf::ContinuedFraction) = fromcontfrac(_rational(eltype(cf)), cf)

function fromcontfrac(T::Type, cf::ContinuedFraction)
    T = _rational(T)
    # return foldr((x, y) -> T(x) + inv(y), cf.q[1:end-1]; init=T(cf.q[end]))
    indices = reverse(eachindex(cf.q))
    x = T(cf.q[indices[1]])
    for i in indices[2:end]
        x = T(cf.q[i]) + inv(x)
    end
    x
end

"""
    _rational(::Type)

Promote integral types to rational and leave others as they are.
"""
function _rational end

_rational(T::Type{<:Integer}) = Rational{T}
# _rational(T::Type{<:Rational}) = T
_rational(T::Type) = T

end # module
