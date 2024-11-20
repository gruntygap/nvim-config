return {
  { 'goolord/alpha-nvim',
    config = function ()
      require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  },
  {
    "folke/zen-mode.nvim"
  }
}
