return {
  {
    "folke/zen-mode.nvim"
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPre', 'BufNewFile' },
    lazy = true,
    ---@module 'ibl'
    ---@type ibl.config
    opts = {}
  }
}
