return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff" },
                java = { "google-java-format" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                javascriptreact = { "prettier" },
            },
            formatters = {
                stylua = {
                    prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
                },
                prettier = {
                    prepend_args = {
                        "--tab-width",
                        "2",
                        "--use-tabs",
                        "false",
                    },
                },
            },
        })
    end,
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
}
