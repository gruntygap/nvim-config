-- native vim binding remapper
-- Typically will not include plugin bindings, look to /after for those
vim.g.mapleader = ' ';

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')

vim.keymap.set('n', '<leader>w', '<cmd>bd<cr>', { silent = true })
