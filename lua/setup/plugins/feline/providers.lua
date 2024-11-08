-- ~/.config/nvim/lua/plugins/feline/file_name.lua

local M = {}

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

return M
