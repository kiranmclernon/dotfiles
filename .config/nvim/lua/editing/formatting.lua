return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff" },
                java = { "google-java-format" }
            },
            formatters = {
                stylua = {
                    prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" }
                }
            }
        })
    end,
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
}
