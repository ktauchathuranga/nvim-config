-- Set leader key
vim.g.mapleader = ' '

-- Git keybindings
vim.keymap.set('n', '<leader>ga', ':!git add .<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gc', ':!git commit -m ""<Left>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>gp', function() smart_git_push() end, { noremap = true, silent = false })
vim.keymap.set('n', '<leader>gs', ':!git status<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gd', ':!git diff<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gl', ':!git log --oneline --graph --all<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gb', ':!git branch<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gi', ':!git init<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gv', ':!git remote -v<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gr', function() add_git_remote() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gpl', function() smart_git_pull() end, { noremap = true, silent = true })

-- Function to check if in a Git repository
function is_git_repo()
    local result = vim.fn.system('git rev-parse --is-inside-work-tree 2>/dev/null')
    return vim.v.shell_error == 0
end

-- Function to get the current branch name
function get_current_branch()
    return vim.fn.trim(vim.fn.system('git rev-parse --abbrev-ref HEAD'))
end

-- Function to check if upstream is set for the current branch
function has_upstream()
    local branch = get_current_branch()
    local upstream = vim.fn.system('git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null')
    return vim.v.shell_error == 0
end

-- Smart git push with upstream handling and feedback
function smart_git_push()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    local branch = get_current_branch()
    local cmd
    if has_upstream() then
        cmd = 'git push'
    else
        cmd = 'git push --set-upstream origin ' .. vim.fn.shellescape(branch)
    end
    local output = vim.fn.system(cmd)
    if vim.v.shell_error == 0 then
        print("Git push successful: " .. output)
    else
        print("Git push failed: " .. output)
    end
end

-- Smart git pull with upstream and merge strategy
function smart_git_pull()
    if not is_git_repo() then
        print("Not a git repository")
        return
    end
    local branch = get_current_branch()
    if has_upstream() then
        vim.fn.system('git pull --no-rebase --allow-unrelated-histories')
    else
        vim.fn.system('git pull --no-rebase --allow-unrelated-histories --set-upstream origin ' .. vim.fn.shellescape(branch))
    end
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
    vim.fn.system('git remote add ' .. vim.fn.shellescape(remote_name) .. ' ' .. vim.fn.shellescape(remote_url))
    print("Added remote " .. remote_name .. " with URL " .. remote_url)
end
