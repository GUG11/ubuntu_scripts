-- Plugin configuration for lazy.nvim

return {


  -- Treesitter for syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'python', 'javascript', 'typescript', 'html', 'css' },
        auto_install = true,
        highlight = {
          enable = true,
        },
      }
    end
  },

  -- Lualine for status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '│', right = '│'},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {'alpha', 'dashboard'},
            winbar = {},
          },
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {
            { 'mode', 
              separator = { left = '', right = '' },
              color = { bg = '#6a92d7', fg = '#ffffff' }
            }
          },
          lualine_b = {
            { 'branch', 
              icon = '',
              separator = { left = '', right = '' },
              color = { bg = '#a7c0cd', fg = '#3a4d5d' }
            },
            { 'diff',
              symbols = { added = ' ', modified = '柳 ', removed = ' ' },
              diff_color = {
                added = { fg = '#98be65' },
                modified = { fg = '#c678dd' },
                removed = { fg = '#ec5f67' }
              }
            },
            { 'diagnostics', 
              sources = { 'nvim_diagnostic' },
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
              separator = { left = '', right = '' },
              color = {
                fg = '#ffffff',
                bg = '#282c34'
              },
              diagnostics_color = {
                error = { bg = '#ec5f67', fg = '#ffffff' },
                warn = { bg = '#f9ae58', fg = '#ffffff' },
                info = { bg = '#5fb3b3', fg = '#ffffff' },
                hint = { bg = '#6cc644', fg = '#ffffff' }
              }
            }
          },
          lualine_c = {
            { 'filename', 
              path = 1,
              symbols = { modified = ' ●', readonly = '  locked', unnamed = ' [No Name]' },
              separator = { left = '', right = '' },
              color = { bg = '#282c34', fg = '#f3f3f3' }
            }
          },
          lualine_x = {
            { 'encoding', 
              color = { fg = '#d19a66' }
            },
            { 'fileformat', 
              symbols = {
                unix = '_UNIX',
                dos = '_WIN',
                mac = '_MAC',
              },
              color = { fg = '#abb2bf' }
            },
            { 'filetype', 
              colored = true,
              icon_only = false,
              color = { fg = '#fabd2f' }
            }
          },
          lualine_y = {
            { 'progress', 
              separator = { left = '', right = '' },
              color = { bg = '#458588', fg = '#ebdbb2' }
            }
          },
          lualine_z = {
            { 'location',
              separator = { left = '', right = '' },
              color = { bg = '#cc241d', fg = '#ffffff' }
            }
          }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {{'filename', color = { fg = '#a8a8a8' }}},
          lualine_x = {{'location', color = { fg = '#a8a8a8' }}},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },

  -- Telescope for fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {}
      require('telescope').load_extension('fzf')
    end
  },

  -- Nvim-tree for file explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        filters = {
          dotfiles = false,
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        actions = {
          open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
              enable = false,
            }
          }
        },
        hijack_directories = {
          enable = true,
          auto_open = true,
        },
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')
          
          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- Default mappings
          api.config.mappings.default_on_attach(bufnr)
          
          -- Additional mappings for changing directory
          vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
          vim.keymap.set('n', 'U', api.tree.change_root_to_parent, opts('CD up'))
        end,
      }
    end
  },

  -- Which-key for keybinding documentation
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- Comment plugin for easy commenting
  {
    'numToStr/Comment.nvim',
    opts = {
      toggler = {
        line = '<leader>cc',
        block = '<leader>cb',
      },
      opleader = {
        line = '<leader>c',
        block = '<leader>b',
      },
    },
    lazy = false,
  },

  -- Git signs in the gutter
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Auto pairs for brackets and quotes
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      disable_filetype = { 'TelescopePrompt', 'vim' },
    }
  },

  -- Indent blankline for visual indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
}