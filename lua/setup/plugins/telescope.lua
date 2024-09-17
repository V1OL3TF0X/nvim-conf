return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    -- or                            , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim',
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            -- This will not install any breaking changes.
            -- For major updates, this must be adjusted manually.
            version = "^1.0.0",
        },
    },
    config = function()
        local telescope = require 'telescope'
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            telescope.extensions.live_grep_args.live_grep_args()
        end)
        telescope.load_extension("live_grep_args")
    end,
};
