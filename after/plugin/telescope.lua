require("telescope").setup({
    pickers = {
        colorscheme = {
            enable_preview = true,
        }
    }
})

local builtin = require('telescope.builtin')

-- Reasonable defaults
vim.keymap.set('n', '<leader>fa', function() builtin.find_files({no_ignore = true}) end, {})
vim.keymap.set('n', '<leader>ff', function() builtin.find_files() end, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fhh', function() builtin.find_files({hidden = true, no_ignore = true}) end, {})

-- Grep in progress
vim.keymap.set('n', '<leader>fss', builtin.live_grep, {})

-- Grep once, and scroll through
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- Vanity
vim.keymap.set('n', '<leader>ft', builtin.colorscheme, {})
