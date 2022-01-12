using SimpleDelimitedFiles
using Test
using DelimitedFiles
using Aqua
using Printf

@testset "project quality" begin
    Aqua.test_all(SimpleDelimitedFiles)
end

@testset "Comparison with DelimitedFiles" begin
    mktemp() do fname, f
        A = rand(2, 2)
        writedlm(fname, A)
        @test readdlm(fname) == SimpleDelimitedFiles.readdlm(fname)
        A = rand(2, 2) * 2 .- 1
        writedlm(fname, A)
        @test readdlm(fname) == SimpleDelimitedFiles.readdlm(fname)
        @testset "single column" begin
            s = join([(@sprintf "%10.2f" i) for i in 1:4], '\n') * "\n"
            open(fname, "w") do f
                write(f, s)
            end
            @test readdlm(fname) == SimpleDelimitedFiles.readdlm(fname)
            # leading space
            s = join(["  " * (@sprintf "%10.2f" i) for i in 1:4], '\n') * "\n"
            open(fname, "w") do f
                write(f, s)
            end
            @test readdlm(fname) == SimpleDelimitedFiles.readdlm(fname)
            s = join([(s = @sprintf "%10.2f" i; "  $s $s") for i in 1:4], '\n') * "\n"
            open(fname, "w") do f
                write(f, s)
            end
            M = readdlm(fname, ' ')
            M = M[:, (x->all(y -> y isa Number, x)).(eachcol(M))]
            @test M  == SimpleDelimitedFiles.readdlm(fname, ' ')
        end
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
