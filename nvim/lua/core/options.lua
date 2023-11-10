local options = {
    mouse = "a",  -- Allow mouse use
    background = "dark", -- work regardless of terminal colours
    timeoutlen = 500,-- time for mapped sequence to complete
    updatetime = 200, -- Faster completion (not actually sure about this)
    number = true, -- line numbers
    relativenumber = false, -- no relativenumber
    numberwidth = 5, -- Number line width
    signcolumn = "yes:2", -- the debug column is there and its 2 wide
    cursorline = true, -- the cursor line is highlighted
    smartindent = true, -- use cstyle indenting
    autoindent = true,
    wrap = true, -- wrap
    linebreak = true, -- make wrapping nicer
    expandtab = true, -- expand tabs
    tabstop = 4, -- number of spaces inserted for tabs
    shiftwidth = 4, -- number of spaces used for indentation
    list = true, -- show things in whitespace characters
    listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂", -- characters to show for whitespace characters
    clipboard = "unnamedplus", -- vim clipboard plays nicely with os clipboard
    ignorecase = true, -- ignore case in search patterns
    smartcase = true, -- take case into account if search has an uppercase
    backup = false, -- nobackup file
    writebackup = false , -- stop file being edited if being edited by another program
    undofile = true, -- there is an undo file saved for when i come back
    swapfile = false, -- idrk why
    splitright = true, -- forcing proper splits
    splitbelow = true, -- forcing propersplits
    scrolloff = 8, -- minimum number of lines to keep above and below the cursor
    encoding = 'utf-8',
}
for k, v in pairs(options) do
    vim.opt[k] = v
end
vim.cmd "set whichwrap+=<,>,[,],h,l" -- easier navigation
vim.cmd [[set iskeyword+=-]] -- Fix word recognition
