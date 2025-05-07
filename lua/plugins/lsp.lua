return {
  -- LSP
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    -- init is called at startup
    init = function()
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      local custom_configs = {
        efm = (function()
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

          return opts
        end)(),
        jsonls = {
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
        },
        lua_ls = {
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
            },
          },
        }
      }

      local capabilities = vim.tbl_deep_extend(
        'force',
        require('lspconfig').util.default_config.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
        local config = { capabilities = capabilities }

        if custom_configs[server] then
          for k, v in pairs(custom_configs[server]) do
            -- Shallow merge into config from custom_configs
            config[k] = v
          end
        end

        lspconfig[server].setup(config)
      end

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
            function() vim.lsp.buf.format({ filter = function(client) return (client.name ~= 'ts_ls' and client.name ~= 'jsonls') end }) end,
            opts)

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
      --'hrsh7th/cmp-cmdline',
      -- Not sure that I need these ^
      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
      -- Format help (adds type and icon to dropdown)
      'onsails/lspkind.nvim'
    },
    lazy = true,
    event = 'InsertEnter',
    config = function()
      -- Setup completion
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50,              -- leading text (labelDetails)
              abbr = 50,              -- actual suggestion item
            },
            ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              vim_item.menu = entry.source.name
              return vim_item
            end
          })
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' }, -- cmp-buffer
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
  -- LSP Server Management Application
  {
    'mason-org/mason.nvim',
    lazy = false,
    opts = {}
  },
  {
    'mason-org/mason-lspconfig.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      ensure_installed = { 'ts_ls', 'eslint', 'lua_ls', 'yamlls', 'jsonls' },
      automatic_enable = false
    }
  }
}
