return {
  'navarasu/onedark.nvim',
  priority = 1000,
  dependencies = {
    'tpope/vim-fugitive',
    { 'catppuccin/nvim', name = 'catppuccin' },
    'rebelot/kanagawa.nvim',
    'jakubkarlicek/molokai-nvim',
  },
  lazy = false,
  config = function()
    local themes = {
      onedark = vim.__lazy.require 'setup.plugins.colors.onedark',
      kanagawa = vim.__lazy.require 'setup.plugins.colors.kanagawa',
      molokai = vim.__lazy.require 'setup.plugins.colors.molokai',
      catppuccin = vim.__lazy.require 'setup.plugins.colors.catppuccin',
    }
    vim.keymap.set('n', '<leader>ts', ':Theme', { desc = 'Switch theme' })
    vim.api.nvim_create_user_command('Theme', function(args)
      local theme = themes[args.fargs[1]]
      if theme == nil then
        return
      end
      --- @type string|nil
      local variant = args.fargs[2]
      if not vim.tbl_contains(theme.variants or {}, variant) then
        variant = nil
      end
      theme.load(variant)
    end, {
      nargs = '*',
      complete = function(arg_lead, cmd_line)
        local arguments = vim.split(cmd_line, ' ', { trimempty = true })
        local number_of_arguments = #arguments

        if number_of_arguments > 3 then
          return {}
        end
        local options = vim.tbl_keys(themes)
        if
          (number_of_arguments == 3 or (number_of_arguments == 2 and arg_lead == '')) and themes[arguments[2]] ~= nil
        then
          options = themes[arguments[2]].variants or {}
        end
        return vim
          .iter(options)
          :filter(
            ---@param option any
            function(option)
              return type(option) == 'string'
            end
          )
          :filter(
            ---@param name string
            function(name)
              return vim.startswith(name, arg_lead)
            end
          )
          :totable()
      end,
    })
    local theme = vim.env.NVIM_COLORSCHEME
    print(vim.inspect(theme))
    if not theme or not vim.tbl_contains(vim.tbl_keys(themes), theme) then
      theme = 'onedark'
    end
    themes[theme].load()
  end,
}
