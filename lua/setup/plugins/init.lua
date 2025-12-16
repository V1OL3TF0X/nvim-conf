return {
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl' },
  { 'tpope/vim-abolish',                   lazy = false },
  { 'mattn/emmet-vim',                     ft = { "html", "typescriptreact", "djangohtml", "javascriptreact", "php", "astro" } },
  { 'windwp/nvim-ts-autotag',              lazy = false },
  {
    '27justin/virtuality.nvim',
    lazy = false,
    dependencies = { 'rcarriga/nvim-notify' }
  },
  {
    'kamykn/spelunker.vim',
    dependencies = { 'kamykn/popup-menu.nvim' },
    lazy = false
  },
  {
    'dmmulroy/tsc.nvim',
    dependencies = { "rcarriga/nvim-notify" },
    lazy = false,
    opts = function()
      vim.keymap.set('n', '<leader>tc', ':TSC');
      return { run_as_monorepo = true };
    end
  },
  {
    "yochem/jq-playground.nvim",
    opts = function(_, opts)
      vim.keymap.set('n', '<leader>jq', vim.cmd.JqPlayground);
      vim.keymap.set('i', '<C-E>', "<Plug>(JqPlaygroundRunQuery)")
      return {
        query_window = {
          height = 0.2,
        },
      };
    end,
    lazy = false
  },
};
