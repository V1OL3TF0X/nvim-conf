-- credit: https://github.com/ngpong
local M = {}

function M.displaywidth(str)
  return vim.api.nvim_strwidth(str)
end

return M
