-- credit: https://github.com/ngpong
local M = {}

local __cache = {}

vim.__autocmd.on('DirChanged', function()
  __cache.cwd = nil
  __cache.cwdsha1 = nil
  __cache.cwdtail = nil
end)

function M.cwd()
  local cwd = __cache.cwd
  if not cwd then
    local success, dir = pcall(vim.fn.getcwd) -- vim.loop.cwd()
    if success then
      cwd = dir
      __cache.cwd = cwd
    end
  end

  return cwd
end

function M.home()
  local homepath = __cache.homepath
  if not homepath then
    homepath = vim.__util.getenv 'HOME'
    __cache.homepath = homepath
  end

  return homepath
end

function M.normalize(p) -- vim.fs.normalize
  -- local fnl, _ = p:gsub("\\", "/")
  -- return fnl
  return vim.fs.normalize(p)
end

__cache.standardpath = {}
function M.standard(what)
  local path = __cache.standardpath[what]
  if not path then
    path = vim.api.nvim_call_function('stdpath', { what })
    __cache.standardpath[what] = path
  end

  return path
end

-- ffi.cdef[[ const char *strrchr(const char *s, int c); ]]
-- local ext_c = string.byte(".")
function M.ext(n)
  -- local ldot = ffi.C.strrchr(n, ext_c)
  -- return ldot and ffi.string(ldot + 1) or nil
  return n:match '%.(%w+)$' or ''
end

M.basename = vim.fs.basename
M.dirname = vim.fs.dirname

return M
