return {
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl' },
  { 'tpope/vim-abolish',                   lazy = false },
  { 'mattn/emmet-vim',                     ft = { "html", "typescriptreact", "djangohtml", "javascriptreact", "php", "astro" } },
  { 'windwp/nvim-ts-autotag',              lazy = false },
  {
    'kamykn/spelunker.vim',
    dependencies = { 'kamykn/popup-menu.nvim' },
    lazy = false
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    {
      "antosha417/nvim-lsp-file-operations",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
      },
      config = function()
        require("lsp-file-operations").setup()
      end,
    },
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
