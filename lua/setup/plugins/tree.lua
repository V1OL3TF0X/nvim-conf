local tree_actions = {}
local function tree_actions_menu(node)
  local entry_maker = function(menu_item)
    return {
      value = menu_item,
      ordinal = menu_item.name,
      display = menu_item.name,
    }
  end

  local finder = require('telescope.finders').new_table {
    results = tree_actions,
    entry_maker = entry_maker,
  }

  local sorter = require('telescope.sorters').get_generic_fuzzy_sorter()

  local default_options = {
    finder = finder,
    sorter = sorter,
    attach_mappings = function(prompt_buffer_number)
      local actions = require 'telescope.actions'

      -- On item select
      actions.select_default:replace(function()
        local state = require 'telescope.actions.state'
        local selection = state.get_selected_entry()
        -- Closing the picker
        actions.close(prompt_buffer_number)
        -- Executing the callback
        selection.value.handler(node)
      end)

      -- The following actions are disabled in this example
      -- You may want to map them too depending on your needs though
      actions.add_selection:replace(function() end)
      actions.remove_selection:replace(function() end)
      actions.toggle_selection:replace(function() end)
      actions.select_all:replace(function() end)
      actions.drop_all:replace(function() end)
      actions.toggle_all:replace(function() end)

      return true
    end,
  }

  -- Opening the menu
  require('telescope.pickers').new({ prompt_title = 'Tree menu' }, default_options):find()
end

local function natural_cmp(left, right)
  left = left.name:lower()
  right = right.name:lower()

  if left == right then
    return false
  end

  for i = 1, math.max(string.len(left), string.len(right)), 1 do
    local l = string.sub(left, i, -1)
    local r = string.sub(right, i, -1)

    if type(tonumber(string.sub(l, 1, 1))) == 'number' and type(tonumber(string.sub(r, 1, 1))) == 'number' then
      local l_number = tonumber(string.match(l, '^[0-9]+'))
      local r_number = tonumber(string.match(r, '^[0-9]+'))

      if l_number ~= r_number then
        return l_number < r_number
      end
    elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
      return l < r
    end
  end
end

return {
  -- https://github.com/nvim-tree/nvim-tree.lua
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-tree/nvim-web-devicons', -- Fancy icon support
  },
  opts = {
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    sort_by = function(nodes)
      table.sort(nodes, natural_cmp)
    end,
    on_attach = function(bufnr)
      local api = require 'nvim-tree.api'
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      -- default bindings
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set('n', '<M-c>', function()
        local file_src = api.tree.get_node_under_cursor()['absolute_path']
        local input_opts = { prompt = 'Copy to ', default = file_src, completion = 'file' }

        vim.ui.input(input_opts, function(file_out)
          local dir = vim.fn.fnamemodify(file_out, ':h')

          local res = vim.fn.system { 'mkdir', '-p', dir }
          if vim.v.shell_error ~= 0 then
            vim.notify(res, vim.log.levels.ERROR, { title = 'NvimTree' })
            return
          end

          vim.fn.system { 'cp', '-R', file_src, file_out }
        end)
      end, opts 'Copy File To')

      vim.keymap.set('n', '<M-x>', function()
        local file_src = api.tree.get_node_under_cursor()['absolute_path']
        local input_opts = { prompt = 'Move to ', default = file_src, completion = 'file' }

        vim.ui.input(input_opts, function(file_out)
          local dir = vim.fn.fnamemodify(file_out, ':h')

          local res = vim.fn.system { 'mkdir', '-p', dir }
          if vim.v.shell_error ~= 0 then
            vim.notify(res, vim.log.levels.ERROR, { title = 'NvimTree' })
            return
          end

          vim.fn.system { 'mv', file_src, file_out }
        end)
      end, opts 'Move File To')
      vim.keymap.set('n', '<C-Space>', tree_actions_menu, { buffer = bufnr, noremap = true, silent = true })
    end,
  },
  config = function(_, opts)
    -- Recommended settings to disable default netrw file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.keymap.set('n', '<leader>tf', vim.cmd.NvimTreeFindFile)
    vim.keymap.set('n', '<leader>Pv', vim.cmd.NvimTreeFocus)
    local Snacks = require 'snacks'
    local prev = { new_name = '', old_name = '' } -- Prevents duplicate events
    vim.api.nvim_create_autocmd('User', {
      pattern = 'NvimTreeSetup',
      callback = function()
        local events = require('nvim-tree.api').events
        events.subscribe(events.Event.NodeRenamed, function(data)
          if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
            data = data
            Snacks.rename.on_rename_file(data.old_name, data.new_name)
          end
        end)
      end,
    })
    require('nvim-tree').setup(opts)
    local api = require 'nvim-tree.api'

    tree_actions = {
      {
        name = 'Create node',
        handler = api.fs.create,
      },
      {
        name = 'Remove node',
        handler = api.fs.remove,
      },
      {
        name = 'Trash node',
        handler = api.fs.trash,
      },
      {
        name = 'Rename node',
        handler = api.fs.rename,
      },
      {
        name = 'Move',
        handler = api.fs.rename_sub,
      },
      {
        name = 'Copy',
        handler = api.fs.copy.node,
      },
    }
    -- ... other custom actions you may want to display in the menu
  end,
}
