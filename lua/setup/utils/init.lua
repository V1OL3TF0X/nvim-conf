-- credit: https://github.com/ngpong
local icon_hl_cache = {}
do
  vim.__lazy = require 'setup.utils.lazy'
  vim.__class = vim.__lazy.require 'setup.utils.oop'
  vim.__bouncer = vim.__lazy.require 'setup.utils.debounce'
  vim.__str = vim.__lazy.require 'setup.utils.str'
  vim.__path = vim.__lazy.require 'setup.utils.path'
  vim.__cache = vim.__lazy.require 'setup.utils.lrucache'
  vim.__autocmd = require 'setup.utils.autocmd'
  vim.__filter = vim.__lazy.require 'setup.utils.filter'
  vim.__buf = vim.__lazy.require 'setup.utils.buf'
  vim.__win = vim.__lazy.require 'setup.utils.win'
  vim.__cursor = vim.__lazy.require 'setup.utils.cursor'
  vim.__icons = {
    lsp = '',
    locker = '', -- #f023
    page = '☰', -- 2630
    line_number = '', -- e0a1
    connected = '', -- f817
    dos = '', -- e70f
    unix = '', -- f17c
    mac = '', -- f179
    vertical_bar = '┃',
    vertical_bar_thin = '│',
    left = '',
    right = '',
    block = '█',
    left_filled = '',
    right_filled = '',
    slant_left = '',
    slant_left_thin = '',
    slant_right = '',
    slant_right_thin = '',
    slant_left_2 = '',
    slant_left_2_thin = '',
    slant_right_2 = '',
    slant_right_2_thin = '',
    left_rounded = '',
    left_rounded_thin = '',
    right_rounded = '',
    right_rounded_thin = '',
    circle = '●',
    branch = '',
    symbols = {
      error = '',
      warn = '',
      info = '',
      hint = '󰌵',
    },
    symbols_outlined = {
      error = '󰅚',
      warn = '󰀪',
      info = '󰋽',
      hint = '󰌶',
    },
  }
  function vim.__icons.get_icon_cache(name)
    return icon_hl_cache[name]
  end
  function vim.__icons.insert_icon_cache(name)
    icon_hl_cache[name] = true
  end
  function vim.__icons.combine_hl(fg_hl, bg_hl, suffix)
    local new_hl = fg_hl .. suffix
    if icon_hl_cache[new_hl] then
      return new_hl
    end
    local bg = vim.api.nvim_get_hl(0, { name = bg_hl }).bg
    vim.api.nvim_set_hl(0, new_hl, { fg = vim.api.nvim_get_hl(0, { name = fg_hl }).fg, bg = bg })
    icon_hl_cache[new_hl] = { fg_hl, bg_hl }
    return new_hl
  end
  vim.__autocmd.on('ColorScheme', function()
    for hl_name, hls in pairs(icon_hl_cache) do
      local bg = vim.api.nvim_get_hl(0, { name = hls[2] }).bg
      vim.api.nvim_set_hl(0, hl_name, { fg = vim.api.nvim_get_hl(0, { name = hls[1] }).fg, bg = bg })
    end
  end)
end
