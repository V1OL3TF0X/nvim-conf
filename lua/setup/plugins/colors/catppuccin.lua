require('catppuccin').setup {
  flavour = 'auto',
  auto_integrations = true,
  custom_highlights = function(colors)
    local statusline_bg = colors.mantle
    local git_bg = colors.surface1
    local diag_bg = colors.surface2
    local pmenu_bg = colors.mantle
    return {
      ['@lsp.typemod.property.declaration.typescriptreact'] = { fg = colors.lavender },
      typescriptPredefinedType = { fg = colors.peach },
      Special = { fg = colors.mauve },
      ColorColumn = { bg = '#5d2183' },
      CursorColumn = { bg = '#5d2183' },
      ['@tag.delimiter'] = { fg = colors.text },
      ['@tag.attribute'] = { fg = colors.peach },
      ['@tag'] = { fg = colors.red },
      tsxAttrib = { fg = colors.peach },
      ['@tag.tsx'] = { fg = colors.blue },
      ['@tag.vue'] = { fg = colors.blue },
      ['@tag.type'] = { fg = colors.blue },
      -- colors for line numbers
      LineNrAbove = { fg = colors.red },
      LineNr = { fg = colors.blue },
      LineNrBelow = { fg = colors.green },
      -- colors for LSP hints
      DiagnosticVirtualTextInfo = { fg = colors.blue },
      DiagnosticVirtualTextHint = { fg = colors.peach },
      DiagnosticInfo = { fg = colors.blue },
      DiagnosticHint = { fg = colors.mauve },
      PackageInfoUpToDateVersion = { fg = colors.green },
      PackageInfoOutdatedVersion = { fg = colors.peach },
      PackageInfoInErrorVersion = { fg = colors.red },
      -- spellchecking colors
      SpelunkerSpellBad = { fg = colors.red, style = { 'undercurl' } },
      SpelunkerComplexOrCompoundWord = { fg = colors.peach, style = { 'undercurl' } },
      -- statusline
      MiniStatuslineModeNormal = { fg = colors.mantle, bg = colors.blue, style = { 'bold' } },
      MiniStatuslineModeCommand = { fg = colors.mantle, bg = colors.peach, style = { 'bold' } },
      MiniStatuslineModeInsert = { fg = colors.mantle, bg = colors.green, style = { 'bold' } },
      MiniStatuslineModeOther = { fg = colors.mantle, bg = colors.teal, style = { 'bold' } },
      MiniStatuslineModeReplace = { fg = colors.mantle, bg = colors.red, style = { 'bold' } },
      MiniStatuslineModeVisual = { fg = colors.mantle, bg = colors.mauve, style = { 'bold' } },
      MiniStatuslineReadonly = { fg = colors.red, bg = statusline_bg },
      MiniStatuslineFilename = { fg = colors.blue, bg = statusline_bg, style = { 'bold' } },
      -- section 1 (closest to edge)
      MiniStatuslineSection1Start = { fg = statusline_bg, bg = git_bg },
      MiniStatuslineSection1End = { fg = statusline_bg, bg = git_bg },
      MiniStatuslineFileinfo = { fg = colors.green, bg = git_bg, style = { 'bold' } },
      MiniStatuslineGitinfo = { fg = colors.mauve, bg = git_bg, style = { 'bold' } },
      MiniStatuslineGitAdded = { fg = colors.green, bg = git_bg, style = { 'bold' } },
      MiniStatuslineGitChanged = { fg = colors.peach, bg = git_bg, style = { 'bold' } },
      MiniStatuslineGitRemoved = { fg = colors.red, bg = git_bg, style = { 'bold' } },
      -- section 2
      MiniStatuslineSection2Start = { fg = statusline_bg, bg = diag_bg },
      MiniStatuslineSection2End = { fg = statusline_bg, bg = diag_bg },
      MiniStatuslineLspinfo = { fg = colors.yellow, bg = diag_bg, style = { 'bold' } },
      MiniStatuslineDiagnosticWarn = { fg = colors.yellow, bg = git_bg },
      MiniStatuslineDiagnosticInfo = { fg = colors.blue, bg = git_bg },
      MiniStatuslineDiagnosticError = { fg = colors.red, bg = git_bg },
      MiniStatuslineDiagnosticHint = { fg = colors.mauve, bg = git_bg },
      Winbar = { fg = colors.rosewater, bg = statusline_bg },
      -- noice info
      MiniStatuslineCommand = { fg = colors.green, bg = statusline_bg, style = { 'bold' } },
      MiniStatuslineMode = { fg = colors.peach, bg = statusline_bg, style = { 'bold' } },
      -- default
      NoiceCompletionItemKindColor = { link = 'NoiceCompletionItemKindDefault' },
      NoiceCompletionItemKindText = { link = 'NoiceCompletionItemKindDefault' },
      -- types
      NoiceCompletionItemKindClass = { bg = pmenu_bg, fg = colors.yellow },
      NoiceCompletionItemKindInterface = { link = 'NoiceCompletionItemKindClass' },
      NoiceCompletionItemKindStruct = { link = 'NoiceCompletionItemKindClass' },
      NoiceCompletionItemKindEnum = { link = 'NoiceCompletionItemKindClass' },
      -- functions
      NoiceCompletionItemKindFunction = { bg = pmenu_bg, fg = colors.blue },
      NoiceCompletionItemKindMethod = { link = 'NoiceCompletionItemKindFunction' },
      NoiceCompletionItemKindConstructor = { bg = pmenu_bg, fg = colors.yellow },
      -- keyword
      NoiceCompletionItemKindKeyword = { bg = pmenu_bg, fg = colors.mauve },
      NoiceCompletionItemKindModule = { link = 'NoiceCompletionItemKindKeyword' },
      --value
      NoiceCompletionItemKindValue = { bg = pmenu_bg, fg = colors.flamingo },
      NoiceCompletionItemKindProperty = { bg = pmenu_bg, fg = colors.lavender },
      NoiceCompletionItemKindConstant = { bg = pmenu_bg, fg = colors.peach },
      NoiceCompletionItemKindSnippet = { bg = pmenu_bg, fg = colors.sky },
      NoiceCompletionItemKindEnumMember = { link = 'NoiceCompletionItemKindConstant' },
      NoiceCompletionItemKindUnit = { link = 'NoiceCompletionItemKindValue' },
      NoiceCompletionItemKindField = { link = 'NoiceCompletionItemKindProperty' },
      NoiceCompletionItemKindVariable = { link = 'NoiceCompletionItemKindValue' },
      -- files
      NoiceCompletionItemKindFolder = { link = 'NoiceCompletionItemKindFunction' },
      NoiceCompletionItemKindFile = { bg = pmenu_bg, fg = colors.sky },
    }
  end,
}

return {
  load = function(variant)
    local theme = ('catppuccin-' .. (variant or 'mocha'))
    vim.cmd.colorscheme(theme)
  end,
  variants = { 'frappe', 'latte', 'macchiato', 'mocha' },
}
