# Neovim Configuration

This is a modern Neovim configuration built from scratch with Lua. It includes:

## Features

- Plugin management with [lazy.nvim](https://github.com/folke/lazy.nvim)
- Syntax highlighting with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- File explorer with [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- Fuzzy finder with [telescope](https://github.com/nvim-telescope/telescope.nvim)
- Status line with [lualine](https://github.com/nvim-lualine/lualine.nvim)
- Icons with [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- Git integration with [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- Auto pairs with [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- Commenting with [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- Indent guides with [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)

## Key Mappings

### Insert Mode
- `jk`: Exit insert mode (acts as Esc)

### File Explorer
- `<C-n>`: Toggle NvimTree
- `<leader>e`: Focus NvimTree
- `<leader>cd`: Change NvimTree root to current file directory
- `<leader>cw`: Change NvimTree root to current working directory
- `C`: Change NvimTree root to selected directory (in tree)
- `U`: Change NvimTree root to parent directory (in tree)

### Fuzzy Finding (Telescope)
- `<leader>ff`: Find files
- `<leader>fg`: Live grep
- `<leader>fb`: Find buffers
- `<leader>fh`: Find help tags

### Window Management
- `<C-h/j/k/l>`: Navigate between windows
- `<C-Up/Down/Left/Right>`: Resize windows

### Buffer Navigation
- `<S-h/l>`: Previous/Next buffer

### Other
- `<leader>nh`: Clear search highlights
- `<leader>n`: Toggle line numbers
- `<leader>rn`: Toggle relative numbers
- `[d]/]d`: Navigate between diagnostics

## Installation

1. This configuration has been placed in `~/.config/nvim/`
2. On first launch, lazy.nvim will automatically install all plugins
3. You can update plugins later with `:Lazy` command

## Leader Key

The leader key is set to space (`<space>`).