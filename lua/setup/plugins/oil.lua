local detail = false
return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  opts = function()
    vim.keymap.set('n', '<leader>pv', '<cmd>vert Oil<CR>')
    vim.keymap.set('n', '<leader>e', ':Oil<CR>')
    ---@type oil.SetupOpts
    return {
      columns = {
        'icon',
      },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['<C-p>'] = false,
        ['<leader>x'] = function()
          local cursor = vim.api.nvim_win_get_cursor(0)
          local lnum = cursor[1]
          local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1]
          line = line:gsub(' ([r%-][w%-]).([r%-][w%-]).([r%-][w%-]). ', function(u, g, p)
            return ' ' .. u .. 'x' .. g .. 'x' .. p .. 'x '
          end)
          vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, true, { line })
        end,
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
      },
    }
  end,
  -- Optional dependencies
  dependencies = { 'nvim-mini/mini.nvim' },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
