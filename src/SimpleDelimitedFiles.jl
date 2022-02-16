module SimpleDelimitedFiles

@doc raw"""
    readdlm(source, [delim::Char = '\t'], [T::Type = Float64])

Read a delimited numerical matrix from the file named `source`. The elements
of the matrix should be of type `T`. The end of line delimiter is taken as `\n`.

For simple use cases, this is a more performant equivalent of `readdlm`
from `DelimitedFiles`. There are subtle differences though, for example this package
tries to aggressively remove multiple delimiters between entries, whereas `DelimitedFiles`
does not do this.

# Examples
```jldoctest
julia> f = tempname();

julia> using DelimitedFiles

julia> writedlm(f, ones(2, 2))

julia> SimpleDelimitedFiles.readdlm(f)
2×2 Matrix{Float64}:
 1.0  1.0
 1.0  1.0

julia> writedlm(f, ones(Int, 2, 2))

julia> SimpleDelimitedFiles.readdlm(f, Int)
2×2 Matrix{Int64}:
 1  1
 1  1

julia> writedlm(f, ones(Int, 2, 2), ',')

julia> SimpleDelimitedFiles.readdlm(f, ',', Int)
2×2 Matrix{Int64}:
 1  1
 1  1
```
"""
function readdlm(fname, delim::Char = '\t', T::Type = Float64)
    lines = open(fname, "r") do f
        readlines(f)
    end
    nrows = length(lines)
    r = Regex("[$delim]+")
    ncols = count(r, strip(lines[1])) + 1
    M = Matrix{T}(undef, nrows, ncols)
    for (rowind, l) in enumerate(lines)
        tokens = strip.(split(l, delim, keepempty = false))
        M[rowind, :] .= parse.(T, tokens)
    end
    return M
end
readdlm(fname, T::Type) = readdlm(fname, '\t', T)

end
