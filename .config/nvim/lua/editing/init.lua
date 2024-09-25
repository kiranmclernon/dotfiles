local leap = require("editing.leap")
local autopairs = require("editing.autopairs")
local comment = require("editing.comment")
local cmp = require("editing.cmp")
local pencil = require("editing.pencil")
local vimtex = require("editing.vimtex")
local md_preview = require("editing.md_preview")
local formatting = require("editing.formatting")
local neorg = require("editing.neorg")
return {
    leap,
    autopairs,
    comment,
    cmp,
    pencil,
    vimtex,
    md_preview,
    formatting,
    neorg
}
