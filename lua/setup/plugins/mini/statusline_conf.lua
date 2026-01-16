local M = {}
local P = {}
function M.setup()
  local statusline = require 'mini.statusline'
  statusline.setup {

    content = {
      -- Content for active window
      active = function()
        local mode, mode_hl = statusline.section_mode { trunc_width = 50 }
        local filename = statusline.section_filename { trunc_width = 140 }
        local location = statusline.section_location { trunc_width = 75 }
        local search = statusline.section_searchcount { trunc_width = 75 }

        local groups = {
          { hl = mode_hl, strings = { ' ' .. mode:upper() } },
          { hl = mode_hl .. '2', strings = { P.sep_left_end } },
          '%<', -- Mark general truncate point
        }
        if vim.b.gitsigns_status_dict ~= nil or vim.b.gitsigns_head ~= nil then
          table.insert(groups, { hl = 'MiniStatuslineGitinfo2', strings = { M.icons.slant_left } })
          P.git_section(groups, statusline)
          table.insert(groups, { hl = 'MiniStatuslineGitinfo2', strings = { P.sep_left_end } })
          table.insert(groups, '%<') -- Mark general truncate point
        end

        if vim.tbl_count(vim.diagnostic.get(0)) > 0 then
          table.insert(groups, { hl = 'MiniStatuslineDevinfo2', strings = { P.sep_left_start } })
          local severities = vim.diagnostic.severity
          table.insert(groups, P.diagnostics_section(severities.HINT))
          table.insert(groups, P.diagnostics_section(severities.INFO))
          table.insert(groups, P.diagnostics_section(severities.WARN))
          table.insert(groups, P.diagnostics_section(severities.ERROR))
          table.insert(groups, { hl = 'MiniStatuslineDevinfo2', strings = { P.sep_left_end } })
          table.insert(groups, '%<') -- Mark general truncate point
        end

        if vim.bo.readonly then
          table.insert(groups, { hl = 'MiniStatuslineReadonly', strings = { ' ', M.icons.locker } })
        end
        table.insert(groups, { hl = 'MiniStatuslineFilename', strings = { ' ', filename, ' ' } })
        table.insert(groups, '%=') -- End left alignment

        if vim.tbl_count(vim.diagnostic.get(0)) > 0 then
          table.insert(groups, { hl = 'MiniStatuslineDevinfo2', strings = { P.sep_right_start } })
          P.lsp_section(groups)
          table.insert(groups, { hl = 'MiniStatuslineDevinfo2', strings = { P.sep_right_end } })
          table.insert(groups, '%<') -- Mark general truncate point
        end

        table.insert(groups, { hl = 'MiniStatuslineFileinfo2', strings = { P.sep_right_start } })
        local filetype = vim.bo.filetype
        if filetype ~= '' then
          local icon, hl = require('mini.icons').get('filetype', filetype)
          table.insert(groups, { hl = hl, strings = { icon .. ' ' } })
        end
        if not statusline.is_truncated(140) and vim.bo.buftype == '' then
          filetype = filetype .. '/' .. tostring(vim.bo.fileencoding or vim.bo.encoding):upper()
        end
        table.insert(groups, { hl = 'MiniStatuslineFileinfo', strings = { filetype } })
        table.insert(groups, { hl = 'MiniStatuslineFileinfo2', strings = { P.sep_right_end } })
        table.insert(groups, { hl = mode_hl .. '2', strings = { P.sep_right_start } })
        table.insert(groups, { hl = mode_hl, strings = { search, location .. ' ' } })

        return P.combine_groups(groups)
      end,
      -- Content for inactive window(s)
      inactive = function()
        local filename = statusline.section_filename { trunc_width = 140 }
        local severities = vim.diagnostic.severity
        return P.combine_groups {
          { hl = 'MiniStatuslineFilename', strings = { ' ', filename, ' ' } },
          '%=',
          { hl = 'MiniStatuslineDevinfo2', strings = { P.sep_left_start } },
          P.diagnostics_section(severities.HINT),
          P.diagnostics_section(severities.INFO),
          P.diagnostics_section(severities.WARN),
          P.diagnostics_section(severities.ERROR),
          { hl = 'MiniStatuslineDevinfo2', strings = { M.icons.block } },
        }
      end,
    },
    use_icons = vim.g.have_nerd_font,
    set_vim_settings = true,
  }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.compute_attached_lsp = function(buf_id) end
  local colors = require 'onedark.colors'
  for mode in vim.iter { 'Normal', 'Insert', 'Visual', 'Replace', 'Command', 'Other' } do
    local original_name = 'MiniStatuslineMode' .. mode
    vim.api.nvim_set_hl(
      0,
      original_name .. '2',
      { bg = colors.bg0, fg = vim.api.nvim_get_hl(0, { name = original_name }).bg }
    )
  end
