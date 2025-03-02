return {
    "rcarriga/nvim-notify",
    lazy = false,
    init = function()
        vim.notify = require("notify")
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

