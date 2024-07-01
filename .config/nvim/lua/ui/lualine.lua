return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "SmiteshP/nvim-navic",
    },
    config = function()
        local lualine_status_ok, lualine = pcall(require, "lualine")
        if not lualine_status_ok then
            return
        end

        local navic_status_ok, navic = pcall(require, "nvim-navic")
        if not navic_status_ok then
            return
        end
        lualine.setup({
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics", "filename" },
                lualine_c = {
                    "filename",
                    { navic.get_location, cond = navic.is_available },
                },
                lualine_d = { navic.get_location, navic.is_available },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },

            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}
