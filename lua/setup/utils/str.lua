-- credit: https://github.com/ngpong
local M = {}

function M.displaywidth(str)
  return vim.api.nvim_strwidth(str)
end
function M.capitalize(str)
  return str:sub(1, 1):upper() .. str:sub(2):lower()
end

return M
