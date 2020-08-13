# This isn't a real unit test
include("src/transcriber.jl")
using Main.Transcriber

transcribefile("bello",   "examples/derechos-humanos.txt", "examples/output-bello.txt")
transcribefile("korreas", "examples/derechos-humanos.txt", "examples/output-korreas.txt")
transcribefile("vallejo", "examples/derechos-humanos.txt", "examples/output-vallejo.txt")

