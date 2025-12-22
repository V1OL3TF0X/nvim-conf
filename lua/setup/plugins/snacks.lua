return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@class snacks.Config
  opts = function()
    vim.keymap.set("n", "<leader>gb", function() require 'snacks'.git.blame_line() end)
    vim.keymap.set("n", "<leader>gg", function() require 'snacks'.lazygit.open() end)
    return {
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
      git = { enabled = true },
      lazygit = {
        enabled = true,
        win = { width = 0.9, height = 0.9 },
      },
      gitbrowse = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = { enabled = true },
    }
  end,
}
