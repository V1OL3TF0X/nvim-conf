return {
  "rcarriga/nvim-notify",
  lazy = false,
  init = function()
    vim.notify = function(msg, lvl, opts)
      if not require("lazy.core.config").plugins["nvim-notify"]._.loaded then
        require("lazy").load { "nvim-notify" }
      end
      return require "notify" (msg, lvl, opts)
    end
  end,
  config = function()
    require("notify").setup {
      stages = "fade",
      render = "wrapped-compact",
      background_colour = "Normal",
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { focusable = false })
      end,
      -- top_down = false,
    }
  end,
}
