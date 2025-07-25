return {
  {
    "navarasu/onedark.nvim",
    lazy = true,
    priority = 1000,
    -- config = function ()
    --   require('onedark').setup({ style = 'darker' })
    --   require('onedark').load()
    -- end
  },
  {
    "rose-pine/neovim",
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd('colorscheme rose-pine')
    end
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = true
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true
  },
  -- Sad themes that look like a buick
  ------------------------------------
  -- {
  --   'f4z3r/gruvbox-material.nvim',
  --   name = 'gruvbox-material',
  --   lazy = true,
  -- },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   lazy = true
  -- },
  -- {
  --   "ilof2/posterpole.nvim",
  --   lazy = true
  -- },
  -- {
  --   'franbach/miramare',
  --   lazy = true
  -- },
  {
    -- monokai replacement
    "sainnhe/sonokai",
    lazy = true
  },
  {
    "folke/tokyonight.nvim",
    name = 'tokyonight',
    lazy = true,
  }
}
