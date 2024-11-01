return {
  { "ellisonleao/gruvbox.nvim" },
  { "rose-pine/neovim", name = 'rose-pine' },
  { "Mofiqul/dracula.nvim" },
  { "ilof2/posterpole.nvim",
    priority=1000,
    config = function ()
      require("posterpole").setup({
        -- config here
      })
      -- vim.cmd("colorscheme posterpole")

      -- if you need colorscheme without termguicolors support
      -- This variant set termguicolors to false, be aware of using it
      -- vim.cmd("colorscheme posterpole-term")
    end
  }
}
