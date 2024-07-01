local opts = require("lsp.server_settings.default")
local settings = {

    Lua = {
        diagnostics = {
            globals = { "vim" },
        },
        workspace = {
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
            },
        },
    },
}
opts["settings"] = settings
return opts
