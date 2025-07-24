module PalimpsestCryptoIdentity

using ArgParse
using Logging

function main(args::Vector{String} = ARGS)
    # Main entry point for the application
    println("Palimpsest Crypto Identity Generator")
end

# Allow script to be run directly
if abspath(PROGRAM_FILE) == @__FILE__
    main(ARGS)
end

end # module
