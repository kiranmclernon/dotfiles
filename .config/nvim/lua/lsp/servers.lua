local M = {}
M.servers = {
    "lua_ls",
    "rust_analyzer",
    "basedpyright",
    "cmake",
    "texlab",
    "jdtls",
    "clangd",
    "ltex",
    "bashls"
}

local exclude = {
    ["jdtls"] = true
}

M.setup = {}

for _, server in ipairs(M.servers) do
    if not exclude[server] then
        table.insert(M.setup, server)
    end
end


return M
