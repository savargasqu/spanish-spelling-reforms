
const spellpatterns = [
    (r"y(?=\b)"i      , "i") # /i/  *y  -> *i
    (r"(?<=[^c])h"i   , "" ) # / /  h   -> Ø
    (r"c(?=[^eéiíh])"i, "k") # /k/  C   -> K
    (r"qu"i           , "k") # /k/  QU  -> K
    (r"gu(?=[eéií])"i , "g") # /g/  gu* -> g*
    (r"ü"i            , "u") # /gu/ gü  -> gu
    (r"g(?=[eéií])"i  , "j") # /x/  G   -> J
    (r"c(?=[eéií])"i  , "s") # /s/  C   -> S (seseo)
    (r"z"i            , "s") # /s/  Z   -> S (seseo)
    #(r"v"i            , "b") # /β/  V   -> B (betacismo)
    #(r"ll"i           , "y") # /j/  LL  -> Y (yeísmo)
    #(r"c(?=[eéií])"i  , "z") # /θ/  C   -> Z (distinción)
]

# This function works on strings *not* chars
keepcase(old, new) = isuppercase(old[1]) ? uppercase(new) : lowercase(new)

function transliterate(str)
    for p in spellpatterns
        str = replace(str, p[1] => x -> keepcase(x, p[2]))
    end
    str
end

function read_and_transliterate(infilename, outfilename)
    infile = open(infilename)
    open(infilename) do infile
        open(outfilename, "w") do outfile
            write(outfile, transliterate(read(infile, String)))
        end
    end
end

read_and_transliterate("test/input.txt", "test/output.txt")

