return {
  'dmmulroy/tsc.nvim',
  dependencies = { "rcarriga/nvim-notify" },
  lazy = false,
  opts = function()
    vim.keymap.set('n', '<leader>tc', ':TSC');
    return { run_as_monorepo = true };
  end
}
