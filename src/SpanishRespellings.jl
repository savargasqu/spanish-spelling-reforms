module SpanishSpellingReforms

using Base: TTY

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

function transcribe(patterns, input::TTY=stdin, output::TTY=stdout)
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
    if length(ARGS) == 0; usage_err() end

    p = getpatterns(ARGS[1])
    if p === nothing; usage_err() end

    transcribe(p, ARGS[2:end]...)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end

end # module
