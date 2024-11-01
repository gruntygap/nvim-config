return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v4.x',
  dependancies = {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'saadparwaiz1/cmp_luasnip',
    -- LSP Support
    'neovim/nvim-lspconfig',             -- Required
    'williamboman/mason.nvim',           -- Optional
    'williamboman/mason-lspconfig.nvim', -- Optional
    -- Snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
  },
  { 'neovim/nvim-lspconfig' },
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'williamboman/mason.nvim'},           -- Optional
  {'williamboman/mason-lspconfig.nvim'}, -- Optional
}
