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
    "V1OL3TF0X/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      restricted_keys = {
        ["K"] = { "v" },
        ["J"] = { "v" },
      },
      hints = {
        ["%D1[JK]"] = {
          message = function(keys)
            return "Use " .. keys:sub(3, 3) .. " instead of " .. keys:sub(2, 3)
          end,
          length = 3,
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
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
