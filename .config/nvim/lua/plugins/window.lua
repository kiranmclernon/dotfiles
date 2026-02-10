return {
  {
    "yorickpeterse/nvim-window",
    url = "https://gitlab.com/yorickpeterse/nvim-window.git",
    lazy = false,
    config = function()
      require("nvim-window").setup({
        hint = {
          show = true,
          delay = 200,
          highlight = "Search",
        },
      })
    end,
  },
}

