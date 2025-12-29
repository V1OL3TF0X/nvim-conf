return {
  'yochem/jq-playground.nvim',
  opts = function()
    vim.keymap.set('n', '<leader>jq', vim.cmd.JqPlayground)
    vim.keymap.set('i', '<C-E>', '<Plug>(JqPlaygroundRunQuery)')
    return {
      query_window = {
        height = 0.2,
      },
    }
  end,
  lazy = false,
}
