-- credit: https://github.com/ngpong
local M = {}

local uv = vim.loop

if not table.unpack then
  table.unpack = unpack
end

local function wrap(timer, fn)
  return setmetatable({}, {
    __call = function(_, ...)
      fn(...)
    end,
    __index = {
      close = function()
        timer:stop()
        M.try_close(timer)
      end,
    },
  })
end
function M.throttle_trailing(ms, rush_first, fn)
  local timer = assert(uv.new_timer())
  local lock = false
  local throttled_fn, args

  throttled_fn = wrap(timer, function(...)
    if lock or (not rush_first and args == nil) then
      args = { n = select('#', ...), ... }
    end

    if lock then
      return
    end

    lock = true

    if rush_first then
      fn(...)
    end

    timer:start(ms, 0, function()
      lock = false
      if args then
        local a = args
        args = nil
        if rush_first then
          throttled_fn(table.unpack(a, 1, a.n or table.maxn(a)))
        else
          fn(table.unpack(a, 1, a.n or table.maxn(a)))
        end
      end
    end)
  end)

  return function(...)
    throttled_fn(...)
  end
end

return M
