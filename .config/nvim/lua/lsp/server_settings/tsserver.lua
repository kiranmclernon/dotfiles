local web_ft = function (event)
    vim.schedule(function ()
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.expandtab = true
        vim.bo.softtabstop = 2
    end)
end

local web_cmds = vim.api.nvim_create_augroup("web_cmds", { clear = true })

return function()
    vim.notify("[web_ft] setting up web indentation settings", vim.log.levels.INFO)
    vim.api.nvim_create_autocmd("FileType", {
        group = web_cmds,
        pattern = { "typescriptreact", "javascriptreact","typescript", "javascript" },
        desc = "Setup web indenting",
        callback = web_ft,
    })
end
