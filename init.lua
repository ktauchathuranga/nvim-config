-- C:\Users\Ashen Chathuranga\AppData\Local\nvim\init.lua
-- Professional Neovim Configuration
-- Author: Ashen Chathuranga
-- Based on kickstart.nvim

-- Set leader keys before plugins
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
