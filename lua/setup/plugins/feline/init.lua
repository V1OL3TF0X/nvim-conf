local vi_mode_text = {
  n = "N",
  i = "I",
  v = "V",
  vs = "V",
  [''] = "V-B",
  V = "V-L",
  Vs = "V-L",
  c = "C",
  no = "U",
  s = "U",
  S = "U",
  ic = "U",
  r = "R",
  R = "R",
  Rv = "U",
  cv = nil,
  ce = nil,
  rm = "U",
  t = "I"
}


local function setup_comp(feline)
  local colors = require 'onedark.colors'
  local lsp = require 'feline.providers.lsp'
  local vi_mode_utils = require 'feline.providers.vi_mode'
  local custom_providers = require 'setup.plugins.feline.providers'
  local icons = custom_providers.icons
  local diagnostic_bg = colors.bg1
  local git_bg = colors.grey
  local file_name_bg = colors.bg0
  local sep_wide = string.format("%s%s ", icons.block, icons.slant_right);
  local has_branch = function()
    local branch, _ = require 'feline.providers.git'.git_branch()
    return #branch > 0
  end
  return {
    active = {
      {
        {
          provider = function()
            local current_text = ' ' .. vi_mode_text[vim.fn.mode()] .. ' '
            return current_text
          end,
          hl = function()
            return {
              name = vi_mode_utils.get_mode_highlight_name(),
              fg = colors.bg0,
              bg = vi_mode_utils.get_mode_color(),
              style = 'bold'
            }
          end,
          right_sep = function()
            return {
              str = icons.slant_right .. ' ',
              hl = { bg = file_name_bg, fg = vi_mode_utils.get_mode_color() },
            }
          end
        },
        {
          provider = custom_providers.readonly,
          hl = {
            fg = colors.red,
            bg = file_name_bg,
          },
          right_sep = { str = ' ', hl = { bg = file_name_bg } },
        },
        {
          provider = {
            name = 'file_info',
            opts = {
              type = 'relative',
              file_readonly_icon = '',
            },
          },
          short_provider = {
            name = 'file_info',
            opts = {
              type = 'unique',
              file_readonly_icon = '',
            },
          },
          priority = 100,
          hl = {
            fg = colors.blue,
            bg = file_name_bg,
            style = 'bold'
          },
          right_sep = { hl = { bg = file_name_bg }, str = ' ' },
        },
        {
          provider = icons.slant_left,
          hl = function()
            local hl = { bg = file_name_bg, fg = "bg" }
            if has_branch() then
              hl.fg = git_bg
            elseif vim.tbl_count(vim.diagnostic.count(0)) ~= 0 then
              hl.fg = diagnostic_bg
            end
            return hl
          end
        },
        {
          provider = 'git_branch',
          icon = '  ',
          hl = {
            bg = git_bg,
            fg = colors.purple,
            style = 'bold'
          },
        },
        {
          provider = 'git_diff_added',
          icon = " +",
          hl = {
            bg = git_bg,
            fg = colors.green,
            style = 'bold',
          }
        },
        {
          provider = 'git_diff_removed',
          icon = " -",
          hl = {
            bg = git_bg,
            fg = colors.red,
            style = "bold"
          }
        },
        {
          provider = 'git_diff_changed',
          icon = " ~",
          hl = {
            bg = git_bg,
            fg = colors.orange,
            style = "bold"
          }
        },
        {
          provider = icons.block .. icons.slant_right_2,
          enabled = has_branch,
          hl = function()
            local hl = {
              fg = git_bg,
              bg = "bg"
            }
            if vim.tbl_count(vim.diagnostic.count(0)) ~= 0 then
              hl.bg = diagnostic_bg
            end
            return hl
          end,
        },
        {
          provider = 'diagnostic_errors',
          enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
          end,
          hl = {
            fg = colors.red,
            bg = diagnostic_bg
          }
        },
        {
          provider = 'diagnostic_warnings',
          enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
          end,
          hl = {
            fg = colors.yellow,
            bg = diagnostic_bg
          }
        },
        {
          provider = 'diagnostic_hints',
          enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
          end,
          hl = {
            fg = colors.cyan,
            bg = diagnostic_bg
          }
        },
        {
          provider = 'diagnostic_info',
          enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
          end,
          hl = {
            fg = colors.blue,
            bg = diagnostic_bg
          }
        },
        {
          provider = icons.block .. icons.slant_right_2,
          enabled = function()
            return vim.tbl_count(vim.diagnostic.count(0)) ~= 0
          end,
          hl = {
            fg = diagnostic_bg
          }
        },
        {
          provider = function()
            local status = require 'package-info.ui.generic.loading-status'
            return (status.state.current_spinner or "") .. require 'package-info'.get_status()
          end,
          truncate_hide = true,
          hl = {
            style = "bold",
          },
          left_sep = "  ",
          right_sep = " ",
        }
      },
      {
        {

          truncate_hide = true,
          provider = 'lsp_client_names',
          icon = ' ',
          priority = 1,
          hl = {
            fg = colors.yellow
          }
        },
        {
          short_provider = '',
          provider = custom_providers.file_osinfo,
          left_sep = { str = sep_wide, hl = { bg = diagnostic_bg, fg = "bg" }, always_visible = true, },
          hl = {
            fg = colors.purple,
            bg = diagnostic_bg,
            style = 'bold',
          },
        },
        {
          left_sep = {
            str = sep_wide,
            hl = { bg = git_bg, fg = diagnostic_bg },
          },
          short_provider = {
            name = 'file_type',
            opts = {
              case = 'lowercase',
            },
          },
          provider = {
            name = 'file_type',
            opts = {
              case = 'lowercase',
              filetype_icon = true,
            },
          },
          hl = { fg = colors.green, style = 'bold', bg = git_bg },
        },
        {
          provider = 'file_encoding',
          truncate_hide = true,
          left_sep = { str = '/', hl = { fg = colors.green, style = 'bold', bg = git_bg } },
          hl = {
            fg = colors.green,
            bg = git_bg,
            style = 'bold',
          },
        },

        {
          left_sep = { str = sep_wide, hl = { bg = file_name_bg, fg = git_bg }, always_visible = true, },
          provider = 'scroll_bar',
          short_provider = '',
          hl = {
            fg = colors.blue,
            bg = file_name_bg,
            style = 'bold'
          }
        },
        {
          provider = 'line_percentage',
          name = 'line_percent',
          priority = -1,
          truncate_hide = true,
          left_sep = { str = ' ', hl = { bg = file_name_bg } },
          hl = {
            bg = file_name_bg,
            style = 'bold'
          },
        },
        {
          provider = {
            name = 'position',
            opts = { padding = true },
          },
          left_sep = function()
            return {
              str = string.format(' %s%s', icons.slant_left, icons.block),
              hl = {
                bg = file_name_bg,
                fg = vi_mode_utils.get_mode_color(),
                style = 'bold'
              }
            }
          end,
          hl = function()
            return {
              name = vi_mode_utils.get_mode_highlight_name(),
              fg = file_name_bg,
              bg = vi_mode_utils.get_mode_color(),
              style = 'bold'
            }
          end,
          right_sep = function()
            return {
              str = icons.block,
              fg = file_name_bg,
              bg = vi_mode_utils.get_mode_color(),
              style = 'bold'
            }
          end
        },
      },
    },
  }
end

return {
  "freddiehaddad/feline.nvim",
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
    "vuki656/package-info.nvim",
    "naravssu/onedark.nvim"
  },
  lazy = false,
  config = function()
    local colors = require 'onedark.colors'
    local feline = require 'feline'
    feline.setup {
      components = setup_comp(feline),
      vi_mode_colors = {
        LINES = colors.purple,
        NORMAL = colors.green,
        INSERT = colors.blue,
        VISUAL = colors.purple,
        OP = colors.green,
        BLOCK = colors.purple,
        REPLACE = colors.red,
        ['V-REPLACE'] = colors.red,
        ENTER = colors.cyan,
        MORE = colors.cyan,
        SELECT = colors.orange,
        COMMAND = colors.cyan,
        SHELL = colors.green,
        TERM = colors.blue,
        NONE = colors.yellow
      }
    }
    feline.use_theme({
      fg = colors.fg,
      bg = colors.bg2,
      black = colors.black,
      skyblue = colors.blue,
      cyan = colors.cyan,
      green = colors.green,
      oceanblue = colors.blue,
      magenta = colors.purple,
      orange = colors.orange,
      red = colors.red,
      violet = colors.purple,
      white = colors.white,
      yellow = colors.yellow,
    })
  end
}
