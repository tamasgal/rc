try
    using OhMyREPL
catch
    println("No OhMyREPL installed.")
end

atreplinit() do repl
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
        println("No Revise installed.")
    end
end

ENV["PYTHON"] = "/home/tgal/.pyenv/shims/python"
