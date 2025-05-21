-- C:\Users\Ashen Chathuranga\AppData\Local\nvim\lua\core\options.lua
-- Core Neovim Options

local opt = vim.opt
local g = vim.g

-- Leader key (set in init.lua for consistency)
g.mapleader = ' '
g.maplocalleader = ' '

-- UI options
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.showmode = false
opt.signcolumn = 'yes'
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cmdheight = 1
opt.pumheight = 10
opt.laststatus = 3
opt.showtabline = 2
opt.title = true
opt.colorcolumn = '80'
opt.hlsearch = true
opt.incsearch = true

-- Behavior options
opt.clipboard = 'unnamedplus'
opt.mouse = 'a'
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = 'menu,menuone,noselect'
opt.updatetime = 100
opt.timeoutlen = 300
opt.splitbelow = true
opt.splitright = true
opt.hidden = true
opt.wrap = false
opt.backup = false
opt.swapfile = false
opt.confirm = true

-- Indentation options
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.breakindent = true

-- Search and pattern matching
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.path:append '**'
opt.wildignore:append '*/node_modules/*'

-- Display options
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', eol = '↴', extends = '❯', precedes = '❮' }

-- Fold options
opt.foldlevel = 99
opt.foldmethod = 'indent'

-- Disable unnecessary built-in plugins
local disabled_built_ins = { 'gzip', 'matchit', 'matchparen', 'netrwPlugin', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin' }
for _, plugin in pairs(disabled_built_ins) do
  g['loaded_' .. plugin] = 1
end
