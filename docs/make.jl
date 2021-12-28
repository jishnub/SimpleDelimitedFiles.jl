using SimpleDelimitedFiles
using Documenter

DocMeta.setdocmeta!(SimpleDelimitedFiles, :DocTestSetup, :(using SimpleDelimitedFiles); recursive = true)

makedocs(;
    modules = [SimpleDelimitedFiles],
    authors = "Jishnu Bhattacharya",
    repo = "https://github.com/jishnub/SimpleDelimitedFiles.jl/blob/{commit}{path}#L{line}",
    sitename = "SimpleDelimitedFiles",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://jishnub.github.io/SimpleDelimitedFiles.jl",
        assets = String[]
    ),
    pages = [
        "Reference" => "index.md",
    ]
)

deploydocs(;
    repo = "github.com/jishnub/SimpleDelimitedFiles.jl",
    devbranch = "main",
)
