vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require 'nvim-web-devicons'.setup {
                color_icons = true,
                override = {
                    askama = {
                        icon = "",
                        color = "#CE412B",
                        name = "Askama"
                    }
                }
            }
        end,
    }
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use 'nvim-treesitter/playground'
    use 'navarasu/onedark.nvim'
    use 'theprimeagen/harpoon'
    use 'mbbill/undotree'
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }
    use 'HiPhish/rainbow-delimiters.nvim'
    use 'nikvdp/neomux'
    use 'windwp/nvim-ts-autotag'
    use 'mattn/emmet-vim'
    use 'stevearc/conform.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
end)
