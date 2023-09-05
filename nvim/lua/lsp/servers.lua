local M = {}
M.servers = {
    "lua_ls",
    "rust_analyzer",
    "jedi_language_server",
    "cmake",
    "texlab",
    "jdtls",
    "clangd",
    "ltex",
    "bashls"
}

local exclude = {
    "jdtls"
}

M.setup = {}

for _, server in ipairs(M.servers) do
    if exclude[server] then
        table.insert(M.setup, server)
    end
end

return M
