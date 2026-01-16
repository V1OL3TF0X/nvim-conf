return {
  'navarasu/onedark.nvim',
  priority = 1000,
  dependencies = {
    'tpope/vim-fugitive',
  },
  lazy = false,
  config = function()
    --themes
    local git_bg = '$bg2'
    local diag_bg = '$bg1'
    local statusline_bg = '$bg0'
    vim.g.airline_theme = 'onedark'
    require('onedark').setup {
      highlights = {
        ['@lsp.typemod.property.declaration.typescriptreact'] = { fg = '$cyan' },
        typescriptPredefinedType = { fg = '$orange' },
        Special = { fg = '$purple' },
        ColorColumn = { bg = '#5d2183' },
        CursorColumn = { bg = '#5d2183' },
        ['@tag.delimiter'] = { fg = '$fg' },
        ['@tag.attribute'] = { fg = '$orange' },
        ['@tag'] = { fg = '$red' },
        tsxAttrib = { fg = '$orange' },
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
        DiagnosticHint = { fg = '$purple' },
        PackageInfoUpToDateVersion = { fg = '$green' },
        PackageInfoOutdatedVersion = { fg = '$orange' },
        PackageInfoInErrorVersion = { fg = '$red' },
        -- spellchecking colors
        SpelunkerSpellBad = { fg = '$red' },
        SpelunkerComplexOrCompoundWord = { fg = '$orange' },

        MiniStatuslineReadonly = { fg = '$red', bg = statusline_bg },
        MiniStatuslineFilename = { fg = '$blue', bg = statusline_bg },
        MiniStatuslineLspinfo = { fg = '$yellow', bg = git_bg },
        MiniStatuslineFileinfo = { fg = '$green', bg = git_bg },
        MiniStatuslineFileinfo2 = { fg = git_bg, bg = statusline_bg },
        MiniStatuslineGitinfo = { fg = '$purple', bg = git_bg },
        MiniStatuslineGitAdded = { fg = '$green', bg = git_bg },
        MiniStatuslineGitChanged = { fg = '$orange', bg = git_bg },
        MiniStatuslineGitRemoved = { fg = '$red', bg = git_bg },
        MiniStatuslineGitinfo2 = { fg = git_bg, bg = statusline_bg },

        MiniStatuslineDiagnosticWarn = { fg = '$yellow', bg = diag_bg },
        MiniStatuslineDiagnosticInfo = { fg = '$blue', bg = diag_bg },
        MiniStatuslineDiagnosticError = { fg = '$red', bg = diag_bg },
        MiniStatuslineDiagnosticHint = { fg = '$purple', bg = diag_bg },
        MiniStatuslineDevinfo2 = { fg = diag_bg, bg = statusline_bg },
      },
    }
    require('onedark').load()
    vim.cmd [[hi SpelunkerComplexOrCompoundWord cterm=undercurl gui=undercurl]]
    vim.cmd [[hi SpelunkerSpellBad cterm=undercurl gui=undercurl]]
    vim.cmd [[hi MiniStatuslineFilename gui=bold]]
    vim.cmd [[hi MiniStatuslineLspinfo gui=bold]]
    vim.cmd [[hi MiniStatuslineFileinfo gui=bold]]
    vim.cmd [[hi MiniStatuslineGitinfo gui=bold]]
    vim.cmd [[hi MiniStatuslineGitAdded gui=bold]]
    vim.cmd [[hi MiniStatuslineGitChanged gui=bold]]
    vim.cmd [[hi MiniStatuslineGitRemoved gui=bold]]
  end,
}
