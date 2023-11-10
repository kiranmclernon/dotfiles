local mason = require "lsp.mason"
local vimtex = require "lsp.vimtex"
local linting = require "lsp.linting"
local formatting = require "lsp.formatting"

return {
    mason,
    vimtex,
    linting,
    formatting
}
