using RealContinuedFractions
using Documenter

DocMeta.setdocmeta!(RealContinuedFractions, :DocTestSetup, :(using RealContinuedFractions); recursive=true)

makedocs(;
    modules=[RealContinuedFractions],
    authors="Federico Stra <stra.federico@gmail.com> and contributors",
    repo="https://github.com/FedericoStra/RealContinuedFractions.jl/blob/{commit}{path}#{line}",
    sitename="RealContinuedFractions.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://FedericoStra.github.io/RealContinuedFractions.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/FedericoStra/RealContinuedFractions.jl",
)
