# nvim-config

A lightweight Neovim configuration tailored for efficient Git workflows and file management, written in Lua. This configuration provides custom keybindings to execute common Git commands and create files directly from Neovim, without relying on third-party plugins. It’s designed for simplicity and speed, ideal for developers on Arch Linux, Windows, or other platforms.

## Features

- **Custom Git Keybindings**: Run Git commands like `git add`, `git commit`, `git push`, and `git pull` with intuitive key combinations.
- **File Creation in Git Root**: Create new files in the Git repository root, with automatic creation of parent directories for nested paths (e.g., `test/folder/a.txt`).
- **Selective Git Add**: Interactively select specific files to stage using `git add`, with fallback to the current file.
- **Lua-Based Configuration**: Uses Neovim’s modern Lua scripting for a clean and maintainable setup.
- **Smart Push and Pull**: Automatically handles upstream branches for `git push` and `git pull`, using a merge strategy for divergent branches.
- **No External Plugins**: Relies on Neovim’s built-in Lua API and shell commands for all Git and file operations.

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/nvim-config.git ~/.config/nvim
   ```
   Replace `your-username` with your GitHub username.

2. **Ensure Neovim is Installed**:
   On Arch Linux:
   ```bash
   sudo pacman -S neovim
   ```
   On Windows, use a package manager like `winget` or download from [Neovim’s releases](https://github.com/neovim/neovim/releases).

3. **Verify Git Configuration**:
   Ensure Git is installed and configured:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   git config --global pull.rebase false
   ```
   The last command sets the default pull strategy to merge, aligning with the configuration’s behavior.

4. **Start Neovim**:
   ```bash
   nvim
   ```
   The configuration in `init.lua` is loaded automatically from `~/.config/nvim/init.lua`.

## Keybindings

The configuration uses `<Space>` as the leader key. Below are the custom keybindings:

| Keybinding       | Command                                    | Description                                      |
|------------------|--------------------------------------------|--------------------------------------------------|
| `<Space>ga`      | `git add .`                                | Stage all changes in the current directory.      |
| `<Space>gf`      | `git add <file>`                           | Interactively select a file to stage, defaulting to the current file. |
| `<Space>gc`      | `git commit -m ""`                         | Start a commit with a prompt for the message.    |
| `<Space>gp`      | `git push` or `git push --set-upstream`    | Push changes, setting upstream if needed.        |
| `<Space>gs`      | `git status`                               | Show the repository’s status.                    |
| `<Space>gd`      | `git diff`                                 | View changes in the working directory.           |
| `<Space>gl`      | `git log --oneline --graph --all`          | Display a concise, graphical commit history.     |
| `<Space>gb`      | `git branch`                               | List all branches.                               |
| `<Space>gi`      | `git init`                                 | Initialize a new Git repository.                 |
| `<Space>gv`      | `git remote -v`                            | List remote repositories and their URLs.         |
| `<Space>gr`      | `git remote add <name> <url>`              | Add a new remote (prompts for name and URL).     |
| `<Space>gpl`     | `git pull --no-rebase` or with `--set-upstream` | Pull changes, using merge strategy and setting upstream if needed. |
| `<Space>nf`      | `:NewFile`                                 | Create a new file in the Git root, with prompt for filename and automatic directory creation for nested paths. |
| `<Space>w`       | `:write`                                   | Save the current file.                           |
| `<Space>q`       | `:quit`                                    | Quit the current window.                         |
| `<Space>wq`      | `:wq`                                      | Save and quit the current window.                |
| `<Space>qa`      | `:quitall`                                 | Quit all windows.                                |
| `<Space>q!`      | `:quit!`                                   | Quit without saving.                             |
| `<Space>wqa`     | `:wqa`                                     | Save all buffers and quit.                       |
| `<Space>wa`      | `:wall`                                    | Save all buffers.                                |

## Usage

