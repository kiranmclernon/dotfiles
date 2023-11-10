return {
    "https://github.com/lervag/vimtex",
    config = function ()
        vim.g.vimtex_view_method = 'skim'
        vim.g.vimtex_view_skim_sync = 1
        vim.g.vimtex_view_skim_activate = 1
        local vimtex_cmds = vim.api.nvim_create_augroup("vimtex_cmds", {clear = true})
        vim.api.nvim_create_autocmd("FileType", {
            group = vimtex_cmds,
            pattern = {"tex"},
            desc = "Disable tree sitter",
            callback = function ()
                vim.cmd("TSBufDisable highlight")
                vim.g.vimtex_compiler_method = 'latexmk'
                vim.opt.conceallevel = 2
                vim.g.tex_conceal = "abdmg"
                vim.g.vimtex_compiler_latexmk = {
                    build_dir = 'build',
                    callback = 1,
                    continuous = 1,
                    executable = 'latexmk',
                    hooks = {},
                    options = {
                        '-verbose',
                        '--shell-escape',
                        '-file-line-error',
                        '-synctex=1',
                        '-interaction=nonstopmode',
                    },
                }
            end
        })
        end
}
