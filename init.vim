" Set leader key
let mapleader = " "

" Git keybindings
nnoremap <leader>ga :!git add .<CR>
nnoremap <leader>gc :!git commit -m ""<Left>
nnoremap <leader>gp :!git push<CR>
nnoremap <leader>gs :!git status<CR>
nnoremap <leader>gd :!git diff<CR>
nnoremap <leader>gl :!git log --oneline --graph --all<CR>
nnoremap <leader>gb :!git branch<CR>
nnoremap <leader>gi :!git init<CR>
nnoremap <leader>gv :!git remote -v<CR>
nnoremap <leader>gr :call AddGitRemote()<CR>

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
