vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to Definition" })
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>t", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>w", "<cmd>lua require('nvim-window').pick()<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>")
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
