return {
  'navarasu/onedark.nvim',
  priority = 1000,
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive',
  },
  lazy = false,
  config = function()
    --themes
    vim.g.airline_theme = 'onedark'
    require('onedark').setup {
      highlights = {
        ['@lsp.type.member.typescriptreact'] = { fg = '$cyan' },
        typescriptPredefinedType = { fg = '$orange' },
        Special = { fg = '$purple' },
        ColorColumn = { bg = '#5d2183' },
        CursorColumn = { bg = '#5d2183' },
        ['@tag.delimiter'] = { fg = '$fg' },
        ['@tag.attribute'] = { fg = '$orange' },
        ['@tag'] = { fg = '$red' },
        ['@tag.tsx'] = { fg = '$blue' },
        ['@tag.vue'] = { fg = '$blue' },
        ['@tag.type'] = { fg = '$blue' },
        -- colors for line numbers
        LineNrAbove = { fg = '$red' },
        LineNr = { fg = '$blue' },
        LineNrBelow = { fg = '$green' },
        -- colors for LSP hints
        DiagnosticVirtualTextInfo = { fg = '$blue' },
        DiagnosticVirtualTextHint = { fg = '$orange' },
        DiagnosticInfo = { fg = '$blue' },
        DiagnosticHint = { fg = '$orange' },
        PackageInfoUpToDateVersion = { fg = '$green' },
        PackageInfoOutdatedVersion = { fg = '$orange' },
        PackageInfoInErrorVersion = { fg = '$red' },
        -- spellchecking colors
        SpelunkerSpellBad = { fg = '$red' },
        SpelunkerComplexOrCompoundWord = { fg = '$orange' },
      },
    }
    require('onedark').load()
    vim.cmd [[hi SpelunkerComplexOrCompoundWord cterm=undercurl gui=undercurl]]
    vim.cmd [[hi SpelunkerSpellBad cterm=undercurl gui=undercurl]]
  end,
}
