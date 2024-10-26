
-- COMPLETION SETUP
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format({details = true})
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
        {name = 'buffer'}, -- cmp-buffer
        {name = 'luasnip'} -- cmp_luasnip
    },
    -- optional: show source name
    formatting = cmp_format,
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

-- LSP ZERO, MY HERO
local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '<leader>vl', function() vim.diagnostic.setqflist() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)

    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end

lsp_zero.extend_lspconfig({
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    lsp_attach = lsp_attach,
    float_border = 'rounded',
    sign_text = true,
})

-- MASON: LSP SERVERS
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'ts_ls', 'eslint', 'lua_ls', 'yamlls', 'jsonls'},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        jsonls = function ()
            local opts = {
                filetypes = { 'json', 'jsonc' },
                settings = {
                    json = {
                        schemas = {
                            {
                                fileMatch = {"package.json"},
                                url = "https://json.schemastore.org/package.json"
                            },
                            {
                                fileMatch = {"tsconfig*.json"},
                                url = "https://json.schemastore.org/tsconfig.json"
                            },
                            {
                                fileMatch = {
                                    ".prettierrc",
                                    ".prettierrc.json",
                                    "prettier.config.json"
                                },
                                url = "https://json.schemastore.org/prettierrc.json"
                            },
                            {
                                fileMatch = {".eslintrc", ".eslintrc.json"},
                                url = "https://json.schemastore.org/eslintrc.json"
                            },
                            {
                                fileMatch = {".babelrc", ".babelrc.json", "babel.config.json"},
                                url = "https://json.schemastore.org/babelrc.json"
                            },
                            {
                                fileMatch = {"lerna.json"},
                                url = "https://json.schemastore.org/lerna.json"
                            },
                            {
                                fileMatch = {"now.json", "vercel.json"},
                                url = "https://json.schemastore.org/now.json"
                            },
                            {
                                fileMatch = {
                                    ".stylelintrc",
                                    ".stylelintrc.json",
                                    "stylelint.config.json"
                                },
                                url = "http://json.schemastore.org/stylelintrc.json"
                            }
                        }
                    }
                }
            }
            require('lspconfig').jsonls.setup(opts)
        end,
        lua_ls = function()
            -- Ensure that nvim lsp recognizes the vim global object
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

-- not sure what this does
vim.diagnostic.config({
    virtual_text = {
      source = true
  }
})

