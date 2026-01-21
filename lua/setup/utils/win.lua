-- credit: https://github.com/ngpong
local M = {}

function M.is_valid(winid)
  return vim.api.nvim_win_is_valid(winid)
end

function M.is_float(winid)
  if winid then
    return vim.api.nvim_win_get_config(winid).relative ~= ''
  else
    return false
  end
end

function M.current()
  return vim.api.nvim_get_current_win()
end

function M.all()
  return vim.api.nvim_list_wins()
end

function M.bufnr(winid)
  winid = winid or M.current()

  local success, ret = pcall(vim.api.nvim_win_get_buf, winid)
  if success then
    return ret
  else
    return -1
  end
end

return M
