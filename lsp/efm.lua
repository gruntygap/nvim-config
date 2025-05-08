-- got most of this config from:
-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/efm/prettier.lua
local prettier = {
  formatCommand =
  [[$([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier") --stdin-filepath ${INPUT} ]],
  formatStdin = true,
}

local languages = {
  typescript = { prettier },
  typescriptreact = { prettier },
  javascript = { prettier },
  json = { prettier },
  jsonc = { prettier }
}

local opts = {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true
  },
}

---@type vim.lsp.Config
return opts

