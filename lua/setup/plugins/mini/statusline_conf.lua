local M = {}
local P = {}
local icon_hl_cache = {}
function M.setup()
  local statusline = require 'mini.statusline'
  statusline.setup {

    content = {
      -- Content for active window
      active = function()
        local mode, mode_hl = statusline.section_mode { trunc_width = 50 }
        local location = statusline.section_location { trunc_width = 75 }
        local search = statusline.section_searchcount { trunc_width = 75 }
        local filetype = vim.bo.filetype
        local icon, hl = require('mini.icons').get('filetype', filetype)

        local groups = {
          { hl = mode_hl, strings = { ' ' .. mode:upper() .. M.sep.left.close } },
          '%<', -- Mark general truncate point
        }
        if vim.b.gitsigns_status_dict ~= nil or vim.b.gitsigns_head ~= nil then
          table.insert(groups, { hl = 'MiniStatuslineSection1Start', strings = { M.icons.slant_right_2 } })
          P.git_section(groups, statusline)
          table.insert(groups, { hl = 'MiniStatuslineSection1End', strings = { M.sep.left.close } })
          table.insert(groups, '%<') -- Mark general truncate point
        end

        if vim.bo.readonly then
          table.insert(groups, { hl = 'MiniStatuslineReadonly', strings = { ' ', M.icons.locker } })
        end

        if filetype ~= '' then
          local new_hl = hl .. 'OnSL'
          if not icon_hl_cache[new_hl] then
            local colors = require 'onedark.colors'
            vim.api.nvim_set_hl(0, new_hl, { fg = vim.api.nvim_get_hl(0, { name = hl }).fg, bg = colors.bg0 })
            icon_hl_cache[new_hl] = true
          end
          table.insert(groups, { hl = new_hl, strings = { ' ' .. icon } })
        end
        local filename = ' %t '
        if filetype == 'oil' then
          filename = ' %f '
        end
        table.insert(groups, { hl = 'MiniStatuslineFilename', strings = { filename } })
        table.insert(groups, '%=') -- End left alignment

        table.insert(groups, { hl = 'MiniStatuslineSection1Start', strings = { M.sep.right.start } })
        if not statusline.is_truncated(140) and vim.bo.buftype == '' then
          filetype = filetype .. '/' .. tostring(vim.bo.fileencoding or vim.bo.encoding):upper()
        end

        if filetype ~= '' then
          table.insert(groups, { hl = hl, strings = { icon .. ' ' } })
        end
        table.insert(groups, { hl = 'MiniStatuslineFileinfo', strings = { filetype } })
        table.insert(groups, { hl = 'MiniStatuslineSection1End', strings = { M.sep.right.close } })
        table.insert(groups, { hl = mode_hl, strings = { M.sep.right.start, search, location .. ' ' } })

        return P.combine_groups(groups)
      end,
      -- Content for inactive window(s)
      inactive = function()
        local filetype = vim.bo.filetype
        local groups = {}
        if filetype ~= '' then
          local icon, hl = require('mini.icons').get('filetype', filetype)
          local new_hl = hl .. 'OnSL'
          if not icon_hl_cache[new_hl] then
            local colors = require 'onedark.colors'
            vim.api.nvim_set_hl(0, new_hl, { fg = vim.api.nvim_get_hl(0, { name = hl }).fg, bg = colors.bg0 })
            icon_hl_cache[new_hl] = true
          end
          table.insert(groups, { hl = new_hl, strings = { ' ' .. icon } })
        end
        if vim.bo.readonly then
          table.insert(groups, { hl = 'MiniStatuslineReadonly', strings = { ' ', M.icons.locker } })
        end
        table.insert(groups, { hl = 'MiniStatuslineFilename', strings = { ' %f ' } })
        return statusline.combine_groups(groups)
      end,
    },
    use_icons = vim.g.have_nerd_font,
    set_vim_settings = true,
  }

  _G.MiniStatusline.combine_groups = P.combine_groups
  _G.MiniStatusline.section_lsp = M.lsp_section
  _G.MiniStatusline.diagnostics_sections = M.insert_diag_sections
  _G.MiniStatusline.separators = M.sep
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
function M.insert_diag_sections(groups, is_inactive, hl, sep_start, sep_end)
  table.insert(groups, { hl = hl .. 'Start', strings = { sep_start } })
  local severities = vim.diagnostic.severity
  table.insert(groups, M.diagnostics_section(severities.HINT, is_inactive))
  table.insert(groups, M.diagnostics_section(severities.INFO, is_inactive))
  table.insert(groups, M.diagnostics_section(severities.WARN, is_inactive))
  table.insert(groups, M.diagnostics_section(severities.ERROR, is_inactive))
  table.insert(groups, { hl = hl .. 'End', strings = { sep_end } })
  table.insert(groups, '%<') -- Mark general truncate point
end
P.sev_to_hl = {
  [vim.diagnostic.severity.WARN] = 'MiniStatuslineDiagnosticWarn',
  [vim.diagnostic.severity.INFO] = 'MiniStatuslineDiagnosticInfo',
  [vim.diagnostic.severity.ERROR] = 'MiniStatuslineDiagnosticError',
  [vim.diagnostic.severity.HINT] = 'MiniStatuslineDiagnosticHint',
}
P.sev_to_icon = {
  [vim.diagnostic.severity.WARN] = 'warn',
  [vim.diagnostic.severity.INFO] = 'info',
  [vim.diagnostic.severity.ERROR] = 'error',
  [vim.diagnostic.severity.HINT] = 'hint',
}
P.git_status_icons = {
  Added = '+',
  Changed = '~',
  Removed = '-',
}
function M.diagnostics_section(severity, inactive)
  local count = vim.tbl_count(vim.diagnostic.get(0, { severity = severity }))
  local icons_tbl = inactive and M.icons.symbols_outlined or M.icons.symbols
  return { hl = P.sev_to_hl[severity], strings = { icons_tbl[P.sev_to_icon[severity]] .. ' ' .. count .. ' ' } }
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
M.lsp_section = function()
  local attached_lsps = vim.lsp.get_clients { bufnr = 0 }
  if #attached_lsps == 0 then
    return
  end
  return {
    hl = 'MiniStatuslineLspinfo',
    strings = {
      M.icons.lsp .. ' ' .. vim
        .iter(attached_lsps)
        :map(function(lsp)
          return lsp.name
        end)
        :join ', ',
    },
  }
end
M.section_filename = function(args)
  -- In terminal always use plain name
  if vim.bo.buftype == 'terminal' then
    return '%t'
  end
  local modified = vim.bo.modified and ' ' .. M.icons.circle or ''
  local filename = MiniStatusline.is_truncated(args.trunc_width) and '%f' or '%F'
  return filename .. modified
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
  symbols = {
    error = '',
    warn = '',
    info = '',
    hint = '󰌵',
  },
  symbols_outlined = {
    error = '󰅚',
    warn = '󰀪',
    info = '󰋽',
    hint = '󰌶',
  },
}
M.sep = {
  left = {
    start = ' ',
    close = ' ',
  },
  right = {
    start = ' ',
    close = ' ',
  },
}
return M
