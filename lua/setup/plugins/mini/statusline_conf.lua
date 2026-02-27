local M = {}
local P = {}
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
        local icon, hl = MiniIcons.get('filetype', filetype)

        local groups = {
          { hl = mode_hl, strings = { ' ' .. mode:upper() .. M.sep.left.close } },
          '%<', -- Mark general truncate point
        }
        if vim.b.gitsigns_status_dict ~= nil or vim.b.gitsigns_head ~= nil then
          table.insert(groups, { hl = 'MiniStatuslineSection1Start', strings = { vim.__icons.slant_right_2 } })
          P.git_section(groups, statusline)
          table.insert(groups, { hl = 'MiniStatuslineSection1End', strings = { M.sep.left.close } })
          table.insert(groups, '%<') -- Mark general truncate point
        end

        if vim.bo.readonly then
          table.insert(groups, { hl = 'MiniStatuslineReadonly', strings = { ' ', vim.__icons.locker } })
        end

        if filetype ~= '' then
          local new_hl = vim.__icons.combine_hl(hl, 'MiniStatuslineCommand', 'OnSL')
          table.insert(groups, { hl = new_hl, strings = { ' ' .. icon } })
        end
        local filename = ' %t '
        if filetype == 'oil' then
          filename = ' %f '
        end
        if vim.o.modified then
          filename = filename .. ' ' .. vim.__icons.circle
        end
        table.insert(groups, { hl = 'MiniStatuslineFilename', strings = { filename } })
        table.insert(groups, '%=') -- End left alignment

        local components = require('noice').api.status
        local actual = vim
          .iter({ 'mode', 'command' })
          :filter(function(component)
            ---@type NoiceStatus
            local comp = components[component]
            return comp.has() and (component ~= 'mode' or comp.get():sub(0, 2) ~= '--')
          end)
          :map(function(component)
            return '%#MiniStatusline' .. vim.__str.capitalize(component) .. '#' .. components[component].get()
          end)
          :join ' '
        if actual ~= '' then
          table.insert(groups, actual .. ' ')
        end

        table.insert(groups, { hl = 'MiniStatuslineSection1Start', strings = { M.sep.right.start } })
        if not statusline.is_truncated(140) and vim.bo.buftype == '' then
          filetype = filetype .. '/' .. tostring(vim.bo.fileencoding or vim.bo.encoding):upper()
        end

        if filetype ~= '' then
          local new_hl = vim.__icons.combine_hl(hl, 'MiniStatuslineFileinfo', 'OnSL2')
          table.insert(groups, { hl = new_hl, strings = { icon .. ' ' } })
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
          local new_hl = vim.__icons.combine_hl(hl, 'MiniStatuslineCommand', 'OnSL')
          table.insert(groups, { hl = new_hl, strings = { ' ' .. icon } })
        end
        if vim.bo.readonly then
          table.insert(groups, { hl = 'MiniStatuslineReadonly', strings = { ' ', vim.__icons.locker } })
        end
        local filename = ' %f '
        if vim.o.modified then
          filename = filename .. vim.__icons.circle
        end
        table.insert(groups, { hl = 'MiniStatuslineFilename', strings = { filename } })

        return statusline.combine_groups(groups)
      end,
    },
    use_icons = vim.g.have_nerd_font,
    set_vim_settings = true,
  }

  MiniStatusline.combine_groups = P.combine_groups
  MiniStatusline.section_lsp = M.lsp_section
  MiniStatusline.diagnostics_sections = M.insert_diag_sections
  MiniStatusline.separators = M.sep
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
  local icons_tbl = inactive and vim.__icons.symbols_outlined or vim.__icons.symbols
  return { hl = P.sev_to_hl[severity], strings = { icons_tbl[P.sev_to_icon[severity]] .. ' ' .. count .. ' ' } }
end
function P.git_section(groups, statusline)
  if vim.b.gitsigns_head ~= nil and not statusline.is_truncated(40) then
    table.insert(groups, { hl = 'MiniStatuslineGitinfo', strings = { ' ', vim.__icons.branch, vim.b.gitsigns_head } })
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
      vim.__icons.lsp .. ' ' .. vim
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
  local modified = vim.bo.modified and ' ' .. vim.__icons.circle or ''
  local filename = MiniStatusline.is_truncated(args.trunc_width) and '%f' or '%F'
  return filename .. modified
end
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
