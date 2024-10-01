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
local current_file = vim.fn.expand('%:p')
local parent_dir = vim.fn.fnamemodify(current_file, ":h")
local parent_dir_name = vim.fn.fnamemodify(parent_dir, ":t")
if parent_dir_name == '.hammerspoon' then
    settings.Lua.workspace.library[vim.fn.expand("~") .. "/.hammerspoon/Spoons/EmmyLua.spoon/annotations"] = true
end
opts["settings"] = settings
return opts
