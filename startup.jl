ENV["PYTHON"] = "/opt/homebrew/bin/python3"

if isfile("Project.toml") && isfile("Manifest.toml")
    using Pkg
    Pkg.activate(".")
end

using BenchmarkTools
ENV["JULIA_EDITOR"] = "vim"


try
    using Revise
catch e
    @warn "Error initializing Revise" exception=(e, catch_backtrace())
end

#function showsubtypes(type; level = 1, indent = 4)
#    level == 1 && println(type)
#    for st in subtypes(type)
#        print(join(fill(" ", indent * level)))
#        println(st)
#        showsubtypes(st; level = level + 1, indent = indent)
#    end
#end
