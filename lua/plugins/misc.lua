return {
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
  },
  {
    'iamcco/markdown-preview.nvim',
    lazy = true,
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    config = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    opt = { enable_autocmd = false }
  },
  {
    "eandrju/cellular-automaton.nvim",
    cmd = { "CellularAutomaton" },
    lazy = true
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {}
  }
}
