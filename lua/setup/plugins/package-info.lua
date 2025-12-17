return {
  "vuki656/package-info.nvim",
  --dir = "~/sandbox/package-info.nvim",
  --name = V1OL3TF0X
  --email = mattex15243@gmail.com
  dependencies = {
    "MunifTanjim/nui.nvim",
    "navarasu/onedark.nvim",
    "rcarriga/nvim-notify",
  },
  keys = {
    { "<LEADER>ns", function() require("package-info").show() end },
    { "<LEADER>nf", function() require("package-info").show { force = true } end },
    { "<LEADER>nc", function() require("package-info").hide() end },
    { "<LEADER>nt", function() require("package-info").toggle() end },
    { "<LEADER>nu", function() require("package-info").update() end },
    { "<LEADER>nd", function() require("package-info").delete() end },
    { "<LEADER>ni", function() require("package-info").install() end },
  },
  lazy = false,
  config = function()
    local colors = require 'onedark.palette'
    require 'package-info'.setup {
      highlights = {
        up_to_date = { fg = colors.light.green },
        outdated = { fg = colors.light.orange },
        invalid = { fg = colors.light.red },
      },
      icons = { enable = true },
      package_manager = 'pnpm'
    }
    local consts = require 'package-info.utils.constants'
    vim.api.nvim_create_autocmd({ 'User' }, {
      callback = function() vim.opt.statusline = vim.opt.statusline end,
      group = consts.AUTOGROUP,
      pattern = consts.LOAD_EVENT
    })
  end
}
