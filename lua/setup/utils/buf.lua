-- credit: https://github.com/ngpong
local M = {}

local ffi = require 'ffi'

local C = ffi.C

function M.is_valid(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr)
end

function M.filetype(bufnr)
  bufnr = bufnr or 0
  return vim.bo[bufnr].filetype
end

function M.buftype(bufnr)
  bufnr = bufnr or 0
  return vim.bo[bufnr].buftype
end

function M.name(bufnr)
  bufnr = bufnr or M.current()

  local success, result = pcall(vim.api.nvim_buf_get_name, bufnr)
  if not success then
    vim.__logger.error(debug.traceback())
    return nil
  else
    return result
  end
end

function M.is_unnamed(bufnr)
  return vim.bo[bufnr].filetype == '' and M.name(bufnr) == ''
end

function M.current()
  return vim.api.nvim_get_current_buf()
end

function M.number(winid_or_path)
  if not winid_or_path then
    return M.current()
  end

  if type(winid_or_path) == 'number' then
    local winid = winid_or_path

    local bufnr = vim.__win.bufnr(winid)
    if bufnr > 0 then
      return bufnr
    else
      return -1
    end
  elseif type(winid_or_path) == 'string' then
    local path = winid_or_path

    local bufinfo = vim.fn.getbufinfo(path)[1]
    if bufinfo then
      return bufinfo.bufnr
    else
      return -1
    end
  else
    assert(false)
  end
end
return M
