vim.g.mapleader = ' '

vim.opt.guicursor = ''

-- Buffer shiz
vim.opt.bufhidden = 'hide'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 2

-- vim.opt.smarttab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- turn on highlighting all matches
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.colorcolumn = '80'
vim.cmd[[colorscheme rose-pine]]

-- corrects weird changes when :w but you didn't change anything
-- literally just talking about weird end of line characters
vim.opt.fixeol = false
