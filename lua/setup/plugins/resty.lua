return {
  "lima1909/resty.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  ft = "resty",
  keys = {
    { '<leader>xh', '<cmd>Resty run<CR>',      mode = { 'n', 'v' } },
    { '<leader>xf', '<cmd>Resty favorite<CR>', mode = { 'n', 'v' } },
  }
}
