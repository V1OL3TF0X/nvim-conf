-- instal lazy.nvim if not installed
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'setup.set'
require 'setup.utils'
require('lazy').setup('setup.plugins', {
  change_detection = {
    enabled = true,
    notify = false,
  },
})
require 'setup.remaps'

local yank_group = vim.__autocmd.augroup 'HighlightYank'

yank_group:on('TextYankPost', function()
  vim.highlight.on_yank {
    higroup = 'IncSearch',
    timeout = 40,
  }
end, {
  pattern = '*',
})

vim.cmd [[ autocmd BufRead,BufNewFile *.askama set filetype=htmldjango]]
vim.cmd [[ autocmd BufRead,BufNewFile *.jq set filetype=jq]]
vim.cmd [[ autocmd BufRead,BufNewFile *.html if search('{{.\+}}', 'nw') | setlocal filetype=gotmpl | endif ]]
