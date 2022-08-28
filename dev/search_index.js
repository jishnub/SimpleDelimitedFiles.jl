var documenterSearchIndex = {"docs":
[{"location":"","page":"Reference","title":"Reference","text":"CurrentModule = SimpleDelimitedFiles\nDocTestSetup = quote\n\tusing SimpleDelimitedFiles\nend","category":"page"},{"location":"#Reference","page":"Reference","title":"Reference","text":"","category":"section"},{"location":"","page":"Reference","title":"Reference","text":"Modules = [SimpleDelimitedFiles]","category":"page"},{"location":"#SimpleDelimitedFiles.read_header","page":"Reference","title":"SimpleDelimitedFiles.read_header","text":"read_header(source, [delim::Char = '\\t']; [kwargs...])\n\nRead column headers from a file that are separated by delim. Returns nothing if no headers are found in the file.\n\nOptional keyword arguments\n\nskipstart[ = 0]: Skip the first skipstart lines while reading the file\ncomments[ = false]: Indicate whether there are comments in the file that are to be ignored.   The comments must begin with comment_char.\ncomment_char[ = '#']: The character that signifies a comment. If comments is true, the lines   that begin with comment_char are ignored.\n\n\n\n\n\n","category":"function"},{"location":"#SimpleDelimitedFiles.readdlm","page":"Reference","title":"SimpleDelimitedFiles.readdlm","text":"readdlm(source, [delim::Char = '\\t'], [T::Type = Float64]; [kwargs...])\n\nRead a delimited numerical matrix from the file named source. The elements of the matrix should be of type T. The end of line delimiter is taken as \\n. Unlike DelimitedFiles, this package won't try to determine the element type from the data, and will throw an error if the values can't be converted to type T.\n\nFor simple use cases, this is a more performant equivalent of DelimitedFiles.readdlm. There are subtle differences though, for example this package tries to aggressively remove multiple delimiters between entries, whereas DelimitedFiles does not do this.\n\nExamples\n\njulia> f = tempname();\n\njulia> using DelimitedFiles\n\njulia> writedlm(f, ones(2, 2))\n\njulia> SimpleDelimitedFiles.readdlm(f)\n2×2 Matrix{Float64}:\n 1.0  1.0\n 1.0  1.0\n\njulia> writedlm(f, ones(Int, 2, 2))\n\njulia> SimpleDelimitedFiles.readdlm(f, Int)\n2×2 Matrix{Int64}:\n 1  1\n 1  1\n\njulia> writedlm(f, ones(Int, 2, 2), ',')\n\njulia> SimpleDelimitedFiles.readdlm(f, ',', Int)\n2×2 Matrix{Int64}:\n 1  1\n 1  1\n\nOptional keyword arguments\n\nskipstart[ = 0]: Skip the first skipstart lines while reading the file\nheader[ = false]: Indicates whether there is a row of column headers in the data.   This headers may be obtained using SimpleDelimitedFiles.read_header. This is taken to be   false by default, which means an error will be thrown if the data does contain a header.   If skipstart is true, the first skipstart lines are ignored before checking for the header.\ncomments[ = false]: Indicate whether there are comments in the file that are to be ignored.   The comments must begin with comment_char.\ncomment_char[ = '#']: The character that signifies a comment. If comments is true, the lines   that begin with comment_char are ignored.\n\n\n\n\n\n","category":"function"}]
}
