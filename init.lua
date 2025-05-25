-- Set leader key
vim.g.mapleader = ' '

-- Auto-change directory to the one provided as an argument
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local path = vim.fn.argv(0)
        if path ~= "" and vim.fn.isdirectory(path) == 1 then
            vim.cmd("cd " .. vim.fn.fnameescape(path))
        end
    end,
})

-- Helper function to get the project root (directory containing .git)
function get_git_root()
    local path = vim.fn.expand('%:p:h')
    local result = vim.fn.system('git -C ' .. vim.fn.shellescape(path) .. ' rev-parse --show-toplevel 2>/dev/null')
    if vim.v.shell_error == 0 then
        return vim.fn.trim(result)
    end
    return path
end

-- Helper function to execute Git command and provide feedback
local function execute_git_command(cmd, success_msg, error_msg)
    local git_root = get_git_root()
    local full_cmd = 'git -C ' .. vim.fn.shellescape(git_root) .. ' ' .. cmd
    local output = vim.fn.system(full_cmd)
    if vim.v.shell_error == 0 then
        print(success_msg .. (output ~= "" and ": " .. output or ""))
    else
        print(error_msg .. ": " .. output)
    end
end

-- Helper function to get list of modified/untracked files from git status
local function get_git_files()
    local git_root = get_git_root()
    local output = vim.fn.system('git -C ' .. vim.fn.shellescape(git_root) .. ' status --short 2>/dev/null')
    if vim.v.shell_error ~= 0 then
        return {}
    end
    local files = {}
    for line in output:gmatch("[^\r\n]+") do
        -- Extract file path from git status --short (e.g., " M file.txt" or "?? file.txt")
        local file = line:match("^%s*%S+%s+(.+)$")
        if file then
            table.insert(files, file)
        end
    end
    return files
end

-- Git keybindings
vim.keymap.set('n', '<leader>ga', function()
    execute_git_command('add .', 'Git add all successful', 'Git add all failed')
end, { noremap = true, desc = "Git add all files" })

