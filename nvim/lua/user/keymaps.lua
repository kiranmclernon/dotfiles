-- noremap is no recurse map 
-- https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping
-- Silent so that we do not see an output
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap


vim.g.mapleader = " "

-- Save
keymap("n", "<S-p><S-p>", "w<CR>", opts)
keymap("i", "<S-p><S-p>", "<ESC>:w<CR>", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<S-Down>", ":resize -2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- https://vim.fandom.com/wiki/Moving_lines_up_or_down
keymap("v", "<A-k>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-j>", ":m '<-2<CR>gv=gv", opts)

keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>t", "<cmd>Telescope live_grep<cr>", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

keymap("n", "<leader>m", ":ToggleTerm<CR>", opts)

-- Window navigation 
keymap("n", "<S-j>", "<c-w>j", opts)
keymap("n", "<S-h>", "<c-w>h", opts)
keymap("n", "<S-l>", "<c-w>l", opts)
keymap("n", "<S-k>", "<c-w>k", opts)


