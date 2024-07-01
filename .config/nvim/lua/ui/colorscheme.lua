return {
    "rebelot/kanagawa.nvim",
    config = function()
        require("kanagawa").setup({
            compile = false, -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentstyle = { italic = true },
            functionstyle = {},
            keywordstyle = { italic = true },
            statementstyle = { bold = true },
            typestyle = {},
            transparent = false, -- do not set background color
            diminactive = false, -- dim inactive window `:h hl-normalnc`
            terminalcolors = true, -- define vim.g.terminal_color_{0,17}
            colors = { -- add/modify theme and palette colors
                palette = {},
                theme = {
                    wave = {},
                    lotus = {},
                    dragon = {},
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
            overrides = function(colors) -- add/modify highlights
                local theme = colors.theme
                return {
                    telescopetitle = { fg = theme.ui.special, bold = true },
                    telescopepromptnormal = { bg = theme.ui.bg_p1 },
                    telescopepromptborder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                    telescoperesultsnormal = {
                        fg = theme.ui.fg_dim,
                        bg = theme.ui.bg_m1,
                    },
                    telescoperesultsborder = {
                        fg = theme.ui.bg_m1,
                        bg = theme.ui.bg_m1,
                    },
                    telescopepreviewnormal = { bg = theme.ui.bg_dim },
                    telescopepreviewborder = {
                        bg = theme.ui.bg_dim,
                        fg = theme.ui.bg_dim,
                    },
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                }
            end,
            theme = "wave", -- load "wave" theme when 'background' option is not set
            background = { -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus",
            },
        })
        vim.cmd([[colorscheme kanagawa]])
    end,
    priority = 1000,
}
