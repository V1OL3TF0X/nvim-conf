return {
  'theprimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = function()
    local keys = {
      {
        '<leader>a',
        -- stylua: ignore
        function() Harpoon:list():add() end,
      },
      {
        '<leader>hh',
        function()
          MiniPick.start {
            source = {
              items = vim
                .iter(Harpoon:list().items)
                :map(function(i)
                  return i.value
                end)
                :totable(),
            },
          }
        end,
      },
    }
    local fmt = '<C-F%d>'
    if vim.uv.os_uname().sysname:upper() == 'DARWIN' then
      fmt = '<C-%d>'
    end
    for i = 1, 4 do
      local keymap = string.format(fmt, i)
      table.insert(keys, {
        keymap,
        -- stylua: ignore
        function() Harpoon:list():select(i) end,
      })
    end
    return keys
  end,
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()
    _G.Harpoon = harpoon
  end,
}
