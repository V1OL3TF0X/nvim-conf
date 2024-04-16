vim.opt.guicursor = ''
--emmet setup
vim.g.user_emmet_leader_key = '<C-e>'

-- encoding and stupff
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.termencoding = 'utf-8'

--number settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.wrap = false

-- backup and undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = string.format("%s-data\\undodoir", vim.fn.stdpath 'config')
vim.opt.undofile = true

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- drawing
vim.opt.scrolloff = 12
vim.opt.signcolumn = 'yes'
vim.opt.cc = '80'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.cmd [[
augroup myterm | au!
    au TermOpen * if &buftype ==# 'terminal' | resize 10 | endif
augroup end
]]
--terminal
vim.g.neomux_winswap_map_prefix = '<leader>ws'
vim.cmd [[
let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
set shellquote= shellxquote=
]]
-- font options
vim.g.have_nerd_font = true
vim.g.onedark_terminal_italics = 1
vim.g.airline_powerline_fonts = 1
vim.cmd('syntax on')

-- theeme opts
vim.g.airline_extensions = { 'hunks', 'branch' }
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#branch#enabled'] = 1
vim.g['airline#extensions#hunks#enabled'] = 1

vim.g.mapleader = " "
