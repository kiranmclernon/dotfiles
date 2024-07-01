return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        "nvim-lua/plenary.nvim",
    },
}
