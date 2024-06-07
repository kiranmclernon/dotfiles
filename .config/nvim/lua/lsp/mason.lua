local servers = {
    "lua_ls",
    "rust_analyzer",
    "basedpyright",
    "cmake",
    "texlab",
    "jdtls",
    "clangd",
    "ltex",
    "bashls",
    "arduino_language_server",
    "tsserver"
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
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        require("lsp.lang_plugs")
    },
    config = function()
        require("mason").setup(mason_settings)
        require("mason-lspconfig").setup({
            ensure_installed = servers,
            automatic_installation = true,
        })
        require("mason-tool-installer").setup({
            ensure_installed = {
                "pylint",
                "google-java-format",
                "stylua"
            }
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
        ["jdtls"] = function()
                get_server_settings("nvim-jdtls")()
        end,
    }

    require('mason-lspconfig').setup_handlers(handlers)
    end
}
