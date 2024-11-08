return {
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl' },
  { 'tpope/vim-abolish',                   lazy = false },
  { 'mattn/emmet-vim',                     ft = { "html", "typescriptreact", "djangohtml", "javascriptreact", "php", "astro" } },
  { 'windwp/nvim-ts-autotag',              lazy = false },
  {
    "yochem/jq-playground.nvim",
    config = function()
      require 'jq-playground'.setup {
        query_window = {
          height = 0.2,
        },
        query_keymaps = {
          { "i", "<C-E>" },
        },
      };
      vim.keymap.set('n', '<leader>jq', vim.cmd.JqPlayground);
    end,
    lazy = false
  },
};
