-- ~/.config/nvim/lua/plugins/feline/file_name.lua

local M = {}

M.icons = {
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
}

function M.readonly(component)
  if vim.bo.readonly then
    return component.icon or ''
  end
  return ''
end

function M.modified(component)
  if vim.bo.modified then
    return component.icon or '●'
  end
  return ''
end

function M.file_osinfo()
  local os = vim.uv.os_uname().sysname:upper()
  local icon
  if os == 'LINUX' then
    icon = M.icons.unix
  elseif os == 'DARWIN' then
    icon = M.icons.mac
  elseif os == 'WINDOWS_NT' then
    icon = M.icons.dos
  end
  return string.format('%s %s', icon, os)
end

return M
