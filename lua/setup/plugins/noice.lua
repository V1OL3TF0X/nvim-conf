-- lazy.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        -- ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    views = {
      popupmenu = {
        border = { style = 'single' },
      },
      cmdline_popup = {
        border = {
          style = 'single',
        },
        position = {
          row = 20,
        },
      },
      cmdline_popupmenu = {
        position = {
          row = 23,
        },
        border = {
          style = 'single',
        },
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      command_palette = true,
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
  },
}
