# This isn't a real unit test
include("src/transcriber.jl")
using Main.Transcriber

transcribefile(bello_patterns,   "examples/derechos-humanos.txt", "examples/output-bello.txt")
transcribefile(korreas_patterns, "examples/derechos-humanos.txt", "examples/output-korreas.txt")
transcribefile(vallejo_patterns, "examples/derechos-humanos.txt", "examples/output-vallejo.txt")

