-- Neovim configuration file
-- This is the main configuration file for Neovim

-- Set leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Basic settings
vim.opt.number = true                    -- Show line numbers
vim.opt.relativenumber = true            -- Show relative line numbers
vim.opt.expandtab = true                 -- Use spaces instead of tabs
vim.opt.tabstop = 4                      -- Number of spaces for tabs
vim.opt.softtabstop = 4                  -- Number of spaces for tab/bs
vim.opt.shiftwidth = 4                   -- Number of spaces for indentation
vim.opt.smartindent = true               -- Smart autoindenting
vim.opt.wrap = false                     -- Don't wrap lines
vim.opt.swapfile = false                 -- Disable swap files
vim.opt.backup = false                   -- Disable backup files
vim.opt.undofile = true                  -- Enable persistent undo
vim.opt.incsearch = true                 -- Highlight matches as you type
vim.opt.hlsearch = true                  -- Highlight search results
vim.opt.termguicolors = true             -- Enable true color support
vim.opt.signcolumn = "yes"               -- Always show sign column
vim.opt.updatetime = 300                 -- Faster completion
vim.opt.timeoutlen = 500                 -- Time to wait for mapped sequence
vim.opt.completeopt = "menuone,noinsert,noselect"  -- Completion options
vim.opt.showmode = false                 -- Don't show mode since we have lualine

-- Set default colorscheme
vim.cmd [[colorscheme default]]

-- Load plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugin configurations
require("lazy").setup("plugins")

-- Load key mappings
require("keymaps")
