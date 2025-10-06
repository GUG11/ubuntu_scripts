-- Completion plugins configuration

return {
  -- Completion framework
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end
  },

  -- Snippet engine
  {
    'L3MON4D3/LuaSnip',
    build = (not jit.os:find('Windows'))
        and 'echo -e "\\n\\033[31;1mMake sure to checkout the latest tag (v2.3.0)!\\033[0m" || true'
        or nil,
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      local luasnip = require('luasnip')
      luasnip.config.setup({})
      require('luasnip.loaders.from_vscode').lazy_load()
    end
  },

  -- LSP Configuration & Management
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')

      -- Setup mason-lspconfig
      mason_lspconfig.setup({
        ensure_installed = {
          'lua_ls',
          'pylsp',      -- Python
          'pyright',    -- Better Python support
          'clangd',     -- C/C++
          'tsserver',
          'eslint',
          'html',
          'cssls',
        }
      })

      -- Setup default LSP keymaps
      local on_attach = function(client, bufnr)
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, bufopts)
      end

      -- Setup default capabilities with completion support
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Setup LSP servers
      local servers = {
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        -- Python LSP configuration
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                mccabe = { enabled = false },
                pydocstyle = { enabled = false },
                flake8 = { enabled = false },
                jedi_completion = { include_params = true },
                jedi = {
                  environment = vim.fn.expand("$CONDA_DEFAULT_ENV") ~= "" and vim.fn.expand("$CONDA_DEFAULT_ENV") or nil
                },
              }
            }
          }
        },
        -- Better Python LSP
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
              }
            }
          }
        },
        -- C/C++ LSP configuration
        clangd = {
          capabilities = capabilities,
          cmd = {
            'clangd',
            '--background-index',
            '--completion-style=detailed',
            '--target=x86_64-unknown-linux-gnu',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--folding-ranges',
          },
        },
      }

      for lsp, config in pairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = config,
        }
      end
    end
  },

  -- Mason for LSP/DAP/Formatter management
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end
  },
}