-- noremap is no recurse map
-- https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping
-- Silent so that we do not see an output
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = " "

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<S-Down>", ":resize -2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)


keymap("n", "<leader>w", function()
    require("nvim-window").pick()
end, opts)
keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)
keymap("n", "<leader>l", "<C-l>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- https://vim.fandom.com/wiki/Moving_lines_up_or_down
keymap("v", "<A-k>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-j>", ":m '<-2<CR>gv=gv", opts)

keymap(
    "n",
    "<leader>f",
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
    opts
)


keymap(
    "n",
    "<S-f>",
    "<cmd>lua require('conform').format()<cr>",
    opts
)

keymap("n", "<leader>t", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>a", "<cmd>AerialToggle!<CR>", opts)

-- keymap("n", "<leader>e", ":SidebarNvimOpen<cr>", opts)
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)
keymap("n", "<leader>a", "<cmd>AerialToggle!<CR>", opts)
