local colorscheme = require("ui.colorscheme")
local nvim_tree = require("ui.nvim_tree")
local treesitter = require("ui.treesitter")
local nvim_window = require("ui.nvim_window")
local gitsigns = require("ui.gitsigns")
local lualine = require("ui.lualine")
local telescope = require("ui.telescope")
local devicons = require("ui.devicons")
local aerial = require("ui.aerial")
return {
    devicons,
    colorscheme,
    nvim_tree,
    treesitter,
    nvim_window,
    gitsigns,
    lualine,
    telescope,
    aerial,
}
