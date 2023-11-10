return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup {
            ensure_installed = {"rust", "lua", "c", "cpp", "cmake", "vim", "java", "python", "bash", "make"},
            sync_install = false, 
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = {}, -- list of language that will be disabled
                additional_vim_regex_highlighting = true,
          },
          indent = { enable = true, disable = { "yaml" } },
        }
    end
}

