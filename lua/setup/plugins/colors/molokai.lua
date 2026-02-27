---@diagnostic disable-next-line: missing-fields
require('molokai-nvim').setup {
  italic = false,
  on_highlights = function(hl, colors)
    local statusline_bg = colors.bg_statusline
    local git_bg = colors.bg_alt
    local diag_bg = colors.bg_visual
    local pmenu_bg = colors.black
    hl['@lsp.typemod.property.declaration.typescriptreact'] = { fg = colors.white }
    hl.typescriptPredefinedType = { fg = colors.orange }
    hl['@tag'] = { fg = colors.pink }
    hl.tsxAttrib = { fg = colors.orange }
    hl['@tag.tsx'] = { fg = colors.green }
    hl['@tag.vue'] = { fg = colors.green }
    hl['@tag.type'] = { fg = colors.green }
    -- colors for line numbers
    hl.LineNrAbove = { fg = colors.orange }
    hl.LineNr = { fg = colors.pink }
    hl.LineNrBelow = { fg = colors.yellow }
    -- colors for LSP hints
    hl.PackageInfoUpToDateVersion = { fg = colors.green }
    hl.PackageInfoOutdatedVersion = { fg = colors.orange }
    hl.PackageInfoInErrorVersion = { fg = colors.pink }
    -- spellchecking colors
    hl.SpelunkerSpellBad = { fg = colors.pink, undercurl = true }
    hl.SpelunkerComplexOrCompoundWord = { fg = colors.orange, undercurl = true }
    -- statusline
    hl.MiniStatuslineModeNormal = { fg = statusline_bg, bg = colors.blue, bold = true }
    hl.MiniStatuslineModeCommand = { fg = statusline_bg, bg = colors.orange, bold = true }
    hl.MiniStatuslineModeInsert = { fg = statusline_bg, bg = colors.green, bold = true }
    hl.MiniStatuslineModeOther = { fg = statusline_bg, bg = colors.teal, bold = true }
    hl.MiniStatuslineModeReplace = { fg = statusline_bg, bg = colors.pink, bold = true }
    hl.MiniStatuslineModeVisual = { fg = statusline_bg, bg = colors.mauve, bold = true }
    hl.MiniStatuslineReadonly = { fg = colors.pink, bg = statusline_bg }
    hl.MiniStatuslineFilename = { fg = colors.cyan, bg = statusline_bg, bold = true }
    -- section 1 (closest to edge)
    hl.MiniStatuslineSection1Start = { fg = statusline_bg, bg = git_bg }
    hl.MiniStatuslineSection1End = { fg = statusline_bg, bg = git_bg }
    hl.MiniStatuslineFileinfo = { fg = colors.green, bg = git_bg, bold = true }
    hl.MiniStatuslineGitinfo = { fg = colors.purple, bg = git_bg, bold = true }
    hl.MiniStatuslineGitAdded = { fg = colors.green, bg = git_bg, bold = true }
    hl.MiniStatuslineGitChanged = { fg = colors.orange, bg = git_bg, bold = true }
    hl.MiniStatuslineGitRemoved = { fg = colors.pink, bg = git_bg, bold = true }
    -- section 2
    hl.MiniStatuslineSection2Start = { fg = statusline_bg, bg = diag_bg }
    hl.MiniStatuslineSection2End = { fg = statusline_bg, bg = diag_bg }
    hl.MiniStatuslineLspinfo = { fg = colors.yellow, bg = diag_bg, bold = true }
    hl.MiniStatuslineDiagnosticWarn = { fg = colors.orange, bg = git_bg }
    hl.MiniStatuslineDiagnosticInfo = { fg = colors.cyan, bg = git_bg }
    hl.MiniStatuslineDiagnosticError = { fg = colors.pink, bg = git_bg }
    hl.MiniStatuslineDiagnosticHint = { fg = colors.comment, bg = git_bg }
    hl.Winbar = { fg = colors.text, bg = statusline_bg }
    -- noice info
    hl.MiniStatuslineCommand = { fg = colors.green, bg = statusline_bg, bold = true }
    hl.MiniStatuslineMode = { fg = colors.orange, bg = statusline_bg, bold = true }
    -- noice adjustments
    hl.NoiceCmdlineIcon = { fg = colors.cyan }
    hl.NoiceCmdlineIconSearch = { fg = colors.orange }
    hl.NoiceCmdlinePopupBorder = { fg = colors.cyan }
    hl.NoiceCmdlinePopupBorderSearch = { fg = colors.orange }
    hl.NoiceConfirmBorder = { fg = colors.cyan }
    -- default
    hl.NoiceCompletionItemKindColor = { link = 'NoiceCompletionItemKindDefault' }
    hl.NoiceCompletionItemKindText = { link = 'NoiceCompletionItemKindDefault' }
    -- types
    hl.NoiceCompletionItemKindClass = { bg = pmenu_bg, fg = colors.cyan }
    hl.NoiceCompletionItemKindInterface = { link = 'NoiceCompletionItemKindClass' }
    hl.NoiceCompletionItemKindStruct = { link = 'NoiceCompletionItemKindClass' }
    hl.NoiceCompletionItemKindEnum = { link = 'NoiceCompletionItemKindClass' }
    -- functions
    hl.NoiceCompletionItemKindFunction = { bg = pmenu_bg, fg = colors.green }
    hl.NoiceCompletionItemKindMethod = { link = 'NoiceCompletionItemKindFunction' }
    hl.NoiceCompletionItemKindConstructor = { link = 'NoiceCompletionItemKindFunction' }
    -- keyword
    hl.NoiceCompletionItemKindKeyword = { bg = pmenu_bg, fg = colors.pink }
    hl.NoiceCompletionItemKindModule = { link = 'NoiceCompletionItemKindKeyword' }
    --value
    hl.NoiceCompletionItemKindValue = { bg = pmenu_bg, fg = colors.white }
    hl.NoiceCompletionItemKindProperty = { bg = pmenu_bg, fg = colors.white }
    hl.NoiceCompletionItemKindConstant = { bg = pmenu_bg, fg = colors.purple }
    hl.NoiceCompletionItemKindSnippet = { bg = pmenu_bg, fg = colors.cyan }
    hl.NoiceCompletionItemKindEnumMember = { link = 'NoiceCompletionItemKindConstant' }
    hl.NoiceCompletionItemKindUnit = { link = 'NoiceCompletionItemKindValue' }
    hl.NoiceCompletionItemKindField = { link = 'NoiceCompletionItemKindProperty' }
    hl.NoiceCompletionItemKindVariable = { link = 'NoiceCompletionItemKindValue' }
    -- files
    hl.NoiceCompletionItemKindFolder = { link = 'NoiceCompletionItemKindFunction' }
    hl.NoiceCompletionItemKindFile = { bg = pmenu_bg, fg = colors.cyan }
  end,
}

return {
  load = function()
    vim.cmd.colorscheme 'molokai-nvim'
  end,
}
