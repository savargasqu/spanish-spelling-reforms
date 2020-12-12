module Transcriber

export transcribe, transcribefile

include("patterns.jl")

function getpatterns(orthography)
    o = lowercase(orthography)
    # Poor man's pattern matching
    if     o == "bello";   bello_patterns
    elseif o == "korreas"; korreas_patterns
    elseif o == "vallejo"; vallejo_patterns
    end
end

function keepcase(old, new)::Char
    if isuppercase(old); uppercase(new) else new end
end

function transcribe(orthography, str)
    patterns = getpatterns(orthography)
    for p in patterns
        str = replace(str, p[1] => x -> if p[2] === nothing; "" else keepcase(x[1], p[2]) end)
    end
    str
end

function transcribefile(orthography, infname, outfname=stdout)
    try
        t = open(infname) do infile
            transcribe(orthography, read(infile, String))
        end
        write(outfname, t)
    catch e
        println(e)
        exit(1)
    end
end

function main()
    try
        transcribefile(ARGS...)
    catch e
        println("""Not enough arguments. The script should be run as:
                julia transcriber.jl <orthography> <input> <output>""")
        println(e)
        exit(1)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end

end # module
