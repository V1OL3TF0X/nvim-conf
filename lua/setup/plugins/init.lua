return {
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl' },
  { 'tpope/vim-abolish', lazy = false },
  {
    'mattn/emmet-vim',
    ft = { 'html', 'typescriptreact', 'djangohtml', 'javascriptreact', 'php', 'astro' },
  },
  { 'windwp/nvim-ts-autotag', lazy = false },
  { 'tpope/vim-repeat', lazy = false },
  {
    'kamykn/spelunker.vim',
    lazy = false,
    dependencies = { 'kamykn/popup-menu.nvim' },
  },
  {
    'davidmh/mdx.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
