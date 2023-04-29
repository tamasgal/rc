using BenchmarkTools
using OhMyREPL
ENV["JULIA_EDITOR"] = "vim"

#= ENV["PYTHON"] = "/Users/tamasgal/.pyenv/versions/3.6.0/bin/python" =#

@spawn @sync begin
sleep(5)
    Base.active_repl.interface.modes[1].prompt="v$VERSION> "
end

#= @schedule begin =#
#=     sleep(0.1) =#
#=     @eval using Revise =#
#= end =#
