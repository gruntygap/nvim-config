vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')

-- Windows/Buffers
-- vim.keymap.set('n', '<leader>q', vim.cmd.bdelete, { silent = true }) -- close window, buffer deleted
-- vim.keymap.set('n', '<leader>w', vim.cmd.close, { silent = true }) -- close window, buffer remains
vim.keymap.set('n', '<leader>q', vim.cmd.bdelete, { }) -- close window, buffer deleted
vim.keymap.set('n', '<leader>w', vim.cmd.close, { }) -- close window, buffer remains

-- Tabpages
vim.keymap.set('n', '<leader>tn', vim.cmd.tabnew) -- new tab

--  Use `:tc(d) {path}` to change directories within vim tabs
--  not very helpful, use gt and gT
-- vim.keymap.set('n', '<C-S-PageDown>', vim.cmd.tabprevious, { silent = true }) -- previous tab
-- vim.keymap.set('n', '<C-S-PageUp>', vim.cmd.tabnext, { silent = true }) -- next tab
