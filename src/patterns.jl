"""Patterns for the Bello orthography"""
const bello_patterns = [
    r"y(?=\b)"i       => "i",    # /i/
    r"g(?=[eéií])"i   => "j",    # /x/
    r"gu(?=[eéií])"i  => "g",    # /g/
    r"ü"i             => "u",    # /gu/
    r"qu"i            => "q",    # /k/
    r"c(?=[^eéiíh])"i => "q",    # /k/
    r"c(?=[eéií])"i   => "z",    # /θ/ distinción
    r"(?<=[^c])h"i    => ""      # / /
]

""" Patterns for the Korreas orthography

This one is actually much more complex, and includes a lot on
the simplification of consonant clusters. These are only the basics.
"""
const korreas_patterns  = [
    r"y"i             => "i",    # /i/ this one happens everywhere
    r"j"i             => "x",    # /x/
    r"g(?=[eéií])"i   => "x",    # /x/
    r"gu(?=[eéií])"i  => "g",    # /gu/
    r"qu"i            => "k",    # /k/
    r"c(?=[^eéiíh])"i => "k",    # /k/
    r"c(?=[eéií])"i   => "z",    # /θ/ distinción
    r"(?<=[^c])h"i    => "",     # / /
]

"""Patterns for the Vallejo orthography

Note that this is the most Latin America-centric of the three.
"""
const vallejo_patterns = [
    r"y(?=\b)"i       => "i",    # /i/
    r"g(?=[eéií])"i   => "j",    # /x/
    r"gu(?=[eéií])"i  => "g",    # /g/
    r"ü"i             => "u",    # /gu/
    r"qu"i            => "k",    # /k/
    r"c(?=[^eéiíh])"i => "k",    # /k/
    r"c(?=[eéií])"i   => "s",    # /s/  seseo
    r"z"i             => "s",    # /s/  seseo
    r"ch"i            => "ṣ",    # /tʃ/ "ese rara"
    r"ll"i            => "ḷ",    # /ʎ/  "ele rara"
    r"\br|rr"i        => "ṛ",    # /r/  "erre rara"
    r"v"i             => "b",    # /β/  betacismo
    r"(?<=[^c])h"i    => "",     # / /
]
