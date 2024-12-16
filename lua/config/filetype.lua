-- Correct priority for dockerfiles that end in an existing extension
-- this allows `dockerfile.<commonExt> to resolve as a dockerfile for syntax highlighting
vim.filetype.add({
  pattern = {
    ['Dockerfile%..*'] = { 'dockerfile', { priority = math.huge } }
  }
})

-- Enable fancy commenting for tsx
local get_option = vim.filetype.get_option
---@diagnostic disable-next-line: duplicate-set-field
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring"
    and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end

