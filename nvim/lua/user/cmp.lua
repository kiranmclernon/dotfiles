local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    print("luasnip fucked")
    return
end

require("luasnip/loaders/from_vscode").lazy_load() -- I have no clue what this is

local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}


cmp.setup({
    -- Snippet engine
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- navigating completion options
        ["<Tab>"] = cmp.mapping.select_next_item(), -- navigating completion options
        ["<S-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }), -- navigate docs
        ["<S-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }), -- navigate docs
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- force pull up completions
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ["<CR>"] = cmp.mapping.confirm { select = true },
    },

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          --vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            nvim_lua = "[NVIM_LUA]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        {name = "nvim_lua"},
        { name = "buffer" },
        { name = "path" },
    },
    window = {
        documentation = cmp.config.window.bordered(),
    },
    ghost_text = true,


})
