return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  opts = function()
    vim.keymap.set('n', '<leader>Vex', '<cmd>vert Oil<CR>')
    vim.keymap.set('n', '<leader>pv', '<cmd>Oil<CR>')
    ---@type oil.SetupOpts
    return {
      keymaps = {
        ['<C-p>'] = false,
      },
    }
  end,
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
