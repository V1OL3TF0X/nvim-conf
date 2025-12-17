return {
  'nvim-telescope/telescope.nvim',
  -- or                            , branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local lga_parser = require 'telescope-live-grep-args.prompt_parser'
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
      vim.ui.input({ prompt = "Grep > " }, function(prompt)
        if prompt == nil then
          return;
        end
        local aa = lga_parser.parse(prompt)
        if aa == nil then
          return;
        end
        local s = table.remove(aa, 1)
        builtin.grep_string({ search = s, additional_args = aa })
      end)
    end)
    vim.keymap.set('n', '<leader>pS', function()
      telescope.extensions.live_grep_args.live_grep_args()
    end)
    telescope.load_extension("live_grep_args")
    telescope.load_extension("fzf")
    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<D-q>'] = actions.send_selected_to_qflist + actions.open_qflist
          }
        },
      }
    }
  end,
};
