# SimpleDelimitedFiles

[![Unit test](https://github.com/jishnub/SimpleDelimitedFiles.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/jishnub/SimpleDelimitedFiles.jl/actions/workflows/CI.yml)

This is a very basic package meant to read in numerical matrices from files.
This package defines its own `readdlm` function that is not exported.
For more advanced usage consider using the stdlib `DelimitedFiles`.

Examples of usage:

```julia
julia> using DelimitedFiles, SimpleDelimitedFiles

julia> A = rand(2,2)
2×2 Matrix{Float64}:
 0.0630187  0.351596
 0.257851   0.601259

julia> writedlm(f, A) # from DelimitedFiles

julia> SimpleDelimitedFiles.readdlm(f)
2×2 Matrix{Float64}:
 0.0630187  0.351596
 0.257851   0.601259

julia> A = rand(100, 100); # A larger matrix for performance benchmarks

julia> f = tempname();

julia> writedlm(f, A)

julia> readdlm(f) == SimpleDelimitedFiles.readdlm(f)
true

julia> @time readdlm(f);
  0.084439 seconds (597.56 k allocations: 15.646 MiB)

julia> @time SimpleDelimitedFiles.readdlm(f);
  0.004552 seconds (1.23 k allocations: 852.065 KiB)
```

The function defined in this package uses less memory, and is often more performant. However this function does not support most functionality from `DelimitedFiles` at present, eg. headers. It's useful if you want to quickly read in files where the data is known to be a numerical matrix, and whose element type is either known, or may be parsed as `Float64`.

For even more performant IO, consider using `CSV.jl`. This package provides a middle ground with lower runtimes than `DelimitedFiles` and lower compile times than `CSV.jl`.
