return {
  'OXY2DEV/markview.nvim',
  ft = 'markdown',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    modes = { 'n', 'no', 'c' },
    hybrid_modes = { 'n' }, -- Uses this feature on
    callbacks = {
      on_enable = function(_, win)
        vim.wo[win].conceallevel = 2
        vim.wo[win].conecalcursor = 'c'
      end,
    },
  },
}
