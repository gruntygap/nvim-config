return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true
  },
  {
    "rose-pine/neovim",
    name = 'rose-pine',
    lazy = true
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = true
  },
  {
    "ilof2/posterpole.nvim",
    priority=1000,
    config = function ()
      require("posterpole").setup({})
      vim.cmd("colorscheme posterpole")

      -- if you need colorscheme without termguicolors support
      -- This variant set termguicolors to false, be aware of using it
      -- vim.cmd("colorscheme posterpole-term")
    end
  }
}
