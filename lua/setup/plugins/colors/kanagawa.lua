require('kanagawa').setup {
  overrides = function(palette)
    local colors = palette.theme
    local statusline_bg = colors.ui.bg_m3
    local pmenu_bg = colors.ui.pmenu.bg
    local git_bg = colors.ui.bg_p1
    local diag_bg = colors.ui.bg_p2
    local makeDiagnosticColor = function(color)
      local c = require 'kanagawa.lib.color'
      return { fg = color, bg = c(color):blend(colors.ui.bg, 0.95):to_hex() }
    end

    local green = colors.term[3]
    local orange = colors.term[17]
    local blue = colors.term[5]
    local violet = colors.term[6]
    local yellow = colors.term[4]
    local red = colors.term[2]
    return {
      ['@lsp.typemod.property.declaration.typescriptreact'] = { fg = colors.syn.parameter },
      typescriptPredefinedType = { fg = orange },
      Special = { fg = violet },
      ColorColumn = { bg = '#5d2183' },
      CursorColumn = { bg = '#5d2183' },
      ['@tag.delimiter'] = { fg = colors.ui.text },
      ['@tag.attribute'] = { fg = orange },
      ['@tag'] = { fg = colors.vcs.removed },
      tsxAttrib = { fg = orange },
      ['@tag.tsx'] = { fg = blue },
      ['@tag.vue'] = { fg = blue },
      ['@tag.type'] = { fg = blue },
      -- colors for line numbers
      LineNrAbove = { fg = red },
      LineNr = { fg = blue },
      LineNrBelow = { fg = green },
      -- colors for LSP hints
      DiagnosticVirtualTextHint = makeDiagnosticColor(colors.diag.hint),
      DiagnosticVirtualTextInfo = makeDiagnosticColor(colors.diag.info),
      DiagnosticVirtualTextWarn = makeDiagnosticColor(colors.diag.warning),
      DiagnosticVirtualTextError = makeDiagnosticColor(colors.diag.error),
      PackageInfoUpToDateVersion = { fg = colors.diag.ok },
      PackageInfoOutdatedVersion = { fg = colors.diag.warn },
      PackageInfoInErrorVersion = { fg = colors.diag.error },
      -- spellchecking colors
      SpelunkerSpellBad = { fg = colors.diag.error, undercurl = true },
      SpelunkerComplexOrCompoundWord = { fg = colors.diag.warn, undercurl = true },
      -- statusline-
      MiniStatuslineModeCommand = { fg = statusline_bg, bg = colors.syn.operator, bold = true },
      MiniStatuslineModeInsert = { fg = statusline_bg, bg = colors.diag.ok, bold = true },
      MiniStatuslineModeNormal = { fg = statusline_bg, bg = colors.syn.fun, bold = true },
      MiniStatuslineModeOther = { fg = statusline_bg, bg = colors.syn.type, bold = true },
      MiniStatuslineModeReplace = { fg = statusline_bg, bg = colors.syn.constant, bold = true },
      MiniStatuslineModeVisual = { fg = statusline_bg, bg = colors.syn.keyword, bold = true },
      MiniStatuslineReadonly = { fg = colors.vcs.removed, bg = statusline_bg },
      MiniStatuslineFilename = { fg = blue, bg = statusline_bg, bold = true },
      Winbar = { fg = colors.ui.fg_dim, bg = statusline_bg },
      -- section 1 (closest to edge)
      MiniStatuslineSection1Start = { fg = statusline_bg, bg = git_bg },
      MiniStatuslineSection1End = { fg = statusline_bg, bg = git_bg },
      MiniStatuslineFileinfo = { fg = green, bg = git_bg, bold = true },
      MiniStatuslineGitinfo = { fg = violet, bg = git_bg, bold = true },
      MiniStatuslineGitAdded = { fg = colors.vcs.added, bg = git_bg, bold = true },
      MiniStatuslineGitChanged = { fg = colors.vcs.changed, bg = git_bg, bold = true },
      MiniStatuslineGitRemoved = { fg = colors.vcs.removed, bg = git_bg, bold = true },
      -- section 2
      MiniStatuslineSection2Start = { fg = statusline_bg, bg = diag_bg },
      MiniStatuslineSection2End = { fg = statusline_bg, bg = diag_bg },
      MiniStatuslineLspinfo = { fg = yellow, bg = diag_bg, bold = true },
      MiniStatuslineDiagnosticWarn = { fg = colors.diag.warn, bg = git_bg },
      MiniStatuslineDiagnosticInfo = { fg = colors.diag.info, bg = git_bg },
      MiniStatuslineDiagnosticError = { fg = colors.diag.error, bg = git_bg },
      MiniStatuslineDiagnosticHint = { fg = colors.diag.hint, bg = git_bg },

      -- noice info
      MiniStatuslineCommand = { fg = green, bg = statusline_bg, bold = true },
      MiniStatuslineMode = { fg = orange, bg = statusline_bg, bold = true },
      -- noice adjustments
      NoiceCmdlineIcon = { fg = colors.diag.info },
      NoiceCmdlineIconSearch = { fg = colors.diag.warn },
      NoiceCmdlinePopupBorder = { fg = colors.diag.info },
      NoiceCmdlinePopupBorderSearch = { fg = colors.diag.warn },
      NoiceConfirmBorder = { fg = colors.diag.info },
      -- default
      NoiceCompletionItemKindColor = { link = 'NoiceCompletionItemKindDefault' },
      NoiceCompletionItemKindText = { link = 'NoiceCompletionItemKindDefault' },
      -- types
      NoiceCompletionItemKindClass = { bg = pmenu_bg, fg = colors.syn.type },
      NoiceCompletionItemKindInterface = { link = 'NoiceCompletionItemKindClass' },
      NoiceCompletionItemKindStruct = { link = 'NoiceCompletionItemKindClass' },
      NoiceCompletionItemKindEnum = { link = 'NoiceCompletionItemKindClass' },
      -- functions
      NoiceCompletionItemKindFunction = { bg = pmenu_bg, fg = colors.syn.fun },
      NoiceCompletionItemKindMethod = { link = 'NoiceCompletionItemKindFunction' },
      NoiceCompletionItemKindConstructor = { bg = pmenu_bg, fg = colors.syn.special1 },
      -- keyword
      NoiceCompletionItemKindKeyword = { bg = pmenu_bg, fg = colors.syn.keyword },
      NoiceCompletionItemKindModule = { link = 'NoiceCompletionItemKindKeyword' },
      --value
      NoiceCompletionItemKindValue = { bg = pmenu_bg, fg = colors.syn.identifier },
      NoiceCompletionItemKindProperty = { bg = pmenu_bg, fg = colors.syn.parameter },
      NoiceCompletionItemKindConstant = { bg = pmenu_bg, fg = colors.syn.constant },
      NoiceCompletionItemKindSnippet = { bg = pmenu_bg, fg = colors.diag.info },
      NoiceCompletionItemKindEnumMember = { link = 'NoiceCompletionItemKindConstant' },
      NoiceCompletionItemKindUnit = { link = 'NoiceCompletionItemKindValue' },
      NoiceCompletionItemKindField = { link = 'NoiceCompletionItemKindProperty' },
      NoiceCompletionItemKindVariable = { link = 'NoiceCompletionItemKindValue' },
      -- files
      NoiceCompletionItemKindFolder = { link = 'NoiceCompletionItemKindFunction' },
      NoiceCompletionItemKindFile = { bg = pmenu_bg, fg = colors.diag.info },
    }
  end,
}

return {
  load = function(variant)
    vim.cmd.colorscheme('kanagawa-' .. (variant or 'wave'))
  end,
  variants = { 'wave', 'dragon', 'lotus' },
}
