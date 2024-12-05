return {
  -- LSP Server Management Application
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {}
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    -- init is called at startup
    init = function()
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        ---@diagnostic disable-next-line: unused-local
        callback = function(client, buf)
          local opts = { buffer = buf, remap = false }

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
          -- Ensure that ts_ls does not format. Stupid
          vim.keymap.set({ 'n', 'v' }, '<leader>vf',
            function() vim.lsp.buf.format({ filter = function(client) return client.name ~= 'ts_ls' end }) end, opts)

          vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
        end,
      })
    end
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      -- 'hrsh7th/cmp-path',
      -- Not sure that I need this ^
      'hrsh7th/cmp-cmdline',
      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
    },
    lazy = true,
    event = 'InsertEnter',
    config = function()
      -- Setup completion
      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = entry.source.name
            return vim_item
          end,
        },
        sources = {
          { name = 'buffer' }, -- cmp-buffer
          { name = 'nvim_lsp' },
          { name = 'luasnip' } -- cmp_luasnip
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
      })

      require('luasnip.loaders.from_vscode').lazy_load()
    end
  },
  -- LSP Server Configuration
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      local masonConfig = require('mason-lspconfig')
      local capabilities = vim.tbl_deep_extend(
        'force',
        require('lspconfig').util.default_config.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )
      masonConfig.setup({
        ensure_installed = { 'ts_ls', 'eslint', 'lua_ls', 'yamlls', 'jsonls' },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({ capabilities = capabilities })
          end,
          jsonls = function()
            local opts = {
              capabilities = capabilities,
              filetypes = { 'json', 'jsonc' },
              settings = {
                json = {
                  schemas = {
                    {
                      fileMatch = { "package.json" },
                      url = "https://json.schemastore.org/package.json"
                    },
                    {
                      fileMatch = { "tsconfig*.json" },
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
                      fileMatch = { ".eslintrc", ".eslintrc.json" },
                      url = "https://json.schemastore.org/eslintrc.json"
                    },
                    {
                      fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
                      url = "https://json.schemastore.org/babelrc.json"
                    },
                    {
                      fileMatch = { "lerna.json" },
                      url = "https://json.schemastore.org/lerna.json"
                    },
                    {
                      fileMatch = { "now.json", "vercel.json" },
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
            require('lspconfig').lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = {
                    version = 'LuaJIT'
                  },
                  diagnostics = {
                    globals = { 'vim' },
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      vim.env.VIMRUNTIME,
                      '~/.local/share/nvim/lazy'
                    }
                  }
                }
              }
            })
          end,
          efm = function()
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
              javascript = { prettier }
            }

            local opts = {
              capabilities = capabilities,
              filetypes = vim.tbl_keys(languages),
              settings = {
                rootMarkers = { '.git/' },
                languages = languages,
              },
              init_options = {
                documentFormatting = true
              },
            }

            require('lspconfig').efm.setup(opts)
          end,
        }
      })
    end
  }
}
