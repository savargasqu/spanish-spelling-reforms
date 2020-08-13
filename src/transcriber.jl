module Transcriber

export transcribe, transcribefile

include("patterns.jl")

function getpatterns(orthography)
    if orthography == "bello" || orthography == "Bello"
        return bello_patterns
    elseif orthography == "korreas" || orthography == "Korreas"
        return korreas_patterns
    elseif orthography == "vallejo" || orthography == "Vallejo"
        return vallejo_patterns
    end
end

function keepcase(old, new)::Char
    isuppercase(old) ? uppercase(new) : new
end

function transcribe(orthography, str)
    patterns = getpatterns(orthography)
    for p in patterns
        str = replace(str, p[1] => x -> p[2] == nothing ? "" : keepcase(x[1], p[2]))
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

end #module

