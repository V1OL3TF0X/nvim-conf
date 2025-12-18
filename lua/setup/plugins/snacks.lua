return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@class snacks.Config
  opts = {
    bigfile = {
      enabled = true,
      config = function(opts, defaults)
        opts.setup = function(ctx)
          if vim.b.spelunker_enable_vim == 1 or vim.b.spelunker_enable_vim == nil then
            vim.fn['spelunker#toggle_buffer']()
          end
          defaults.setup(ctx)
        end
      end
    },
    dashboards = { enabled = true },
    lazygit = { enabled = true },
    gitbrowse = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
  },
}
