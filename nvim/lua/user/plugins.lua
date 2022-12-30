-- This is copied from the packer readme
-- Bootstrapping packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim' -- get place packer should be
  if fn.empty(fn.glob(install_path)) > 0 then -- if its not there
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]] -- Source packer.nvim if its in opt directory
    return true
  end
  return false
end
-- This copied from that video 
-- Load packer and config for floating window


local packer_bootstrap = ensure_packer()

-- I cant be bothered learning about autocmd so i copy and pasted this
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]


local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end


return packer.startup({
    function(use)
        use "wbthomason/packer.nvim" -- Have packer manage itself
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }
        use "windwp/nvim-autopairs"
        use "https://gitlab.com/yorickpeterse/nvim-window"
        -- Colorscheme
        use 'sam4llis/nvim-tundra'
        use "ggandor/leap.nvim"
        use "lewis6991/impatient.nvim"
        use "nvim-tree/nvim-web-devicons"
        use {
            'goolord/alpha-nvim',
            requires = { 'nvim-tree/nvim-web-devicons' },
            config = function ()
                require'alpha'.setup(require'alpha.themes.startify'.config)
            end
        }
        use 'Civitasv/cmake-tools.nvim'
        use "numToStr/Comment.nvim"
        use "lewis6991/gitsigns.nvim"
        use "nvim-tree/nvim-tree.lua"
        use "akinsho/toggleterm.nvim"
        -- Completion and cmp sources
        use "hrsh7th/nvim-cmp" -- The completion plugin
        use "hrsh7th/cmp-buffer" -- buffer completions
        use "hrsh7th/cmp-path" -- path completions
        use "hrsh7th/cmp-cmdline" -- cmdline completions
        use "saadparwaiz1/cmp_luasnip" -- snippet completions
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-nvim-lsp"

        -- Snippet stuff
        use "L3MON4D3/LuaSnip" --snippet engine
        use "rafamadriz/friendly-snippets" -- a bunch of snippets to use


        use "neovim/nvim-lspconfig" -- enable LSP
        use "williamboman/mason.nvim" -- simple to use language server installer
        use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer


        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.0',
            requires = { {'nvim-lua/plenary.nvim'} }
        }
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }

        -- Rust stuff
        use "simrat39/rust-tools.nvim"
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
            return require('packer.util').float({ border = 'single' })
            end
        }
    }
})


