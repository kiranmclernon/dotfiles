local servers = {
    "lua_ls",
    "rust_analyzer",
    "jedi_language_server",
    "cmake",
    "texlab",
    "jdtls",
    "clangd",
    "ltex",
    "bashls",
    "pylsp"
}

local mason_settings = {
    ui = {
    border = "none",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

local get_server_settings = function(server_name)
    return require("lsp.server_settings." .. server_name)
end

return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        require("lsp.lang_plugs")
    },
    config = function()
        require("mason").setup(mason_settings)
        require("mason-lspconfig").setup({
            ensure_installed = servers,
            automatic_installation = true,
        })
    require("lsp.setup").setup()
    local lsp_config = require "lspconfig"
    local handlers = {
        function(server_name)
            lsp_config[server_name].setup(
                    require("lsp.server_settings.default")
                )
        end,
        ["lua_ls"] = function()
            lsp_config.lua_ls.setup(get_server_settings("lua_ls"))
        end,
        ["pylsp"] = function()
                lsp_config.pylsp.setup(get_server_settings("pylsp"))
        end,
        ["jdtls"] = function()
                get_server_settings("nvim-jdtls")()
        end,
        ["jedi_language_server"] = function()
        end
    }

    require('mason-lspconfig').setup_handlers(handlers)
    end
}
