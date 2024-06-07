return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        },
        "nvim-lua/plenary.nvim",
    },
    -- config = function()
    --     local telescope_status_ok, telescope = pcall(require, "telescope")
    --     if not telescope_status_ok then
    --         return
    --     end
    --     telescope.load_extension('fzf')
    -- end
}
