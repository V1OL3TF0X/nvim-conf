vim.opt.guicursor = ''
--emmet setup
vim.g.user_emmet_leader_key = '<C-e>'

-- encoding and stupff
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

--number settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.wrap = false

-- backup and undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = string.format("%s/undodoir", vim.fn.stdpath 'data')
vim.opt.undofile = true

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- tab settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- drawing
vim.opt.scrolloff = 12
vim.opt.signcolumn = 'yes'
vim.opt.cc = '80'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- font options
vim.g.have_nerd_font = true
vim.g.onedark_terminal_italics = 1
vim.g.airline_powerline_fonts = 1
vim.cmd('syntax on')
--undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.g.mapleader = " "
