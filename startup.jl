ENV["JULIA_EDITOR"] = "nvim"

if isinteractive()

    try
        using Revise
    catch e
        #@warn "Error initializing Revise" exception=(e, catch_backtrace())
        @warn "Error initializing Revise"
    end

#    try
#        using OhMyREPL
#        colorscheme!("OneDark")
#    catch e
#        @warn "Error initializing OhMyREPL" exception=(e, catch_backtrace())
#    end

    using REPL
    atreplinit(repl -> begin
#        Base.active_repl.options.hint_tab_completes = false
        # quickfix for path completion issue (don't add closing quotes)
#        @eval REPL.REPLCompletions close_path_completion(d, ps, s, p) = false
    end)

    try
        import BasicAutoloads
        BasicAutoloads.register_autoloads([
            ["@b", "@be"]            => :(using Chairmarks),
            ["@benchmark"]           => :(using BenchmarkTools),
            ["@test", "@testset", "@test_broken", "@test_deprecated", "@test_logs",
            "@test_nowarn", "@test_skip", "@test_throws", "@test_warn", "@inferred"] =>
                                        :(using Test),
            ["@about"]               => :(using About; macro about(x) Expr(:call, About.about, x) end),
        ])
    catch e
        @warn "Error initialising BasicAutoloads"
    end

    try
        using LocalRegistry
    catch e
        @warn "Error initialising LocalRegistry"
    end
    using Pkg
    macro register(package)
        Pkg.Registry.update()
        :(register($package, registry="KM3NeT", create_gitlab_mr=true))
    end
end

