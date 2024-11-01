return {
  { 'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  { 'goolord/alpha-nvim',
    opts = require'alpha.themes.dashboard'.config
  },
  { 'folke/zen-mode.nvim' }
}
