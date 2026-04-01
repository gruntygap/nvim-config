return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>ss", function() require('fzf-lua').grep() end, desc = "Search" },
      { "<leader>sg", function() require('fzf-lua').live_grep() end, desc = "Search grep" },
      { "<leader>sgg", function() require('fzf-lua').live_grep_glob() end, desc = "Search grep glob" },
      { "<leader>sgr", function() require('fzf-lua').live_grep_resume() end, desc = "Search grep resume" },
      { "<leader>sf", function() require('fzf-lua').files() end, desc = "Search files" },
      { "<leader>sb", function() require('fzf-lua').buffers() end, desc = "Search buffers" },
      { "<leader>sl", function() require('fzf-lua').lines() end, desc = "Search lines" },
      { "<leader>str", function() require('fzf-lua').treesitter() end, desc = "Search treesitter" },
      { "<leader>sh", function() require('fzf-lua').helptags() end, desc = "Search help" },
      { "<leader>sm", function() require('fzf-lua').manpages() end, desc = "Search manpages" },
      { "<leader>st", function() require('fzf-lua').colorschemes() end, desc = "Search themes" },
      { "<leader>sk", function() require('fzf-lua').keymaps() end, desc = "Search keymaps" },
      { "<leader>shh", function() require('fzf-lua').search_history() end, desc = "Search history" },
    },
    config = function()
      local actions = require('fzf-lua.actions')
      local toggled = false

      -- function to toggle exclusion of .git
      local dotgit = function(_, opts)
        local flag = '--ignore-exclude .git'

        toggled = not toggled
        actions.toggle_flag(_, vim.tbl_extend("force", opts, { toggle_flag = flag }))
      end

      -- func for search header change
      local dotGitHeader = function()
        if toggled then
          return "exclude .git"
        else
          return "include .git"
        end
      end

      local fzf = require('fzf-lua')
      --  configure
      fzf.setup({
        winopts = {
          preview = {
            layout = "vertical"
          }
        },
        grep = {
          actions = {
            -- this action toggles between 'grep' and 'live_grep'
            ["ctrl-r"] = { actions.grep_lgrep },
            -- uncomment to enable '.gitignore' toggle for grep
            ["ctrl-g"] = { actions.toggle_ignore },
            -- uncomment to enable '.gitignore' toggle for grep
            ["ctrl-h"] = { actions.toggle_hidden }
          }
        },
        files = {
          -- cmd = "rg --files --color=never",
          actions = {
            ["ctrl-g"] = { actions.toggle_ignore },
            ["ctrl-t"] = { fn = dotgit, header = dotGitHeader },
            ["ctrl-h"] = { actions.toggle_hidden }
          }
        }
      })
    end
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true
  }
}
