-- Key mappings for Neovim

local keymap = vim.keymap

-- Map jk to esc in insert mode
keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode with jk' })

-- NvimTree
keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { desc = 'Focus NvimTree' })

-- Functions to change nvim-tree root directory
local function change_nvim_tree_to_current_file_dir()
  local api = require('nvim-tree.api')
  local Path = require('nvim-tree.path')
  
  -- Get the current file path
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    print('No file opened')
    return
  end
  
  -- Get the directory of the current file
  local current_dir = Path.dirname(current_file)
  
  -- Change the tree root to the current file's directory
  api.tree.change_root_to_path(current_dir)
end

local function change_nvim_tree_to_cwd()
  local api = require('nvim-tree.api')
  
  -- Change the tree root to the current working directory
  api.tree.change_root_to_path(vim.fn.getcwd())
end

-- Add keymaps for changing root directory
keymap.set('n', '<leader>cd', change_nvim_tree_to_current_file_dir, { desc = 'Change NvimTree root to current file directory' })
keymap.set('n', '<leader>cw', change_nvim_tree_to_cwd, { desc = 'Change NvimTree root to current working directory' })

-- Telescope
keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Find help tags' })

-- Better window navigation
keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Resize windows
keymap.set('n', '<C-Up>', ':resize -2<CR>', { desc = 'Resize window smaller' })
keymap.set('n', '<C-Down>', ':resize +2<CR>', { desc = 'Resize window bigger' })
keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Resize vertical window smaller' })
keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Resize vertical window bigger' })

-- Navigate buffers
keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- Clear search highlights
keymap.set('n', '<leader>nh', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Better paste
keymap.set('v', 'p', '"_dP', { desc = 'Paste without yanking' })

-- Toggle numbers
keymap.set('n', '<leader>n', ':set number!<CR>', { desc = 'Toggle line numbers' })
keymap.set('n', '<leader>rn', ':set relativenumber!<CR>', { desc = 'Toggle relative numbers' })

-- Diagnostic keymaps
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic in float' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Show diagnostics in location list' })