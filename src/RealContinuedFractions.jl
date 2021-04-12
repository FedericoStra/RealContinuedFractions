module RealContinuedFractions

export ContinuedFraction, contfrac, fromcontfrac, quotients, convergents

struct ContinuedFraction{Q}
    q::Q # quotients
end

import Base: eltype, length

eltype(cf::ContinuedFraction) = eltype(cf.q)
length(cf::ContinuedFraction) = length(cf.q)

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

fromcontfrac(cf::ContinuedFraction) = fromcontfrac(_rational(eltype(cf)), cf)

function fromcontfrac(T::Type, cf::ContinuedFraction)
    foldr((x, y) -> T(x) + inv(y), cf.q[1:end-1]; init=T(cf.q[end]))
end

export fromcontfrac_fast

fromcontfrac_fast(cf::ContinuedFraction) = fromcontfrac_fast(_rational(eltype(cf)), cf)

function fromcontfrac_fast(T::Type, cf::ContinuedFraction)
    indices = reverse(eachindex(cf.q))
    x = T(cf.q[indices[1]])
    for i in indices[2:end]
        x = T(cf.q[i]) + inv(x)
    end
    x
end

_rational(T::Type{<:Rational}) = T
_rational(T::Type{<:Integer}) = Rational{T}

end # module
