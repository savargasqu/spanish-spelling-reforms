#=
[Replace function
](https://docs.julialang.org/en/v1/base/strings/#Base.replace-Tuple{AbstractString,Pair})
=#

# This function works on strings *not* chars
subkeepcase(old, new) = isuppercase(old[1]) ? uppercase(new) : lowercase(new)

function transliterate()
    teststr = """El rey dice: 'Yo SOY la ley'.
                 El bufón dice: Ahí hay chocolate"""
    # *y -> *i
    # Which of this is better?
    pattern_y = r"(y|Y)(?=\b)" => y -> subkeepcase(y, "i")

    pattern_y = r"i(?=\b)" => "i"
    pattern_Y = r"Y(?=\b)" => "I"

    teststr = replace(teststr, pattern_y)

    # // h -> Ø. The "ch" case should be handled differently
    h = r"(?<=[^c])h|H" => ""
    # /g/ gu{ei} -> g{ei}; gü -> gu
    g = r"gu(?=[eéií])" => "g"
    diaeresis = r"ü" => "u"
    # /k/ C, QU -> K
    ck =  r"c(?=[aáoóuú])" => "k"
    q = r"qu" => "k"
    # x = "x" => "ks" # More complicated than this
    # /s/ Z, C -> S (seseo)
    c = r"c(?=[eéií])" => "s"
    z = "z" => "s"
    # /θ/ C => Z (distinción)
    c = r"c(?=[eéií])" => "z"
    # /x/ G, J -> J
    g = r"g(?=[eéií])" => "j"
    # /j/ LL -> Y (yeísmo)
    ll = "ll" => "y"
    # /β/ B -> V (betacismo)
    b = "v" => "b"
end

println("$(transliterate())")