end
function P.combine_groups(groups)
  local parts = vim.tbl_map(function(s)
    if type(s) == 'string' then
      return s
    end
    if type(s) ~= 'table' then
      return ''
    end

    local string_arr = vim.tbl_filter(function(x)
      return type(x) == 'string' and x ~= ''
    end, s.strings or {})
    local str = table.concat(string_arr, ' ')

    -- Use previous highlight group
    if s.hl == nil then
      return ' ' .. str .. ' '
    end

    -- Allow using this highlight group later
    if str:len() == 0 then
      return '%#' .. s.hl .. '#'
    end

    return string.format('%%#%s#%s', s.hl, str)
  end, groups)

  return table.concat(parts, '')
end
P.sev_to_hl = {
  [vim.diagnostic.severity.WARN] = 'MiniStatuslineDiagnosticWarn',
  [vim.diagnostic.severity.INFO] = 'MiniStatuslineDiagnosticInfo',
  [vim.diagnostic.severity.ERROR] = 'MiniStatuslineDiagnosticError',
  [vim.diagnostic.severity.HINT] = 'MiniStatuslineDiagnosticHint',
}
P.sev_to_icon = {
  [vim.diagnostic.severity.WARN] = '',
  [vim.diagnostic.severity.INFO] = '',
  [vim.diagnostic.severity.ERROR] = '',
  [vim.diagnostic.severity.HINT] = '',
}
P.git_status_icons = {
  Added = '+',
  Changed = '~',
  Removed = '-',
}
function P.diagnostics_section(severity)
  local count = vim.tbl_count(vim.diagnostic.get(0, { severity = severity }))
  if count > 0 then
    return { hl = P.sev_to_hl[severity], strings = { count .. P.sev_to_icon[severity] } }
  end
  return ''
end
function P.git_section(groups, statusline)
  if vim.b.gitsigns_head ~= nil and not statusline.is_truncated(40) then
    table.insert(groups, { hl = 'MiniStatuslineGitinfo', strings = { ' ', M.icons.branch, vim.b.gitsigns_head } })
  end
  if vim.b.gitsigns_status_dict ~= nil then
    for diff in vim.iter { 'Added', 'Changed', 'Removed' } do
      local count = vim.b.gitsigns_status_dict[diff:lower()]
      if count ~= nil then
        table.insert(groups, {
          hl = 'MiniStatuslineGit' .. diff,
          strings = { ' ' .. P.git_status_icons[diff] .. count },
        })
      end
    end
  end
end
function P.lsp_section(groups)
  local attached_lsps = vim.lsp.get_clients { bufnr = 0 }
  if #attached_lsps == 0 then
    return
  end
  table.insert(groups, {
    hl = 'MiniStatuslineLspinfo',
    strings = {
      M.icons.lsp .. ' ' .. vim
        .iter(attached_lsps)
        :map(function(lsp)
          return lsp.name
        end)
        :join ', ',
    },
  })
end
M.icons = {
  lsp = '',
  locker = '', -- #f023
  page = '☰', -- 2630
  line_number = '', -- e0a1
  connected = '', -- f817
  dos = '', -- e70f
  unix = '', -- f17c
  mac = '', -- f179
  vertical_bar = '┃',
  vertical_bar_thin = '│',
  left = '',
  right = '',
  block = '█',
  left_filled = '',
  right_filled = '',
  slant_left = '',
  slant_left_thin = '',
  slant_right = '',
  slant_right_thin = '',
  slant_left_2 = '',
  slant_left_2_thin = '',
  slant_right_2 = '',
  slant_right_2_thin = '',
  left_rounded = '',
  left_rounded_thin = '',
  right_rounded = '',
  right_rounded_thin = '',
  circle = '●',
  branch = '',
}
P.sep_right_start = M.icons.slant_left_2 .. M.icons.block
P.sep_left_end = M.icons.block .. M.icons.slant_right_2
P.sep_right_end = M.icons.block .. M.icons.slant_right
P.sep_left_start = M.icons.slant_left .. M.icons.block
return M
