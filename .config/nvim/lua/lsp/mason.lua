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
    "tsserver",
}

local mason_settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
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
        "jay-babu/mason-nvim-dap.nvim",
        require("lsp.lang_plugs"),
    },
    lazy = false,
    priority = 100,
    config = function()
        require("mason").setup(mason_settings)
        require("mason-lspconfig").setup({
            ensure_installed = servers,
            automatic_installation = true,
        })
        require("lsp.setup").setup()
        require("mason-nvim-dap").setup({
            ensure_installed = { "python" },
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "google-java-format"
            }
        })

        local lsp_config = require("lspconfig")
        local handlers = {
            function(server_name)
                lsp_config[server_name].setup(require("lsp.server_settings.default"))
            end,
            ["lua_ls"] = function()
                lsp_config.lua_ls.setup(get_server_settings("lua_ls"))
            end,
            ["jdtls"] = function()
                get_server_settings("nvim-jdtls")()
            end,
        }
        require("mason-lspconfig").setup_handlers(handlers)

        lsp_config.sourcekit.setup(require("lsp.server_settings.swift"))
    end,
}
