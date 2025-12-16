return {
  'LunarVim/bigfile.nvim',
  event = 'BufReadPre',
  opts = {
    filesize = 1.5,
    features = {
      "indent_blankline",
      "illuminate",
      "lsp",
      "treesitter",
      "syntax",
      "matchparen",
      "vimopts",
      "filetype",
      {
        name = "spelunker",
        opts = {
          defer = false,
        },
        disable = function()
          if vim.b.spelunker_enable_vim == 1 or vim.b.spelunker_enable_vim == nil then
            vim.fn['spelunker#toggle_buffer']()
          end
        end,
      }
    }
  },
  config = function(_, opts)
    require 'bigfile'.setup(opts)
  end,
};
