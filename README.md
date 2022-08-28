# SimpleDelimitedFiles

[![Unit test](https://github.com/jishnub/SimpleDelimitedFiles.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/jishnub/SimpleDelimitedFiles.jl/actions/workflows/CI.yml)
[![docs:stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jishnub.github.io/SimpleDelimitedFiles.jl/stable)
[![docs:dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jishnub.github.io/SimpleDelimitedFiles.jl/dev)

# Update
This package is largely unnecessary on julia `v1.8`, as `DelimitedFiles` is comparably fast now. The performance comparison below was carried out on julia `v1.7`, where this package still has a comparative edge. If you're using julia `v1.8` and above, you may choose `DelimitedFiles` instead, which will be better maintained.

# About the package
This is a very basic package meant to read in numerical matrices from files.
This package defines its own `readdlm` function that is not exported.
For more advanced usage consider using `DelimitedFiles`.

Examples of usage:

```julia
julia> using DelimitedFiles, SimpleDelimitedFiles

julia> A = rand(2,2)
2×2 Matrix{Float64}:
 0.0630187  0.351596
 0.257851   0.601259

julia> f = tempname();

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
  0.005872 seconds (1.33 k allocations: 1.076 MiB)
```

The function defined in this package uses less memory, and is often more performant. However this function may not support some functionality from `DelimitedFiles`. This package is useful if you want to quickly read in files where the data is known to be a numerical matrix, and whose element type is either known, or may be parsed as `Float64`.

For even more performant IO, consider using `CSV.jl`. This package provides a middle ground with lower runtimes than `DelimitedFiles` and lower compile times than `CSV.jl`.
