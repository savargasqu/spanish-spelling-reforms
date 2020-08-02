#=
[Replace function
](https://docs.julialang.org/en/v1/base/strings/#Base.replace-Tuple{AbstractString,Pair})

The replace function takes a pair, where the value can be a substitution string
or a function
=#

function transliterate()
    teststr = """El rey dice: 'Yo SOY la ley'.
                 El bufón dice: Ahí hay chocolate"""

    # *y -> *i
    # Use a lookahead to know if the 'y' is at the end of a word
    # FIXME: Find a cleaner case-preserving substitution.
    #        This expression is too long…
    ypat = r"(y|Y)(?=\b)" => x -> isuppercase(x[1]) ? "I" : "i"
    resstr = replace(teststr, ypat)
    # h* -> Ø
    # Use a lookbehind to check that the 'h' is not preceded by a 'c'
    # The "ch" case should be handled differently
    hpat = r"(?<=[^c])h|H" => ""
    resstr = replace(resstr, hpat)
    resstr
end

println("$(transliterate())")

