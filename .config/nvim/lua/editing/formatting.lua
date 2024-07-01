return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff" },
            },
        })
    end,
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
}
