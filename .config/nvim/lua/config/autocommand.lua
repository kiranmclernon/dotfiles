local web_filetypes = {
	"html",
	"css",
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact", -- for .jsx and .tsx
	"json",
	"yaml",
	"xml",
	"svelte",
	"vue",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = web_filetypes,
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
	end,
})
