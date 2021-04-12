module RealContinuedFractions

export ContinuedFraction, contfrac, fromcontfrac, convergents, convergent

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
    convergents(cf::ContinuedFraction)
    convergents(T::Type, cf::ContinuedFraction)

Compute the convergents of the continued fraction.
"""
function convergents end

convergents(cf::ContinuedFraction) = convergents(eltype(cf), cf)

convergents(::Type{<:Rational{T}}, cf::ContinuedFraction) where T = convergents(T, cf)

function convergents(T::Type, cf::ContinuedFraction)
    na, da, nb, db = T(1), T(0), T(cf.q[1]), T(1)
    v = Rational{T}[nb//db]
    for x in cf.q[2:end]
        na, da, nb, db = nb, db, na+x*nb, da+x*db
        push!(v, nb//db)
    end
    v
end

"""
    convergents(cf::ContinuedFraction)
    convergents(T::Type, cf::ContinuedFraction)

Compute the last convergent of the continued fraction.

These are almost equivalent to
    
    fromcontfrac(cf)
    fromcontfrac(Rational{T}, cf)

but perform the computation in the opposite order.

Moreover, it does not use the type `Rational` internally, so it does not check for overflow.
"""
function convergent end

convergent(cf::ContinuedFraction) = convergent(eltype(cf), cf)

convergent(::Type{<:Rational{T}}, cf::ContinuedFraction) where T = convergent(T, cf)

function convergent(T::Type, cf::ContinuedFraction)
    na, da, nb, db = T(1), T(0), T(cf.q[1]), T(1)
    for x in cf.q[2:end]
        na, da, nb, db = nb, db, na+x*nb, da+x*db
    end
    nb//db
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
