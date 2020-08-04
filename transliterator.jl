#=
[Replace function
](https://docs.julialang.org/en/v1/base/strings/#Base.replace-Tuple{AbstractString,Pair})
=#

# TODO: Put this in a file
const TEST = """
Quizás
queso
aquí
Colombia
casa
volcán
chocolate
clase
microcosmos
general
ginebra
guiso
guerra
hombre
hueso
Cisne
cielo
hoy
yuca
lluvia
allanamiento
"""

# FIXME: Should these be structs instead of tuples?
#        This a array should be a constant
spellpatterns = [
    (r"y(?=\b)"i      , "i") # /i/  *y  -> *i
    (r"(?<=[^c])h"i   , "" ) # / /  h   -> Ø
    (r"c(?=[^eéiíh])"i, "k") # /k/  C   -> K
    (r"qu"i           , "k") # /k/  QU  -> K
    (r"gu(?=[eéií])"i , "g") # /g/  gu* -> g*
    (r"ü"i            , "u") # /gu/ gü  -> gu
    (r"g(?=[eéií])"i  , "j") # /x/  G   -> J
    (r"c(?=[eéií])"i  , "s") # /s/  C   -> S (seseo)
    (r"z"i            , "s") # /s/  Z   -> S (seseo)
]
    #(r"v"i            , "b") # /β/  V   -> B (betacismo)
    #(r"ll"i           , "y") # /j/  LL  -> Y (yeísmo)
    #(r"c(?=[eéií])"i  , "z") # /θ/  C   -> Z (distinción)

# This function works on strings *not* chars
keepcase(old, new) = isuppercase(old[1]) ? uppercase(new) : lowercase(new)

function transliterate(str)
    # *y -> *i
    #tempstr = replace(str, r"y(?=\b)"i => y -> keepcase(y, "i"))
    for p in spellpatterns
        str = replace(str, p[1] => x -> keepcase(x, p[2]))
        #println(p)
    end
    str
end

println("$(transliterate(TEST))")