vim.keymap.set('n', '<leader>gf', function()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    local files = get_git_files()
    local current_file = vim.fn.expand('%:t')
    if current_file ~= '' and not vim.tbl_contains(files, current_file) then
        table.insert(files, current_file) -- Add current file if not in git status
    end
    if #files == 0 then
        print("No modified or untracked files found")
        if current_file ~= '' then
            execute_git_command('add ' .. vim.fn.shellescape(current_file), 'Git add ' .. current_file .. ' successful', 'Git add ' .. current_file .. ' failed')
        else
            print("No file open to add")
        end
        return
    end
    vim.ui.select(files, {
        prompt = 'Select file to git add (default: ' .. (current_file ~= '' and current_file or 'none') .. '):',
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice == nil then
            if current_file ~= '' then
                execute_git_command('add ' .. vim.fn.shellescape(current_file), 'Git add ' .. current_file .. ' successful', 'Git add ' .. current_file .. ' failed')
            else
                print("Git add aborted: No file selected")
            end
            return
        end
        execute_git_command('add ' .. vim.fn.shellescape(choice), 'Git add ' .. choice .. ' successful', 'Git add ' .. choice .. ' failed')
    end)
end, { noremap = true, desc = "Git add specific file" })

vim.keymap.set('n', '<leader>gc', function()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    vim.ui.input({ prompt = 'Commit message: ' }, function(input)
        if input == nil or input == '' then
            print("Commit aborted: No message provided")
            return
        end
        execute_git_command('commit -m ' .. vim.fn.shellescape(input), 'Git commit successful', 'Git commit failed')
    end)
end, { noremap = true, desc = "Git commit" })

vim.keymap.set('n', '<leader>gp', function() smart_git_push() end, { noremap = true, desc = "Git push" })
vim.keymap.set('n', '<leader>gs', function()
    execute_git_command('status', 'Git status retrieved', 'Git status failed')
end, { noremap = true, desc = "Git status" })
vim.keymap.set('n', '<leader>gd', function()
    execute_git_command('diff', 'Git diff retrieved', 'Git diff failed')
end, { noremap = true, desc = "Git diff" })
vim.keymap.set('n', '<leader>gl', function()
    execute_git_command('log --oneline --graph --all', 'Git log retrieved', 'Git log failed')
end, { noremap = true, desc = "Git log" })
vim.keymap.set('n', '<leader>gb', function()
    execute_git_command('branch', 'Git branches retrieved', 'Git branch failed')
end, { noremap = true, desc = "Git branch" })
vim.keymap.set('n', '<leader>gi', function()
    execute_git_command('init', 'Git repository initialized', 'Git init failed')
end, { noremap = true, desc = "Git init" })
vim.keymap.set('n', '<leader>gv', function()
    execute_git_command('remote -v', 'Git remotes retrieved', 'Git remote failed')
end, { noremap = true, desc = "Git remote -v" })
vim.keymap.set('n', '<leader>gr', function() add_git_remote() end, { noremap = true, desc = "Add git remote" })
vim.keymap.set('n', '<leader>gpl', function() smart_git_pull() end, { noremap = true, desc = "Git pull" })

-- File operation keybindings
vim.keymap.set('n', '<leader>w', ':write<CR>', { noremap = true, silent = true, desc = "Write file" })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { noremap = true, silent = true, desc = "Quit" })
vim.keymap.set('n', '<leader>wq', ':wq<CR>', { noremap = true, silent = true, desc = "Write and quit" })
vim.keymap.set('n', '<leader>qa', ':quitall<CR>', { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set('n', '<leader>q!', ':quit!<CR>', { noremap = true, silent = true, desc = "Quit without saving" })
vim.keymap.set('n', '<leader>wqa', ':wqa<CR>', { noremap = true, silent = true, desc = "Write all and quit" })
vim.keymap.set('n', '<leader>wa', ':wall<CR>', { noremap = true, silent = true, desc = "Write all buffers" })
vim.keymap.set('n', '<leader>nf', ':NewFile<CR>', { noremap = true, desc = "Create new file in Git root" })

-- Function to check if in a Git repository
function is_git_repo()
    local result = vim.fn.system('git -C ' .. vim.fn.shellescape(get_git_root()) .. ' rev-parse --is-inside-work-tree 2>/dev/null')
    return vim.v.shell_error == 0
end

-- Function to get the current branch name
function get_current_branch()
    return vim.fn.trim(vim.fn.system('git -C ' .. vim.fn.shellescape(get_git_root()) .. ' rev-parse --abbrev-ref HEAD'))
end

-- Function to check if upstream is set for the current branch
function has_upstream()
    local branch = get_current_branch()
    local upstream = vim.fn.system('git -C ' .. vim.fn.shellescape(get_git_root()) .. ' rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null')
    return vim.v.shell_error == 0
end

-- Smart git push with upstream handling and feedback
function smart_git_push()
    print("Starting git push...")
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    local branch = get_current_branch()
    local cmd
    if has_upstream() then
        cmd = 'push'
    else
        cmd = 'push --set-upstream origin ' .. vim.fn.shellescape(branch)
    end
    execute_git_command(cmd, 'Git push successful', 'Git push failed')
end

-- Smart git pull with upstream and merge strategy
function smart_git_pull()
    print("Starting git pull...")
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    local branch = get_current_branch()
    local cmd
    if has_upstream() then
        cmd = 'pull --no-rebase --allow-unrelated-histories'
    else
        cmd = 'pull --no-rebase --allow-unrelated-histories --set-upstream origin ' .. vim.fn.shellescape(branch)
    end
    execute_git_command(cmd, 'Git pull successful', 'Git pull failed')
end

-- Function to add Git remote
function add_git_remote()
    local remote_name = vim.fn.input('Remote name (e.g., origin): ')
    if remote_name == '' then
        print("Remote name cannot be empty")
        return
    end
    local remote_url = vim.fn.input('Remote URL (e.g., https://github.com/user/repo.git): ')
    if remote_url == '' then
        print("Remote URL cannot be empty")
        return
    end
    execute_git_command('remote add ' .. vim.fn.shellescape(remote_name) .. ' ' .. vim.fn.shellescape(remote_url),
        'Added remote ' .. remote_name .. ' with URL ' .. remote_url,
        'Failed to add remote ' .. remote_name)
end

vim.api.nvim_create_user_command('NewFile', function(opts)
    local git_root = get_git_root()
    local filename = opts.args
    if filename == '' then
        filename = vim.fn.input('Enter filename: ')
    end
    if filename == '' then
        print("No filename provided")
        return
    end
    -- Construct the full path by joining git_root and filename
    local full_path = git_root .. '/' .. filename
    -- Get the directory path (parent directories of the file)
    local dir_path = vim.fn.fnamemodify(full_path, ':h')
    -- Create parent directories if they don't exist
    if vim.fn.isdirectory(dir_path) == 0 then
        vim.fn.mkdir(dir_path, 'p')
        print("Created directories: " .. dir_path)
    end
    -- Open the file for editing
    vim.cmd("edit " .. vim.fn.fnameescape(full_path))
    print("Creating new file: " .. full_path)
end, { nargs = '?' })

