return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    on_attach = function(bufnr)
      local gs = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      -- stylua: ignore start
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, { expr = true })

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true })

      -- Actions
      map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage hunk"})
      map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset hunk"})
      map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = "Stage selection"})
      map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = "Reset selection"})
      map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer"})
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Unstage hunk"})
      map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer"})
      map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk"})
      map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "Show git blame"})
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle current line blame"})
      map('n', '<leader>hd', gs.diffthis, { desc = "Show current buffer diff"})
      map('n', '<leader>hD', function() gs.diffthis '~' end, { desc = "Show diff against HEAD"})
      map('n', '<leader>td', gs.preview_hunk_inline, { desc = "Preview hunk inline" })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      vim.schedule(function() vim.opt.statusline = vim.opt.statusline end)
      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitSignsUpdate',
        callback = function() vim.opt.statusline = vim.opt.statusline end,
      })
      -- stylua: ignore end
    end,
  },
}
