return {
  {
    'echasnovski/mini.surround',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {}
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  }
  -- {
  --   'echasnovski/mini.pairs',
  --   lazy = true,
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   opts = {}
  -- }
}
