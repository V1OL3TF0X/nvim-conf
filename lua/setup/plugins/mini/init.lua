return {
  'nvim-mini/mini.nvim',
  dependencies = {
    'navarasu/onedark.nvim',
  },
  version = false,
  lazy = false,
  config = function()
    local gen_spec = require('mini.ai').gen_spec
    require('mini.ai').setup {
      custom_textobjects = {
        x = { '[:=]().*()[,;]' },
        P = { '%.().-%b()()[ .;,]' },
        -- Function definition (needs treesitter queries with these captures)
        F = gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
      },
    }
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

    map_multistep('i', '<Tab>', { 'pmenu_next', 'minisnippets_next', 'minisnippets_expand' })
    map_multistep('i', '<S-Tab>', { 'minisnippets_prev', 'pmenu_prev' })
    map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
    local mode = { 'i', 'c', 'x', 's' }
    mini_keymap.map_combo(mode, 'jk', '<BS><BS><Esc>')
    -- To not have to worry about the order of keys, also map "kj"
    mini_keymap.map_combo(mode, 'kj', '<BS><BS><Esc>')

    require('setup.plugins.mini.statusline_conf').setup()
    require 'setup.plugins.mini.breadcrumbs'

    local mini_pick = require 'mini.pick'
    mini_pick.setup {}

    vim.keymap.set('n', '<leader>pb', mini_pick.builtin.buffers)
    vim.keymap.set('n', '<leader>ph', mini_pick.builtin.help)
    vim.keymap.set('n', '<C-p>', function()
      local tool = #vim.fs.find('.git', { type = 'directory', upward = true }) > 0 and 'git' or 'rg'
      mini_pick.builtin.files { tool = tool }
    end)
    vim.keymap.set('n', '<leader>ps', function()
      mini_pick.builtin.grep_live { tool = 'rg' }
    end)
  end,
}
