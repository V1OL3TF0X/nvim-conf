return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@class snacks.Config
  opts = function()
    -- stylua: ignore start
    vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end)
    vim.keymap.set('n', '<leader>lg', function() Snacks.lazygit.open() end)
    vim.keymap.set('n', '<leader>lt', function ()
      Snacks.terminal(nil, { win = { position = "float" }} )
    end)
    -- stylua: ignore end
    vim.keymap.set('n', '<leader>ld', function()
      Snacks.terminal('lazydocker', {
        win = {
          style = 'lazygit',
        },
      })
    end)
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
        end,
      },
      dashboards = { enabled = true },
      git = { enabled = true },
      lazygit = {
        enabled = true,
        win = { width = 0.9, height = 0.9 },
        config = {
          gui = {
            border = 'single',
          },
        },
      },
      gitbrowse = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = { enabled = true },
    }
  end,
}