1. **Open Neovim** in a Git repository:
   ```bash
   cd /path/to/your/repo
   nvim
   ```
   The configuration automatically sets the working directory to the provided path (if it’s a directory) on startup.

2. **Use Git Commands**:
   - Stage all changes: `<Space>ga`
   - Stage a specific file: `<Space>gf` (select from modified/untracked files or default to current file)
   - Commit: `<Space>gc`, type your message, and press Enter
   - Push: `<Space>gp` (shows success/failure feedback)
   - Pull: `<Space>gpl` (uses merge strategy for divergent branches)
   - Check status: `<Space>gs`
   - Add a remote: `<Space>gr`, then enter the remote name (e.g., `origin`) and URL

3. **Create New Files**:
   - Use `<Space>nf` and enter a filename (e.g., `a.txt` or `test/folder/a.txt`)
   - If the directories in the path (e.g., `test/folder`) don’t exist, they are created automatically in the Git root
   - Alternatively, run `:NewFile test/folder/a.txt` to create a file directly
   - The file is opened in Neovim for editing, with feedback on created directories and file path

4. **Resolve Merge Conflicts**:
   - If `<Space>gpl` triggers conflicts, open affected files in Neovim, resolve conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`), then stage (`<Space>ga` or `<Space>gf`) and commit (`<Space>gc`)

5. **File Operations**:
   - Save a file: `<Space>w`
   - Save and quit: `<Space>wq`
   - Save all buffers: `<Space>wa`
   - Quit without saving: `<Space>q!`

6. **View Feedback**:
   - Most commands display output in Neovim’s command-line area or a new buffer
   - For `<Space>nf`, feedback shows created directories and file path (e.g., `Created directories: /path/to/repo/test/folder`)
   - For `<Space>gp`, success or error messages are printed (e.g., `Git push successful: Everything up-to-date`)

## Configuration Details

- **File**: `init.lua`
- **Leader Key**: `<Space>`
- **Git Handling**:
  - The `smart_git_push` function checks for a Git repository and upstream branch, pushing with `--set-upstream` if needed
  - The `smart_git_pull` function uses `--no-rebase --allow-unrelated-histories` to handle divergent branches with a merge strategy
  - The `add_git_remote` function prompts for a remote name and URL, adding it to the repository
  - The `get_git_files` function lists modified/untracked files for selective staging with `<Space>gf`
- **File Creation**:
  - The `:NewFile` command creates files in the Git repository root, automatically creating parent directories for nested paths (e.g., `test/folder/a.txt`)
  - Uses `get_git_root()` to determine the repository root, falling back to the current buffer’s directory if not in a Git repository
- **Directory Handling**:
  - Automatically sets the working directory to the Git root or provided directory on startup
- **No Plugins**: All functionality uses Neovim’s built-in Lua API and shell commands

## Troubleshooting

- **Files Created in Wrong Directory**:
  - Ensure you’re in a Git repository (`<Space>gs` to check)
  - Verify the working directory with `:pwd` before creating a file
  - Check that `get_git_root()` correctly identifies the repository root (run `:lua print(get_git_root())`)
- **No Feedback for `<Space>gp`**:
  - Ensure you’re in a Git repository (`<Space>gs` to check)
  - Verify authentication (SSH keys or HTTPS credentials)
  - Check `:messages` for output or run `:new | r !git push` to debug
- **Divergent Branches Error**:
  - Run `git config --global pull.rebase false` to set merge as the default pull strategy
  - Resolve conflicts manually after `<Space>gpl`
- **Command Fails**:
  - Ensure Git is installed (`git --version`)
  - Check remote setup with `<Space>gv`
- **New File Command Issues**:
  - If `<Space>nf` fails to create directories, verify write permissions in the Git root
  - Test with `:NewFile test/folder/a.txt` and check `:messages` for errors

## Contributing

Feel free to fork this repository, add features, or submit pull requests. Suggestions for additional Git keybindings, file management features, or improvements are welcome!

## License

MIT License. See [LICENSE](LICENSE) for details.
