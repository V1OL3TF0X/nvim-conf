vim.__autocmd.on({ 'BufWritePost', 'BufEnter' }, function()
  if vim.bo.filetype ~= 'yaml' then
    return
  end

  require('lint').try_lint 'yamllint'
end)
return {
  'mfussenegger/nvim-lint',
  event = { 'BufWritePost', 'BufEnter' },
  config = function() end,
}
