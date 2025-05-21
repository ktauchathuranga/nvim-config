-- C:\Users\Ashen Chathuranga\AppData\Local\nvim\lua\core\autocmds.lua
-- Autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General settings
local general = augroup('General', { clear = true })

-- Highlight on yank
autocmd('TextYankPost', {
  group = general,
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 150 }
  end,
})

-- Restore cursor position
autocmd('BufReadPost', {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-create directories on save
autocmd('BufWritePre', {
  group = general,
  callback = function(event)
    if event.match:match '^%w%w+://' then return end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Remove trailing whitespace
autocmd('BufWritePre', {
  group = general,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- Auto-reload files
autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = general,
  command = 'if mode() != "c" | checktime | endif',
})

-- Auto-resize windows
autocmd('VimResized', {
  group = general,
  command = 'tabdo wincmd =',
})

-- Filetype-specific settings
local filetype = augroup('FileTypeSettings', { clear = true })

-- Rust indentation
autocmd('FileType', {
  group = filetype,
  pattern = 'rust',
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})
