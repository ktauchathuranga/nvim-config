-- ================================
-- PROFESSIONAL NEOVIM CONFIGURATION
-- ================================
-- Optimized for C, Python, Java, Rust development
-- No third-party plugins - pure Neovim functionality

-- ================================
-- CORE SETTINGS
-- ================================

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.numberwidth = 6  -- Increased from 4 to 6 for larger files
vim.opt.signcolumn = "auto"  -- Only show sign column when needed
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmode = false

-- File handling
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo")
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.cindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Completion
vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.pumheight = 10

-- Visual
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Performance
vim.opt.lazyredraw = true
vim.opt.regexpengine = 1

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldenable = false

-- Mouse and clipboard
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- Status line
vim.opt.laststatus = 2
vim.opt.statusline = "%f %m %r%h%w%=%l,%c %p%%"

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = {"longest:full", "full"}

-- Create undo directory if it doesn't exist
local undo_dir = vim.fn.expand("~/.config/nvim/undo")
if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p")
end

-- ================================
-- LANGUAGE-SPECIFIC SETTINGS
-- ================================

-- C/C++ settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"c", "cpp", "h", "hpp"},
    callback = function()
        vim.opt_local.cindent = true
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
        vim.opt_local.textwidth = 80
        vim.opt_local.colorcolumn = "80"
        -- Enable semantic highlighting
        vim.opt_local.syntax = "on"
    end,
})

-- Python settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
        vim.opt_local.textwidth = 79
        vim.opt_local.colorcolumn = "79"
        vim.opt_local.autoindent = true
        vim.opt_local.smartindent = false  -- Python has its own indentation logic
    end,
})

-- Java settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
        vim.opt_local.textwidth = 120
        vim.opt_local.colorcolumn = "120"
    end,
})

-- Rust settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
        vim.opt_local.textwidth = 100
        vim.opt_local.colorcolumn = "100"
    end,
})

-- ================================
-- KEY MAPPINGS - GENERAL
-- ================================

-- Better escape
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true })

-- Clear search highlight
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { noremap = true, silent = true })

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Window resizing
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bl', ':buffers<CR>', { noremap = true, silent = true })

-- Tab navigation
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tm', ':tabmove<CR>', { noremap = true, silent = true })

-- File operations
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>x', ':x<CR>', { noremap = true, silent = true })

-- Better indenting
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- Move text up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Keep cursor centered when jumping
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'J', 'mzJ`z', { noremap = true, silent = true })

-- Quick fix list
vim.keymap.set('n', '<leader>co', ':copen<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cc', ':cclose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cn', ':cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cp', ':cprevious<CR>', { noremap = true, silent = true })

-- Toggle relative line numbers
vim.keymap.set('n', '<leader>ln', function()
    vim.opt.relativenumber = not vim.opt.relativenumber
    print("Relative numbers " .. (vim.opt.relativenumber:get() and "enabled" or "disabled"))
end, { noremap = true, silent = false, desc = "Toggle relative line numbers" })

-- ================================
-- DEVELOPMENT KEY MAPPINGS
-- ================================

