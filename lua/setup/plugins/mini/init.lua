return {
  'nvim-mini/mini.nvim',
  dependencies = {
    'navarasu/onedark.nvim',
  },
  version = false,
  lazy = false,
  config = function()
    require('mini.ai').setup {}
    require('mini.comment').setup {}
    require('mini.completion').setup {
      window = {
        info = { height = 25, width = 80, border = 'single' },
        signature = { height = 25, width = 80, border = 'single' },
      },
    }
    require('mini.operators').setup {}
    require('mini.pairs').setup {}
    local mini_icons = require 'mini.icons'
    mini_icons.setup {}
    mini_icons.mock_nvim_web_devicons()
    local gen_loader = require('mini.snippets').gen_loader
    require('mini.snippets').setup {
      snippets = {
        gen_loader.from_lang(),
      },
    }
    require('mini.splitjoin').setup {}
    require('mini.surround').setup {}
    local mini_keymap = require 'mini.keymap'
    mini_keymap.setup {}
    local map_multistep = mini_keymap.map_multistep

    map_multistep('i', '<Tab>', { 'minisnippets_next', 'minisnippets_expand', 'pmenu_next' })
    map_multistep('i', '<S-Tab>', { 'minisnippets_prev', 'pmenu_prev' })

    require('setup.plugins.mini.statusline_conf').setup()
  end,
}
