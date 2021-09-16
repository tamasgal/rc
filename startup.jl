# try
#     using OhMyREPL
# catch
# end
atreplinit() do repl
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch e
        @warn(e.msg)
    end
end


function showsubtypes(type; level = 1, indent = 4)
    level == 1 && println(type)
    for st in subtypes(type)
        print(join(fill(" ", indent * level)))
        println(st)
        showsubtypes(st; level = level + 1, indent = indent)
    end
end
