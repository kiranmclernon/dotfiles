local setup = function()
    vim.cmd("call pencil#init({'wrap': 'soft'})")
end

return {
    "preservim/vim-pencil",
    config = function()
        local pencil_cmds = vim.api.nvim_create_augroup("penciL_cmds", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            group = pencil_cmds,
            pattern = { "tex" },
            desc = "setup vim-pencil",
            callback = setup,
        })
    end,
}
