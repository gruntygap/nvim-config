return {
  {
    'windwp/windline.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('wlsample.vscode')
    end
  }
}
--   {
--   'nvim-lualine/lualine.nvim',
--   dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
--   config = function()
--     -- Just a weird status line object that takes the mediocre line from fugitive, and makes it nicer to look at.
--     function Custom_fugitive_status()
--       local custom_out = ''
--       local fug_stat_line = vim.fn['fugitive#Statusline']()
--       if (fug_stat_line == nil or fug_stat_line == '') then
--         return custom_out
--       end
--       custom_out = fug_stat_line:sub(2, -2) -- trim off [] around Statusline
--       if (custom_out:find(':')) then
--         custom_out = custom_out:sub(5)     -- trim off Git: from front of string
--       else
--         custom_out = custom_out:sub(4)     -- trim off Git from front of string
--         custom_out = custom_out:sub(2, -2) -- trim off ()
--       end
--       return ' ' .. custom_out
--     end
--
--     require('lualine').setup {
--       options = {
--         component_separators = '',
--         section_separators = { left = '', right = '' },
--       },
--       sections = {
--         lualine_a = {
--           {
--             'mode',
--             separator = { left = '' },
--             right_padding = 2
--           }
--         },
--         lualine_b = {
--           {
--             'filename',
--             file_status = true,
--             path = 1,
--             shorting_target = 150
--           },
--           'Custom_fugitive_status()'
--         },
--         lualine_c = {
--           '%=' -- this thing centers what is next?
--         },
--         lualine_x = { 'searchcount' },
--         lualine_y = { 'filetype', 'encoding', 'progress', },
--         lualine_z = {
--           { 'location', separator = { right = '' }, left_padding = 2 },
--         },
--       },
--       inactive_sections = {
--         lualine_a = {
--           {
--             'filename',
--             file_status = true,
--             path = 1,
--             shorting_target = 50
--           }
--         },
--         lualine_b = {},
--         lualine_c = {},
--         lualine_x = {},
--         lualine_y = {},
--         lualine_z = { 'location' },
--       },
--       tabline = {},
--       extensions = {},
--     }
--   end
-- }
