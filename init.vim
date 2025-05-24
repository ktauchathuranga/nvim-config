" Set leader key
let mapleader = " "

" Git keybindings
nnoremap <leader>ga :!git add .<CR>
nnoremap <leader>gc :!git commit -m ""<Left>
nnoremap <leader>gp :call SmartGitPush()<CR>
nnoremap <leader>gs :!git status<CR>
nnoremap <leader>gd :!git diff<CR>
nnoremap <leader>gl :!git log --oneline --graph --all<CR>
nnoremap <leader>gb :!git branch<CR>
nnoremap <leader>gi :!git init<CR>
nnoremap <leader>gv :!git remote -v<CR>
nnoremap <leader>gr :call AddGitRemote()<CR>
nnoremap <leader>gpl :call SmartGitPull()<CR>

" Function to check if in a Git repository
function! IsGitRepo()
    silent !git rev-parse --is-inside-work-tree
    return v:shell_error == 0
endfunction

" Function to get the current branch name
function! GetCurrentBranch()
    return trim(system('git rev-parse --abbrev-ref HEAD'))
endfunction

" Function to check if upstream is set for the current branch
function! HasUpstream()
    let branch = GetCurrentBranch()
    let upstream = system('git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null')
    return v:shell_error == 0
endfunction

" Smart git push with upstream handling
function! SmartGitPush()
    if !IsGitRepo()
        echo "Not a git repository"
        return
    endif
    let branch = GetCurrentBranch()
    if HasUpstream()
        execute '!git push'
    else
        execute '!git push --set-upstream origin ' . shellescape(branch)
    endif
endfunction

" Smart git pull with upstream handling
function! SmartGitPull()
    if !IsGitRepo()
        echo "Not a git repository"
        return
    endif
    let branch = GetCurrentBranch()
    if HasUpstream()
        execute '!git pull'
    else
        execute '!git pull --set-upstream origin ' . shellescape(branch)
    endif
endfunction

" Function to add Git remote
function! AddGitRemote()
    let remote_name = input('Remote name (e.g., origin): ')
    if remote_name ==# ''
        echo "Remote name cannot be empty"
        return
    endif
    let remote_url = input('Remote URL (e.g., https://github.com/user/repo.git): ')
    if remote_url ==# ''
        echo "Remote URL cannot be empty"
        return
    endif
    execute '!git remote add ' . shellescape(remote_name) . ' ' . shellescape(remote_url)
    echo "Added remote " . remote_name . " with URL " . remote_url
endfunction

