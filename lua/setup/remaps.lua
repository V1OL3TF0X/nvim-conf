-- navigation
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')
vim.keymap.set('n', '<C-h>', vim.cmd.bprev)
vim.keymap.set('n', '<C-l>', vim.cmd.bnext)

-- clipboard integration
vim.keymap.set('v', '<leader>p', '"_dP')
vim.keymap.set('v', '<leader>C', '"_d"+P')
vim.keymap.set({ 'v', 'n' }, '<leader>d', '"_d')
vim.keymap.set({ 'v', 'n' }, '<leader>c', '"_c')
vim.keymap.set({ 'v', 'n' }, '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('n', '<leader>Y', 'gg"+yG')
vim.keymap.set('i', '<C-S-V>', '"+pa')

-- moving around
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('v', 'J', [[:<C-u> execute "'<,'>m '>+".v:count1<CR>gv=gv]])
vim.keymap.set('v', 'K', [[:<C-u> execute "'<,'>m '<--".v:count1<CR>gv=gv]])
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')

-- replace current word
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- add execute to current file
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })
-- exit vertical insert mode with C-c
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<leader>lc', function()
  vim.cmd(string.format("e %s/lua/setup", vim.fn.stdpath 'config'))
end)
vim.keymap.set('n', '<leader><leader>', function() vim.cmd 'so' end)
