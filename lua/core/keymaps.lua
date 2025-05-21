-- C:\Users\Ashen Chathuranga\AppData\Local\nvim\lua\core\keymaps.lua
-- Core Keymappings

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Clear search highlights
map('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Resize windows
map('n', '<C-Up>', ':resize -2<CR>', opts)
map('n', '<C-Down>', ':resize +2<CR>', opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Buffer navigation
map('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<leader>c', ':bdelete<CR>', { desc = 'Close buffer' })

-- Indenting in visual mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Move text in visual mode
map('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
map('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Paste without yanking
map('v', 'p', '"_dP', opts)

-- File operations
map('n', '<leader>w', ':w<CR>', { desc = 'Save' })
map('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
map('n', '<leader>Q', ':qa!<CR>', { desc = 'Force quit all' })

-- Splits
map('n', '<leader>\\', ':vsplit<CR>', { desc = 'Split vertically' })
map('n', '<leader>-', ':split<CR>', { desc = 'Split horizontally' })

-- Terminal
map('t', '<Esc>', '<C-\\><C-n>', opts)
map('n', '<leader>t', ':vsplit | terminal<CR>', { desc = 'Open terminal' })

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
map('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostic list' })

-- Rust-specific
map('n', '<leader>rr', ':!cargo run<CR>', { desc = 'Run Rust project' })
map('n', '<leader>rt', ':!cargo test<CR>', { desc = 'Run Rust tests' })
map('n', '<leader>rb', ':!cargo build<CR>', { desc = 'Build Rust project' })

-- Arduino-specific
map('n', '<leader>ac', ':!arduino-cli compile --fqbn arduino:avr:uno %<CR>', { desc = 'Compile Arduino sketch' })
map('n', '<leader>au', ':!arduino-cli upload -p COM3 --fqbn arduino:avr:uno %<CR>', { desc = 'Upload Arduino sketch' })

-- Toggles
map('n', '<leader>tn', ':set relativenumber!<CR>', { desc = 'Toggle relative numbers' })
map('n', '<leader>tw', ':set wrap!<CR>', { desc = 'Toggle line wrap' })
