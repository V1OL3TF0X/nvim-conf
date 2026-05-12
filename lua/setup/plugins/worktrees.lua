local function change_path(path, from, to)
  local Path = require 'plenary.path'
  local buf_path = Path:new(path)
  local rel_path = buf_path:make_relative(from)
  return Path:new(to .. '/' .. rel_path), buf_path
end
return {
  'Juksuu/worktrees.nvim',
  dependencies = { 'plenary.nvim' },
  opts = {
    switch_file_command = 'Oil',
    swap_current_buffer = false,
    hooks = {
      on_switch = function(from, to)
        local any_exist = false
        for win in vim.iter(vim.api.nvim_list_tabpages()):map(vim.api.nvim_tabpage_list_wins):flatten() do
          local bufnr = vim.api.nvim_win_get_buf(win)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local is_oil = fname:match '^oil://'
          if is_oil then
            fname = fname:sub(7)
          end
          local path_in_new_cwd, buf_path = change_path(fname, from, to)
          if not buf_path:exists() then
            goto continue
          end
          if path_in_new_cwd:exists() then
            any_exist = true
            vim.schedule(function()
              local new_path = path_in_new_cwd:absolute()
              if is_oil then
                new_path = 'oil://' .. new_path
              end
              local buf_in_new_cwd = vim.fn.bufnr(new_path, true)
              vim.api.nvim_win_set_buf(win, buf_in_new_cwd)
              vim.api.nvim_buf_delete(bufnr, {})
            end)
          else
            vim.api.nvim_win_close(win, true)
          end
          if not any_exist then
            local root = vim.fn.bufnr('oil://' .. to)
            vim.api.nvim_set_current_buf(root)
          end
          ::continue::
        end
      end,
    },
  },
  keys = {
    {
      '<leader>ws',
      function()
        Snacks.picker.worktrees()
      end,
    },
  },
}
