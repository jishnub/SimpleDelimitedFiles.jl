using SimpleDelimitedFiles
using Test
using DelimitedFiles

@testset "Comparison with DelimitedFiles" begin
    mktemp() do fname, f
        A = rand(2, 2)
        writedlm(fname, A)
        @test readdlm(fname) == SimpleDelimitedFiles.readdlm(fname)
        A = rand(2, 2)*2 .- 1
        writedlm(fname, A)
        @test readdlm(fname) == SimpleDelimitedFiles.readdlm(fname)
        for T in [Float64, Int]
            A = rand(T, 2, 2)
            writedlm(fname, A)
            @test readdlm(fname, T) == SimpleDelimitedFiles.readdlm(fname, T)
            for delim in [',', '\t', ' ']
                writedlm(fname, A, delim)
                @test readdlm(fname, delim, T) == SimpleDelimitedFiles.readdlm(fname, delim, T)
            end
        end
    end
end
