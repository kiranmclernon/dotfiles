local ls = require("luasnip")
local  s= ls.snippet
local  f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local fmta = require("luasnip.extras.fmt").fmta
local l = extras.lambda
local rep = extras.rep

local function math()
    return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end 


ls.add_snippets(nil, {
    all = {
        s("beg", fmt([[
            \begin{<>}
            <>
            \end{<>}]],
            {i(1), i(0), rep(1)}, -- repeat node 1
            {delimiters='<>'}
        )),

        s({ trig='it', name='itemize', dscr='dscr'},
        fmt([[
        \begin{itemize}
            \item <>
        \end{itemize}
        ]],
        { i(1) },
        { delimiters='<>' }
        )),

        s({ trig='se', name='iset', dscr='dscr'},
        fmt([[\{ <> \}]],
        { i(0)},
        { delimiters='<>' }),
        {condition = math}),
        s(
            {trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType="autosnippet"},
            fmta(
                "<>_{<>}",
                {
                    f( function(_, snip) return snip.captures[1] end ),
                    t("0")
                }
            )
        ),
        s(
            { trig='([%a])_(%d%d)', regTrig = true, wordTrig = false, snippetType = "autosnippet"},
            fmta(
                "<>_{<>}",
                {
                    f( function (_, snip) return snip.captures[1] end),
                    f( function (_, snip) return snip.captures[2] end)
                }
            )
        ),
        s(
            { trig='([%a])(%d)', regTrig = true, wordTrig = false, snippetType = "autosnippet"},
            fmta(
                "<>_{<>}",
                {
                    f( function (_, snip) return snip.captures[1] end),
                    f( function (_, snip) return snip.captures[2] end)
                }
            )
        ),
    }
})

