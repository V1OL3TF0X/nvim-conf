return {
  'theprimeagen/harpoon',
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<leader>a', mark.add_file)
    vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
    local fmt = '<C-F%d>'
    if vim.uv.os_uname().sysname:upper() == 'DARWIN' then
      fmt = '<C-%d>'
    end
    for i = 1, 4, 1 do
      local keymap = string.format(fmt, i)
      vim.keymap.set('n', keymap, function()
        ui.nav_file(i)
      end)
    end
  end,
}
