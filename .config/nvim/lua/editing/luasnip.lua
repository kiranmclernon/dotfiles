return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    build = "make install_jsregexp",
    config = function ()
        require("luasnip").config.setup { enable_autosnippets = true }
        require("editing.snippets.latex")
        require("editing.snippets.autosnip")
    end
}
