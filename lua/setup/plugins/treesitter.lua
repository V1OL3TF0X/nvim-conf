return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      init = function()
        vim.g.no_plugin_maps = true
      end,
    },
  },
  lazy = false,
  build = ':TSUpdate',
  opts = {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
      'c',
      'lua',
      'vim',
      'vimdoc',
      'query',
      'javascript',
      'rust',
      'typescript',
      'gitignore',
      'go',
      'gleam',
      'graphql',
      'html',
      'json',
      'php',
      'python',
      'sql',
      'vue',
      'css',
      'scss',
      'styled',
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    autopairs = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
  config = function()
    require('treesitter-context').setup()
  end,
}
