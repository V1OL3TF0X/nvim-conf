if vim.b.spelunker_enable_vim == 1 or vim.b.spelunker_enable_vim == nil then
  vim.fn['spelunker#toggle_buffer']()
end
