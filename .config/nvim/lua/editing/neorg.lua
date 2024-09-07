return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    run = "Neorg sync-parsers",
    opts = {
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        uni = "~/Documents/uni_stuff",
                    },
                    default_workspace = "uni",
                },
            },
            ["core.integrations.telescope"] = {},
        },
    },
    init = function()
        local neorg_cmd = vim.api.nvim_create_augroup("neorg_cmds", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            group = neorg_cmd,
            pattern = { "norg" },
            callback = function()
                local opts = { noremap = true, silent = true }
                vim.g.maplocalleader = ","
                vim.o.conceallevel = 3
                vim.keymap.set(
                    "n",
                    "<localleader>il",
                    "<cmd>Telescope neorg insert_file_link<cr>",
                    opts
                )
                vim.keymap.set(
                    "n",
                    "<localleader>ls",
                    "<cmd>Telescope neorg find_norg_files<cr>",
                    opts
                )
            end,
        })
    end,
    dependencies = { "nvim-neorg/neorg-telescope" },
}
