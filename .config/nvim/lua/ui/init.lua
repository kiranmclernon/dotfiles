local colorscheme = require "ui.colorscheme"
local nvim_tree = require "ui.nvim_tree"
local treesitter = require "ui.treesitter"
local nvim_window = require "ui.nvim_window"
local gitsigns = require "ui.gitsigns"
local nvim_navic = require "ui.navic"
local lualine = require "ui.lualine"
local telescope = require "ui.telescope"
local devicons = require "ui.devicons"
local toggleterm = require "ui.toggleterm"
local alpha = require "ui.alpha"
local aerial = require "ui.aerial"
local zen = require "ui.zen"
return {
    devicons,
    colorscheme,
    nvim_tree,
    treesitter,
    nvim_window,
    gitsigns,
    nvim_navic,
    lualine,
    telescope,
    toggleterm,
    alpha,
    aerial,
    zen
}
