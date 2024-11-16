return {
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
  },
  {
    'iamcco/markdown-preview.nvim',
    config = function() vim.fn["mkdp#util#install"]() end,
  },
  "eandrju/cellular-automaton.nvim",
  'tpope/vim-commentary' -- gc? .. comments baby
}
