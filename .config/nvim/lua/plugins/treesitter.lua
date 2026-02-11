return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"lua",
			"vim",
			"bash",
			"typescript",
			"python",
			"css",
			"json",
			"yaml",
		})
	end,
}
