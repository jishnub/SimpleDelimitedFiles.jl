module SimpleDelimitedFiles

using InvertedIndices

@doc raw"""
    readdlm(source, [delim::Char = '\t'], [T::Type = Float64]; [kwargs...])

Read a delimited numerical matrix from the file named `source`. The elements
of the matrix should be of type `T`. The end of line delimiter is taken as `\n`.
Unlike `DelimitedFiles`, this package won't try to determine the element type from
the data, and will throw an error if the values can't be converted to type `T`.

For simple use cases, this is a more performant equivalent of `DelimitedFiles.readdlm`.
There are subtle differences though, for example this package
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

# Optional keyword arguments
* `skipstart[ = 0]`: Skip the first `skipstart` lines while reading the file
* `header[ = false]`: Indicates whether there is a row of column headers in the data.
    This headers may be obtained using [`SimpleDelimitedFiles.read_header`](@ref). This is taken to be
    `false` by default, which means an error will be thrown if the data does contain a header.
    If `skipstart` is true, the first `skipstart` lines are ignored before checking for the header.
* `comments[ = false]`: Indicate whether there are comments in the file that are to be ignored.
    The comments must begin with `comment_char`.
* `comment_char[ = '#']`: The character that signifies a comment. If `comments` is `true`, the lines
    that begin with `comment_char` are ignored.
"""
function readdlm(fname, delim::Char = '\t', T::Type = Float64;
        header = false,
        skipstart = 0, comments=false, comment_char='#')

    lines = open(fname, "r") do f
        lines = readlines(f)
        lines = @view lines[skipstart + begin:end]
        lines = lines[Not(findall(isempty, lines))]
    end
    if header
        @info("skipping header, "*
            "use SimpleDelimitedFiles.read_header(\""*string(fname)*
            "\") to obtain the columns headers as a vector")
        lines = @view lines[2:end]
    end
    if comments
        lines = @view lines[Not(findall(startswith(comment_char), lines))]
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

@doc raw"""
    read_header(source, [delim::Char = '\t']; [kwargs...])

Read column headers from a file that are separated by `delim`.
Returns `nothing` if no headers are found in the file.

# Optional keyword arguments
* `skipstart[ = 0]`: Skip the first `skipstart` lines while reading the file
* `comments[ = false]`: Indicate whether there are comments in the file that are to be ignored.
    The comments must begin with `comment_char`.
* `comment_char[ = '#']`: The character that signifies a comment. If `comments` is `true`, the lines
    that begin with `comment_char` are ignored.
"""
function read_header(fname, delim::Char = '\t';
    skipstart = 0, comments=false, comment_char='#')

    headerline = open(fname, "r") do f
        for (ind, line) in enumerate(eachline(f))
            ind <= skipstart && continue
            comments && startswith(line, comment_char) && continue
            return line
        end
        return nothing
    end
    headerline === nothing && return nothing
    r = Regex("[$delim]+")
    ncols = count(r, strip(headerline)) + 1
    tokens = strip.(split(headerline, delim, keepempty = false))
end

end
