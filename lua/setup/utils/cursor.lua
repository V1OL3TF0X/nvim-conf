-- credit: https://github.com/ngpong
local M = {}

function M.norm_get(winid)
  return vim.api.nvim_win_get_cursor(winid or 0)
end

return M
