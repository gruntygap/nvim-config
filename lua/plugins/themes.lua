return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      require('onedark').setup({ style = 'darker' })
      require('onedark').load()
    end
  },
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
    'franbach/miramare',
    lazy = true
  },
  {
    'sainnhe/everforest',
    lazy = true
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true
  },
  {
    'f4z3r/gruvbox-material.nvim',
    name = 'gruvbox-material',
    lazy = true,
  },
  {
    "ilof2/posterpole.nvim",
    lazy = true
  },
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
