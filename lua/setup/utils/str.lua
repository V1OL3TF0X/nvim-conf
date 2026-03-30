-- credit: https://github.com/ngpong
local M = {}

function M.displaywidth(str)
  return vim.api.nvim_strwidth(str)
end
function M.capitalize(str)
  return str:sub(1, 1):upper() .. str:sub(2):lower()
end
function M.split_string(s, sep)
  local fields = {}
  local pattern = string.format('([^%s]+)', sep)
  local _ = s:gsub(pattern, function(c)
    fields[#fields + 1] = c
  end)

  return fields
end

return M
