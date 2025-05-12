return {
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
      automatic_enable = true,
    }
  },
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
      -- local mason_lspconfig = require("mason-lspconfig")
      -- for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
      --   vim.lsp.enable(server)
      -- end

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
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = true } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'buffer', 'path', 'snippets' },
      },
      signature = { enabled = true },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  }
  -- {
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-buffer',
  --     -- 'hrsh7th/cmp-path',
  --     --'hrsh7th/cmp-cmdline',
  --     -- Not sure that I need these ^
  --     -- Snippets
  --     'L3MON4D3/LuaSnip',
  --     'rafamadriz/friendly-snippets',
  --     'saadparwaiz1/cmp_luasnip',
  --     -- Format help (adds type and icon to dropdown)
  --     'onsails/lspkind.nvim'
  --   },
  --   lazy = true,
  --   event = 'InsertEnter',
  --   config = function()
  --     -- Setup completion
  --     local cmp = require('cmp')
  --     local lspkind = require('lspkind')
  --     local cmp_select = { behavior = cmp.SelectBehavior.Select }
  --
  --     cmp.setup({
  --       formatting = {
  --         format = lspkind.cmp_format({
  --           mode = 'symbol_text', -- show only symbol annotations
  --           maxwidth = {
  --             -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  --             -- can also be a function to dynamically calculate max width such as
  --             -- menu = function() return math.floor(0.45 * vim.o.columns) end,
  --             menu = 50,              -- leading text (labelDetails)
  --             abbr = 50,              -- actual suggestion item
  --           },
  --           ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
  --           show_labelDetails = true, -- show labelDetails in menu. Disabled by default
  --
  --           -- The function below will be called before any actual modifications from lspkind
  --           -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
  --           before = function(entry, vim_item)
  --             vim_item.menu = entry.source.name
  --             return vim_item
  --           end
  --         })
  --       },
  --       sources = {
  --         { name = 'nvim_lsp' },
  --         { name = 'buffer' }, -- cmp-buffer
  --         { name = 'luasnip' } -- cmp_luasnip
  --       },
  --       snippet = {
  --         expand = function(args)
  --           require('luasnip').lsp_expand(args.body)
  --         end,
  --       },
  --       mapping = cmp.maping.preset.insert({
  --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  --         ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  --         ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --       }),
  --     })
  --
  --     require('luasnip.loaders.from_vscode').lazy_load()
  --   end
  -- },
}
