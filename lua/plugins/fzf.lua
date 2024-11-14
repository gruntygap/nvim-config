return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local actions = require('fzf-lua.actions')
    require('fzf-lua').setup({
      grep = {
        actions = {
          -- this action toggles between 'grep' and 'live_grep'
          ["ctrl-g"] = { actions.grep_lgrep },
          -- uncomment to enable '.gitignore' toggle for grep
          ["ctrl-r"] = { actions.toggle_ignore },
          -- uncomment to enable '.gitignore' toggle for grep
          ["ctrl-h"] = { actions.toggle_hidden }
        }
      }
    })
    local fzf = require('fzf-lua')

    vim.keymap.set('n', '<leader>ss', fzf.grep) -- search
    -- Live grep whole project
    vim.keymap.set('n', '<leader>sg', fzf.live_grep)
    vim.keymap.set('n', '<leader>sgr', fzf.live_grep_resume)
    -- filenames
    vim.keymap.set('n', '<leader>sf', fzf.files)
    vim.keymap.set('n', '<leader>sb', fzf.buffers)
    -- lines in buffer(s)
    vim.keymap.set('n', '<leader>sbl', fzf.blines)
    vim.keymap.set('n', '<leader>sl', fzf.lines)
    -- tokens from treesitter
    vim.keymap.set('n', '<leader>st', fzf.treesitter)
    -- documentation
    vim.keymap.set('n', '<leader>sh', fzf.helptags)
    vim.keymap.set('n', '<leader>sm', fzf.manpages)
    -- theme selector
    vim.keymap.set('n', '<leader>st', fzf.colorschemes)
    -- look at keymaps
    vim.keymap.set('n', '<leader>sk', fzf.keymaps)
    -- history of search
    vim.keymap.set('n', '<leader>shh', fzf.search_history)
  end
}
