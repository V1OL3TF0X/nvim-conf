return {
  "V1OL3TF0X/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    restricted_keys = {
      J = "v",
      K = "v",
    },
    hints = {
      ["%D1[JK]"] = {
        message = function(keys)
          return "Use " .. keys:sub(3, 3) .. " instead of " .. keys:sub(2, 3)
        end,
        length = 3,
      },
    },
  },
}
