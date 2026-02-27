--themes
local git_bg = '$bg2'
local diag_bg = '$bg1'
local statusline_bg = '$bg0'
local pmenu_bg = '$bg1'
require('onedark').setup {
  highlights = {
    ['@lsp.typemod.property.declaration.typescriptreact'] = { fg = '$cyan' },
    typescriptPredefinedType = { fg = '$orange' },
    Special = { fg = '$purple' },
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
    SpelunkerSpellBad = { fg = '$red', fmt = 'undercurl' },
    SpelunkerComplexOrCompoundWord = { fg = '$orange', fmt = 'undercurl' },
    -- statusline
    MiniStatuslineReadonly = { fg = '$red', bg = statusline_bg },
    MiniStatuslineFilename = { fg = '$blue', bg = statusline_bg, fmt = 'bold' },
    -- section 1 (closest to edge)
    MiniStatuslineSection1Start = { fg = statusline_bg, bg = git_bg },
    MiniStatuslineSection1End = { fg = statusline_bg, bg = git_bg },
    MiniStatuslineFileinfo = { fg = '$green', bg = git_bg, fmt = 'bold' },
    MiniStatuslineGitinfo = { fg = '$purple', bg = git_bg, fmt = 'bold' },
    MiniStatuslineGitAdded = { fg = '$green', bg = git_bg, fmt = 'bold' },
    MiniStatuslineGitChanged = { fg = '$orange', bg = git_bg, fmt = 'bold' },
    MiniStatuslineGitRemoved = { fg = '$red', bg = git_bg, fmt = 'bold' },
    -- section 2
    MiniStatuslineSection2Start = { fg = statusline_bg, bg = diag_bg },
    MiniStatuslineSection2End = { fg = statusline_bg, bg = diag_bg },
    MiniStatuslineLspinfo = { fg = '$yellow', bg = diag_bg, fmt = 'bold' },
    MiniStatuslineDiagnosticWarn = { fg = '$yellow', bg = git_bg },
    MiniStatuslineDiagnosticInfo = { fg = '$blue', bg = git_bg },
    MiniStatuslineDiagnosticError = { fg = '$red', bg = git_bg },
    MiniStatuslineDiagnosticHint = { fg = '$purple', bg = git_bg },

    -- noice info
    MiniStatuslineCommand = { fg = '$green', bg = statusline_bg, fmt = 'bold' },
    MiniStatuslineMode = { fg = '$orange', bg = statusline_bg, fmt = 'bold' },
    -- default
    -- types
    NoiceCompletionItemKindClass = { bg = pmenu_bg, fg = '$yellow' },
    -- functions
    NoiceCompletionItemKindFunction = { bg = pmenu_bg, fg = '$blue' },
    NoiceCompletionItemKindConstructor = { bg = pmenu_bg, fg = '$yellow' },
    -- keyword
    NoiceCompletionItemKindKeyword = { bg = pmenu_bg, fg = '$purple' },
    --value
    NoiceCompletionItemKindValue = { bg = pmenu_bg, fg = '$fg' },
    NoiceCompletionItemKindProperty = { bg = pmenu_bg, fg = '$cyan' },
    NoiceCompletionItemKindConstant = { bg = pmenu_bg, fg = '$orange' },
    NoiceCompletionItemKindSnippet = { bg = pmenu_bg, fg = '$blue' },
    -- files
    NoiceCompletionItemKindFile = { bg = pmenu_bg, fg = '$blue' },
  },
}

return {
  load = function()
    require('onedark').load()
    vim.cmd [[hi link NoiceCompletionItemKindColor NoiceCompletionItemKindDefault]]
    vim.cmd [[hi link NoiceCompletionItemKindText NoiceCompletionItemKindDefault]]
    vim.cmd [[hi link NoiceCompletionItemKindInterface NoiceCompletionItemKindClass]]
    vim.cmd [[hi link NoiceCompletionItemKindStruct NoiceCompletionItemKindClass]]
    vim.cmd [[hi link NoiceCompletionItemKindEnum NoiceCompletionItemKindClass]]
    vim.cmd [[hi link NoiceCompletionItemKindMethod NoiceCompletionItemKindFunction]]
    vim.cmd [[hi link NoiceCompletionItemKindModule NoiceCompletionItemKindKeyword]]
    vim.cmd [[hi link NoiceCompletionItemKindEnumMember NoiceCompletionItemKindConstant]]
    vim.cmd [[hi link NoiceCompletionItemKindUnit NoiceCompletionItemKindValue]]
    vim.cmd [[hi link NoiceCompletionItemKindField NoiceCompletionItemKindProperty]]
    vim.cmd [[hi link NoiceCompletionItemKindVariable NoiceCompletionItemKindValue]]
    vim.cmd [[hi link NoiceCompletionItemKindFolder NoiceCompletionItemKindFunction]]
  end,
}
