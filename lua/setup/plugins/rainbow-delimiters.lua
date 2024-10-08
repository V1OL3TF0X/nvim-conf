return {
    'HiPhish/rainbow-delimiters.nvim',
    dependencies = { "lukas-reineke/indent-blankline.nvim" },
    lazy = false,
    config = function()
        -- This module contains a number of default definitions
        local rainbow_delimiters = require 'rainbow-delimiters'

        local highlight = {
            'RainbowYellow',
            'RainbowOrange',
            'RainbowGreen',
            'RainbowViolet',
            'RainbowCyan',
        }
        local hooks = require 'ibl.hooks'
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
            vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
            vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
            vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
            vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
        end)

        require 'ibl'.setup { scope = { highlight = highlight, char = "▏" } }

        require 'rainbow-delimiters.setup'.setup {
            strategy = {
                [''] = rainbow_delimiters.strategy['global'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
                tsx = 'rainbow-delimiters-brackets-only',
                vue = 'rainbow-delimiters-brackets-only',
                javascript = 'rainbow-delimiters-brackets-only',
                html = 'rainbow-brackets-only',
                gotmpl = 'rainbow-brackets-only',
                astro = 'rainbow-brackets-only',
            },
            priority = {
                [''] = 110,
                lua = 210,
            },
            highlight = highlight,
        }
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
};
