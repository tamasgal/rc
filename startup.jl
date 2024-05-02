ENV["PYTHON"] = "/opt/homebrew/bin/python3"
ENV["JULIA_EDITOR"] = "nvim"

# if isfile("Project.toml") && isfile("Manifest.toml")
#     using Pkg
#     Pkg.activate(".")
# end

if isinteractive()
    try
        using Revise
    catch e
        @warn "Error initializing Revise" exception=(e, catch_backtrace())
    end

    try
        using OhMyREPL
        colorscheme!("OneDark")
    catch e
        @warn "Error initializing OhMyREPL" exception=(e, catch_backtrace())
    end

    import BasicAutoloads
    BasicAutoloads.register_autoloads([
        ["@b", "@be"]            => :(using Chairmarks),
        ["@benchmark"]           => :(using BenchmarkTools),
        ["@test", "@testset", "@test_broken", "@test_deprecated", "@test_logs",
        "@test_nowarn", "@test_skip", "@test_throws", "@test_warn", "@inferred"] =>
                                    :(using Test),
        ["@about"]               => :(using About; macro about(x) Expr(:call, About.about, x) end),
    ])

    using LocalRegistry
    using Pkg
    macro register(package)
        Pkg.Registry.update()
        :(register($package, registry="KM3NeT", create_gitlab_mr=true))
    end
end

