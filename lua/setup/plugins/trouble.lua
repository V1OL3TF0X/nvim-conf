return {
  'folke/trouble.nvim',
  opts = {},
  keys = function(trouble)
    return {
      -- stylua: ignore start
      { '<leader>tt', vim.cmd.Trouble },
      { '<leader>tn', function() trouble.next { skip_groups = true, jump = true } end, },
      { '<leader>tp', function() trouble.prev { skip_groups = true, jump = true } end, },
      -- stylua: ignore end
    }
  end,
}
