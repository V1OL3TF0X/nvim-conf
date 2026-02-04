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
        -- statusline
        MiniStatuslineReadonly = { fg = '$red', bg = statusline_bg },
        MiniStatuslineFilename = { fg = '$blue', bg = statusline_bg },
        -- section 1 (closest to edge)
        MiniStatuslineSection1Start = { fg = statusline_bg, bg = git_bg },
        MiniStatuslineSection1End = { fg = statusline_bg, bg = git_bg },
        MiniStatuslineFileinfo = { fg = '$green', bg = git_bg },
        MiniStatuslineGitinfo = { fg = '$purple', bg = git_bg },
        MiniStatuslineGitAdded = { fg = '$green', bg = git_bg },
        MiniStatuslineGitChanged = { fg = '$orange', bg = git_bg },
        MiniStatuslineGitRemoved = { fg = '$red', bg = git_bg },
        -- section 2
        MiniStatuslineSection2Start = { fg = statusline_bg, bg = diag_bg },
        MiniStatuslineSection2End = { fg = statusline_bg, bg = diag_bg },
        MiniStatuslineLspinfo = { fg = '$yellow', bg = diag_bg },
        MiniStatuslineDiagnosticWarn = { fg = '$yellow', bg = git_bg },
        MiniStatuslineDiagnosticInfo = { fg = '$blue', bg = git_bg },
        MiniStatuslineDiagnosticError = { fg = '$red', bg = git_bg },
        MiniStatuslineDiagnosticHint = { fg = '$purple', bg = git_bg },

        -- noice info
        MiniStatuslineCommand = { fg = '$green', bg = statusline_bg },
        MiniStatuslineMode = { fg = '$orange', bg = statusline_bg },
        MiniStatuslineSearch = { fg = '$blue', bg = statusline_bg },
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
    vim.cmd [[hi MiniStatuslineCommand gui=bold]]
    vim.cmd [[hi MiniStatuslineMode    gui=bold]]
    vim.cmd [[hi MiniStatuslineSearch  gui=bold]]
  end,
}
