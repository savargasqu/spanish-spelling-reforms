module SpanishSpellingReforms

export transcribe

include("patterns.jl")

keepcase(old, new) = isuppercase(old) ? uppercase(new) : new

function transcribe(patterns, buf::AbstractString)
    str = buf
    for p in patterns
        str = replace(str, p[1] => x -> keepcase(x[1], p[2]))
    end
    str
end

function transcribefile(patterns, input::IO=stdin, output::IO=stdout)
    write(output, transcribe(patterns, read(input, String)))
end

function getpatterns(flag)
    if     flag == "-b"; bello_patterns
    elseif flag == "-k"; korreas_patterns
    elseif flag == "-v"; vallejo_patterns
    else nothing
    end
end


usage_err() = error("Usage: julia SpanishRespellings.jl [-bkv] <input> [<output>]")

function main()
    l = length(ARGS)
    l == 0 && usage_err()

    p = getpatterns(ARGS[1])
    p === nothing && usage_err()

    if l == 1
        transcribefile(p)
    else
        open(ARGS[2]) do fin
            if l == 2
                transcribefile(p, fin)
            elseif l == 3
                open(ARGS[3], "a") do fout
                    transcribefile(p, fin, fout)
                end
            end
        end
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end

end # module
