local servers = {
    "lua_ls",
    "rust_analyzer",
    "pyright",
    "texlab",
    "jdtls",
    "clangd",
    "ltex",
    "bashls",
    "ts_ls",
    "omnisharp",
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
            automatic_enable = false,
        })
        require("lsp.setup").setup()
        require("mason-nvim-dap").setup({
            ensure_installed = { "python" },
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "google-java-format",
                "stylua",
                "prettier",
                "ruff",
            },
        })

        local lsp_config = require("lspconfig")

        for _, server in ipairs(servers) do
            if server == "lua_ls" then
                lsp_config.lua_ls.setup(get_server_settings("lua_ls"))
            elseif server == "jdtls" then
                get_server_settings("nvim-jdtls")()
            elseif server == "ts_ls" then
                get_server_settings("tsserver")()
                lsp_config.ts_ls.setup(require("lsp.server_settings.default"))
            else
                lsp_config[server].setup(require("lsp.server_settings.default"))
            end
        end
    end,
}
