--- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local editing = require "editing"
local ui = require "ui"
local utils = require "utils"
local lsp = require "lsp"
local neorg = require "core.neorg"
require("lazy").setup {
    utils,
    editing,
    ui,
    lsp,
    neorg
}