-- C/C++ keybindings
vim.keymap.set('n', '<leader>cc', function() compile_c_cpp() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cr', function() run_c_cpp() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cd', function() debug_c_cpp() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cm', function() make_project() end, { noremap = true, silent = true })

-- Python keybindings
vim.keymap.set('n', '<leader>pr', function() run_python() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pt', function() test_python() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pl', function() lint_python() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pf', function() format_python() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pi', function() python_interactive() end, { noremap = true, silent = true })

-- Java keybindings
vim.keymap.set('n', '<leader>jc', ':cd %:p:h | !javac %<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>jr', ':cd %:p:h | !java -cp . %:r<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>jf', ':setfiletype java<CR>', { noremap = true, silent = true })

-- Rust keybindings
vim.keymap.set('n', '<leader>rc', ':cd %:p:h | !rustc % -o %:r && ./%:r<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rb', ':cd %:p:h | !cargo build<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rr', ':cd %:p:h | !cargo run<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rt', ':cd %:p:h | !cargo test<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rf', ':setfiletype rust<CR>', { noremap = true, silent = true })

-- Git keybindings
vim.keymap.set('n', '<leader>ga', function() git_add() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gc', function() git_commit() end, { noremap = true, silent = false })
vim.keymap.set('n', '<leader>gp', function() smart_git_push() end, { noremap = true, silent = false })
vim.keymap.set('n', '<leader>gpl', function() smart_git_pull() end, { noremap = true, silent = false })
vim.keymap.set('n', '<leader>gs', function() git_status() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gd', function() git_diff() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gl', function() git_log() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gb', function() git_branch() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gi', function() git_init() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gv', function() git_remote() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gr', function() add_git_remote() end, { noremap = true, silent = true })

-- ================================
-- UTILITY FUNCTIONS
-- ================================

-- Enhanced error handling and output display
local function execute_command(cmd, success_msg, error_msg)
    local output = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error
    
    if exit_code == 0 then
        if success_msg then
            print(success_msg .. (output ~= "" and ": " .. vim.trim(output) or ""))
        end
        return true, output
    else
        if error_msg then
            print(error_msg .. (output ~= "" and ": " .. vim.trim(output) or ""))
        end
        return false, output
    end
end

-- File existence check
local function file_exists(path)
    return vim.fn.filereadable(path) == 1
end

-- Directory existence check
local function dir_exists(path)
    return vim.fn.isdirectory(path) == 1
end

-- Get file extension
local function get_file_extension()
    return vim.fn.expand("%:e")
end

-- Get filename without extension
local function get_filename_without_ext()
    return vim.fn.expand("%:r")
end

-- ================================
-- C/C++ DEVELOPMENT FUNCTIONS
-- ================================

function compile_c_cpp()
    local file = vim.fn.expand("%")
    local filename = get_filename_without_ext()
    local ext = get_file_extension()
    
    if not file or file == "" then
        print("No file to compile")
        return
    end
    
    local compiler = (ext == "cpp" or ext == "cxx" or ext == "cc") and "g++" or "gcc"
    local flags = "-Wall -Wextra -std=" .. (compiler == "g++" and "c++17" or "c11") .. " -g"
    local cmd = string.format("cd %s && %s %s %s -o %s", 
                             vim.fn.shellescape(vim.fn.expand("%:p:h")),
                             compiler, flags, vim.fn.shellescape(file), vim.fn.shellescape(filename))
    
    execute_command(cmd, "Compilation successful", "Compilation failed")
end

function run_c_cpp()
    local filename = get_filename_without_ext()
    local executable = "./" .. filename
    
    if not file_exists(filename) then
        print("Executable not found. Compile first with <leader>cc")
        return
    end
    
    local cmd = string.format("cd %s && %s", vim.fn.shellescape(vim.fn.expand("%:p:h")), executable)
    vim.fn.system(cmd)
end

function debug_c_cpp()
    local filename = get_filename_without_ext()
    
    if not file_exists(filename) then
        print("Executable not found. Compile first with <leader>cc")
        return
    end
    
    local cmd = string.format("cd %s && gdb ./%s", vim.fn.shellescape(vim.fn.expand("%:p:h")), filename)
    vim.cmd("terminal " .. cmd)
end

function make_project()
    if file_exists("Makefile") or file_exists("makefile") then
        execute_command("make", "Make successful", "Make failed")
    else
        print("No Makefile found in current directory")
    end
end

-- ================================
-- PYTHON DEVELOPMENT FUNCTIONS
-- ================================

function run_python()
    local file = vim.fn.expand("%")
    if not file or file == "" then
        print("No Python file to run")
        return
    end
    
    local cmd = string.format("cd %s && python3 %s", 
                             vim.fn.shellescape(vim.fn.expand("%:p:h")), 
                             vim.fn.shellescape(file))
    vim.fn.system(cmd)
end

function test_python()
    local current_dir = vim.fn.expand("%:p:h")
    
    -- Check for different test frameworks
    if file_exists("pytest.ini") or dir_exists("tests") then
        execute_command("cd " .. vim.fn.shellescape(current_dir) .. " && python3 -m pytest", 
                       "Tests passed", "Tests failed")
    elseif vim.fn.glob("test_*.py") ~= "" or vim.fn.glob("*_test.py") ~= "" then
        execute_command("cd " .. vim.fn.shellescape(current_dir) .. " && python3 -m unittest discover", 
                       "Tests passed", "Tests failed")
    else
        print("No test files found")
    end
end

function lint_python()
    local file = vim.fn.expand("%")
    if not file or file == "" then
        print("No Python file to lint")
        return
    end
    
    -- Try different linters
    local linters = {"flake8", "pylint", "pycodestyle"}
    
    for _, linter in ipairs(linters) do
        if vim.fn.executable(linter) == 1 then
            local cmd = linter .. " " .. vim.fn.shellescape(file)
            execute_command(cmd, linter .. " check passed", linter .. " found issues")
            return
        end
    end
    
    print("No Python linter found (install flake8, pylint, or pycodestyle)")
end

function format_python()
    local file = vim.fn.expand("%")
    if not file or file == "" then
        print("No Python file to format")
        return
    end
    
    -- Try different formatters
    local formatters = {"black", "autopep8"}
    
    for _, formatter in ipairs(formatters) do
        if vim.fn.executable(formatter) == 1 then
            local cmd = formatter .. " " .. vim.fn.shellescape(file)
            local success = execute_command(cmd, "Code formatted with " .. formatter, "Formatting failed")
            if success then
                vim.cmd("edit!")  -- Reload the file
            end
            return
        end
    end
    
    print("No Python formatter found (install black or autopep8)")
end

function python_interactive()
    vim.cmd("terminal python3 -i " .. vim.fn.shellescape(vim.fn.expand("%")))
end

-- ================================
-- ENHANCED GIT FUNCTIONS
-- ================================

function is_git_repo()
    local result = vim.fn.system('git rev-parse --is-inside-work-tree 2>/dev/null')
    return vim.v.shell_error == 0
end

function get_current_branch()
    if not is_git_repo() then
        return nil
    end
    local result = vim.fn.system('git rev-parse --abbrev-ref HEAD 2>/dev/null')
    if vim.v.shell_error == 0 then
        return vim.fn.trim(result)
    end
    return nil
end

function has_upstream()
    if not is_git_repo() then
        return false
    end
    local upstream = vim.fn.system('git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null')
    return vim.v.shell_error == 0
end

function git_add()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    
    execute_command('git add .', "Files staged successfully", "Failed to stage files")
end

function git_commit()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    
    local message = vim.fn.input('Commit message: ')
    if message == '' then
        print("Commit message cannot be empty")
        return
    end
    
    local cmd = 'git commit -m ' .. vim.fn.shellescape(message)
    execute_command(cmd, "Commit successful", "Commit failed")
end

function smart_git_push()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    
    local branch = get_current_branch()
    if not branch then
        print("Could not determine current branch")
        return
    end
    
    local cmd
    if has_upstream() then
        cmd = 'git push'
    else
        cmd = 'git push --set-upstream origin ' .. vim.fn.shellescape(branch)
    end
    
    execute_command(cmd, "Git push successful", "Git push failed")
end

function smart_git_pull()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    
    local branch = get_current_branch()
    if not branch then
        print("Could not determine current branch")
        return
    end
    
    local cmd
    if has_upstream() then
        cmd = 'git pull --no-rebase'
    else
        cmd = 'git pull --no-rebase --set-upstream origin ' .. vim.fn.shellescape(branch)
    end
    
    execute_command(cmd, "Git pull successful", "Git pull failed")
end

function git_status()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    
    execute_command('git status', "Git status:", "Failed to get git status")
end

function git_diff()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    
    execute_command('git diff', "Git diff:", "Failed to get git diff")
end

function git_log()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    
    execute_command('git log --oneline --graph --all --decorate', "Git log:", "Failed to get git log")
end

function git_branch()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    
    execute_command('git branch -v', "", "Failed to list branches")
end

function git_init()
    execute_command('git init', "Git repository initialized", "Failed to initialize git repository")
end

function git_remote()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    
    execute_command('git remote -v', "", "Failed to list remotes")
end

function add_git_remote()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    
    local remote_name = vim.fn.input('Remote name (e.g., origin): ')
    if remote_name == '' then
        print("Remote name cannot be empty")
        return
    end
    
    local remote_url = vim.fn.input('Remote URL: ')
    if remote_url == '' then
        print("Remote URL cannot be empty")
        return
    end
    
    local cmd = 'git remote add ' .. vim.fn.shellescape(remote_name) .. ' ' .. vim.fn.shellescape(remote_url)
    execute_command(cmd, "Remote added successfully", "Failed to add remote")
end

-- ================================
-- AUTO COMMANDS
-- ================================

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Auto-create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local dir = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Disable relative numbers for large files
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.api.nvim_buf_line_count(0) > 10000 then
            vim.opt_local.relativenumber = false
        end
    end,
})

-- ================================
-- STATUS LINE ENHANCEMENT
-- ================================

function _G.git_branch_status()
    if is_git_repo() then
        local branch = get_current_branch()
        return branch and " [" .. branch .. "]" or ""
    end
    return ""
end

vim.opt.statusline = "%f%m%r%h%w%{v:lua.git_branch_status()}%=%l,%c %p%%"

-- ================================
-- TERMINAL ENHANCEMENTS
-- ================================

-- Terminal mode mappings
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { noremap = true, silent = true })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { noremap = true, silent = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { noremap = true, silent = true })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { noremap = true, silent = true })

-- Open terminal
vim.keymap.set('n', '<leader>t', ':terminal<CR>', { noremap = true, silent = true })

-- ================================
-- FINAL MESSAGE
-- ================================

print("Professional Neovim configuration loaded successfully!")
print("Leader key: <Space>")
print("Local leader: <,>")
print("Type :help to see Neovim documentation")
