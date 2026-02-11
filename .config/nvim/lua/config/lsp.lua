vim.lsp.enable("lua_ls")
vim.lsp.enable("basedpyright")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup", "noselect" }
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			vim.keymap.set("i", "<C-Space>", function()
				vim.lsp.completion.get()
			end)

			vim.keymap.set("i", "<Tab>", function()
				if vim.fn.pumvisible() == 1 then
					return "<C-n>"
				else
					return "<Tab>"
				end
			end, { buffer = ev.buf, expr = true })

			vim.keymap.set("i", "<S-Tab>", function()
				if vim.fn.pumvisible() == 1 then
					return "<C-p>"
				else
					return "<S-Tab>"
				end
			end, { buffer = ev.buf, expr = true })

			vim.keymap.set("i", "<CR>", function()
				if vim.fn.pumvisible() == 1 then
					return "<C-y>"
				else
					return "<CR>"
				end
			end, { buffer = ev.buf, expr = true })
		end
	end,
})

vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})
