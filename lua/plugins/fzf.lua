return {
  {
    "ibhagwan/fzf-lua",
    config = function()
      local actions = require('fzf-lua.actions')
      local toggled = false

      -- function to toggle exclusion of .git
      local dotgit = function(_, opts)
        local flag = '--exclude .git'

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
          actions = {
            ["ctrl-g"] = { actions.toggle_ignore },
            ["ctrl-t"] = { fn = dotgit, header = dotGitHeader },
            ["ctrl-h"] = { actions.toggle_hidden }
          }
        }
      })
      -- setup keymaps
      vim.keymap.set('n', '<leader>ss', fzf.grep)              -- search
      -- Live grep whole project
      vim.keymap.set('n', '<leader>sg', fzf.live_grep)         -- search grep (or global)
      vim.keymap.set('n', '<leader>sgg', fzf.live_grep_glob)   -- search grep (or global)
      vim.keymap.set('n', '<leader>sgr', fzf.live_grep_resume) -- search grep resume
      -- filenames
      vim.keymap.set('n', '<leader>sf', fzf.files)
      vim.keymap.set('n', '<leader>sb', fzf.buffers)
      -- lines in buffer(s)
      -- vim.keymap.set('n', '<leader>sbl', fzf.blines) # Pointless, just use /
      vim.keymap.set('n', '<leader>sl', fzf.lines)       -- this does what you think, look through the lines of all buffers
      -- tokens from treesitter
      vim.keymap.set('n', '<leader>str', fzf.treesitter) -- current buffer only :(
      -- documentation
      vim.keymap.set('n', '<leader>sh', fzf.helptags)
      vim.keymap.set('n', '<leader>sm', fzf.manpages)
      -- theme selectob
      vim.keymap.set('n', '<leader>st', fzf.colorschemes)
      -- look at keymaps
      vim.keymap.set('n', '<leader>sk', fzf.keymaps)
      -- history of search
      vim.keymap.set('n', '<leader>shh', fzf.search_history)
    end
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true
  }
}
