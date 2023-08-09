local leap = require "editing.leap"
local autopairs = require "editing.autopairs"
local comment = require "editing.comment"
local indentline = require "editing.indentline"
local cmp = require "editing.cmp"
return {
    leap,
    autopairs,
    comment,
    indentline,
    cmp
}
