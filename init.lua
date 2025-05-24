-- ~/.config/nvim/init.lua or ~/AppData/Local/nvim/init.lua
-- Standalone Neovim Configuration
-- Author: Ashen Chathuranga
-- Repository: https://github.com/ktauchathuranga/nvim-config

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load core configurations
require 'core.options'
require 'core.keymaps'
require 'core.autocmds'

-- Initialize plugins
require 'plugins'

-- Set colorscheme
vim.cmd.colorscheme 'tokyonight'

-- vim: ts=2 sts=2 sw=2 et
