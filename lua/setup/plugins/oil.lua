return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  opts = function()
    vim.keymap.set('n', '<leader>pv', '<cmd>vert Oil<CR>')
    ---@type oil.SetupOpts
    return {
      keymaps = {
        ['<C-p>'] = false,
      },
    }
  end,
  -- Optional dependencies
  dependencies = { 'nvim-mini/mini.nvim' },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
