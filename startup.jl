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

ENV["JULIA_EDITOR"] = "emacsclient -nw"
using InteractiveUtils
InteractiveUtils.define_editor([
    "vim", "vi", "nvim", "mvim", "nano",
    r"\bemacs\b.*\s(-nw|--no-window-system)\b",
    r"\bemacsclient\b.\s*-(-?nw|t|-?tty)\b"], wait=true) do cmd, path, line
        `$cmd +$line $path`
    end

# ENV["PYTHON"] = "/home/tgal/.pyenv/shims/python"
