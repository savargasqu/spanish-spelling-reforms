const spellpatterns = [
    (r"(?=[^c])h"i, nothing) # / /  h   -> Ø
    (r"y(?=\b)"i      , 'i') # /i/  *y  -> *i
    (r"c(?=[^eéiíh])"i, 'k') # /k/  C   -> K
    (r"qu"i           , 'k') # /k/  QU  -> K
    (r"gu(?=[eéií])"i , 'g') # /g/  gu* -> g*
    (r"ü"i            , 'u') # /gu/ gü  -> gu
    (r"g(?=[eéií])"i  , 'j') # /x/  G   -> J
    (r"c(?=[eéií])"i  , 's') # /s/  C   -> S (seseo)
    (r"z"i            , 's') # /s/  Z   -> S (seseo)
    (r"ll"i           , 'y') # /j/  LL  -> Y (yeísmo)
]
    #(r"v"i            , 'b') # /β/  V   -> B (betacismo)
    #(r"c(?=[eéií])"i  , 'z') # /θ/  C   -> Z (distinción)

keepcase(old, new::Char) = isuppercase(old) ? uppercase(new) : new
keepcase(old, new::String) = isuppercase(old) ? uppercase(new) : new

function transliterate(str)
    for p in spellpatterns
        str = replace(str, p[1] => x -> keepcase(x[1], p[2] != nothing ? p[2] : ""))
    end
    str
end

function transliteratefile(infname, outfname)
    t = open(infname) do infile
        transliterate(read(infile, String))
    end
    write(outfname, t)
end

transliteratefile("test/input.txt", "test/output.txt")
