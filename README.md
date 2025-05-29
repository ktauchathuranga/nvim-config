# nvim-config

A modern, feature-rich Neovim configuration tailored for efficient coding, Git workflows, and file management, written in Lua. This configuration leverages the `lazy.nvim` plugin manager to provide a robust development environment with LSP support, autocompletion, syntax highlighting, and intuitive keybindings. Designed for simplicity, speed, and cross-platform compatibility, it’s ideal for developers on Arch Linux, Windows, or other platforms.

![Screenshot From 2025-05-27 12-54-46](https://github.com/user-attachments/assets/af05bb7b-ceda-486d-9127-89aeb112419e)

## Features

- **Plugin Management with lazy.nvim**: Automatically installs and manages plugins like LSP, completion, Treesitter, file explorer, fuzzy finder, and more.
- **LSP Support**: Configured for C/C++ (`clangd`), Python (`pyright`), Java (`jdtls`), Rust (`rust_analyzer`), PHP (`intelephense`), and Lua (`lua_ls`) with autocompletion and diagnostics.
- **Autocompletion**: Powered by `nvim-cmp` with snippet support via `LuaSnip` for efficient coding.
- **Syntax Highlighting**: Enhanced by `nvim-treesitter` for multiple languages (C, Python, Java, Rust, PHP, Lua, etc.).
- **File Explorer**: `nvim-tree` with icons for a modern file navigation experience.
- **Fuzzy Finder**: `telescope.nvim` for quick file searching, live grep, and buffer navigation.
- **Status Line**: `lualine.nvim` with customizable, icon-supported status line.
- **Git Integration**: Custom keybindings for common Git commands (`add`, `commit`, `push`, `pull`, etc.) with smart upstream handling and interactive file staging.
- **Formatting**: Automatic formatting on save with `conform.nvim` for multiple languages (e.g., `black` for Python, `rustfmt` for Rust).
- **Custom Git Keybindings**: Run Git commands like `git add`, `git commit`, `git push`, and `git pull` with intuitive key combinations.
- **File Creation in Git Root**: Create new files in the Git repository root, with automatic creation of parent directories for nested paths (e.g., `test/folder/a.txt`).
- **Selective Git Add**: Interactively select specific files to stage using `git add`, with fallback to the current file.
- **Smart Push and Pull**: Automatically handles upstream branches for `git push` and `git pull`, using a merge strategy for divergent branches.
- **Keybinding Help**: `which-key.nvim` provides hints for leader key combinations.
- **Colorscheme**: Beautiful `catppuccin` theme with `termguicolors` support.
- **Cross-Platform**: Works on Arch Linux, Windows, and other platforms with minimal setup.

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/ktauchathuranga/nvim-config.git ~/.config/nvim
   ```
   
2. **Ensure Neovim is Installed**:
   On Arch Linux:
   ```bash
   sudo pacman -S neovim
   ```
   On Windows, use a package manager like `winget` or download from [Neovim’s releases](https://github.com/neovim/neovim/releases).

3. **Install Nerd Fonts (Required for Icons)**:
   For proper icon display in plugins like `nvim-tree`, `lualine`, and `lazy.nvim`, install Nerd Fonts. On Arch Linux with GNOME:
   ```bash
   sudo pacman -S ttf-hack-nerd ttf-firacode-nerd ttf-jetbrains-mono-nerd
   ```
   For other platforms, download and install these fonts from [Nerd Fonts](https://www.nerdfonts.com/font-downloads) (e.g., Hack Nerd Font, FiraCode Nerd Font, JetBrains Mono Nerd Font) and configure your terminal to use one of them.

4. **Verify Git Configuration**:
   Ensure Git is installed and configured:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   git config --global pull.rebase false
   ```
   The last command sets the default pull strategy to merge, aligning with the configuration’s behavior.

5. **Start Neovim**:
   ```bash
   nvim
   ```
   The configuration in `init.lua` is loaded automatically from `~/.config/nvim/init.lua`. Plugins are installed on first startup via `lazy.nvim`.

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
| `<Space>e`       | `:NvimTreeToggle`                          | Toggle the file explorer (`nvim-tree`).          |
| `<Space>ff`      | `:Telescope find_files`                    | Find files using Telescope.                      |
| `<Space>fg`      | `:Telescope live_grep`                     | Search file contents with live grep.             |
| `<Space>fb`      | `:Telescope buffers`                       | List and switch between open buffers.            |
| `<Space>fh`      | `:Telescope help_tags`                     | Search Neovim help tags.                         |
| `<Space>d`       | `:lua vim.diagnostic.open_float()`         | Show diagnostics for the current line.           |
| `[d`             | `:lua vim.diagnostic.goto_prev()`          | Go to previous diagnostic.                       |
| `]d`             | `:lua vim.diagnostic.goto_next()`          | Go to next diagnostic.                           |
| `<Space>dl`      | `:lua vim.diagnostic.setloclist()`         | Show diagnostics in location list.               |
| `gD`             | `:lua vim.lsp.buf.declaration()`           | Go to declaration (LSP).                         |
| `gd`             | `:lua vim.lsp.buf.definition()`            | Go to definition (LSP).                          |
| `K`              | `:lua vim.lsp.buf.hover()`                 | Show hover information (LSP).                    |
| `gi`             | `:lua vim.lsp.buf.implementation()`        | Go to implementation (LSP).                      |
| `<C-k>`          | `:lua vim.lsp.buf.signature_help()`        | Show signature help (LSP).                       |
| `<Space>rn`      | `:lua vim.lsp.buf.rename()`                | Rename symbol (LSP).                             |
| `<Space>ca`      | `:lua vim.lsp.buf.code_action()`           | Perform code action (LSP).                       |
| `gr`             | `:lua vim.lsp.buf.references()`            | Find references (LSP).                           |
| `<Space>f`       | `:lua vim.lsp.buf.format()`                | Format the current buffer (LSP).                 |

## Usage

1. **Open Neovim** in a Git repository:
   ```bash
   cd /path/to/your/repo
   nvim
   ```
   The configuration automatically sets the working directory to the provided path (if it’s a directory) on startup.

2. **Install Plugins**:
   - On first startup, `lazy.nvim` automatically clones and installs all configured plugins.
   - Verify plugin installation with `:Lazy`.

3. **Use Git Commands**:
   - Stage all changes: `<Space>ga`
   - Stage a specific file: `<Space>gf` (select from modified/untracked files or default to current file)
   - Commit: `<Space>gc`, type your message, and press Enter
   - Push: `<Space>gp` (shows success/failure feedback)
   - Pull: `<Space>gpl` (uses merge strategy for divergent branches)
   - Check status: `<Space>gs`
   - Add a remote: `<Space>gr`, then enter the remote name (e.g., `origin`) and URL

4. **Create New Files**:
   - Use `<Space>nf` and enter a filename (e.g., `a.txt` or `test/folder/a.txt`)
   - If the directories in the path (e.g., `test/folder`) don’t exist, they are created automatically in the Git root
   - Alternatively, run `:NewFile test/folder/a.txt` to create a file directly
   - The file is opened in Neovim for editing, with feedback on created directories and file path

5. **Code Navigation and Editing**:
   - Use LSP keybindings (`gD`, `gd`, `K`, etc.) for code navigation and refactoring
   - Autocomplete with `<C-Space>` and navigate suggestions with `<Tab>`/`<S-Tab>`
   - Format code automatically on save or manually with `<Space>f`
   - Toggle file explorer with `<Space>e`
   - Search files with `<Space>ff` or content with `<Space>fg`

6. **Resolve Merge Conflicts**:
   - If `<Space>gpl` triggers conflicts, open affected files in Neovim, resolve conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`), then stage (`<Space>ga` or `<Space>gf`) and commit (`<Space>gc`)

7. **View Feedback**:
   - Most commands display output in Neovim’s command-line area or a new buffer
   - For `<Space>nf`, feedback shows created directories and file path (e.g., `Created directories: /path/to/repo/test/folder`)
   - For `<Space>gp`, success or error messages are printed (e.g., `Git push successful: Everything up-to-date`)

## Configuration Details

- **File**: `init.lua`
- **Leader Key**: `<Space>`
- **Plugin Management**:
  - Uses `lazy.nvim` to manage plugins like `nvim-lspconfig`, `nvim-cmp`, `nvim-treesitter`, `nvim-tree`, `telescope.nvim`, `lualine.nvim`, `gitsigns.nvim`, `conform.nvim`, `which-key.nvim`, and `catppuccin`.
- **LSP Configuration**:
  - Supports multiple languages with automatic server installation via `mason.nvim`
  - Configured with capabilities for autocompletion and keybindings for navigation, renaming, and code actions
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
- **Formatting**:
  - Automatic formatting on save using `conform.nvim` for supported languages
- **Diagnostics**:
  - Configured with virtual text, signs, and floating windows for LSP diagnostics
  - Custom diagnostic signs for errors, warnings, hints, and info

## Troubleshooting

- **Icons Not Displaying**:
  - Ensure a Nerd Font (e.g., Hack Nerd Font, FiraCode Nerd Font, or JetBrains Mono Nerd Font) is installed and set in your terminal
  - On Arch Linux, run `sudo pacman -S ttf-hack-nerd ttf-firacode-nerd ttf-jetbrains-mono-nerd`
  - For other platforms, install from [Nerd Fonts](https://www.nerdfonts.com/font-downloads) and configure your terminal
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
- **Plugin Issues**:
  - Run `:Lazy` to check plugin status and sync if needed
  - Ensure required dependencies (e.g., `git`, `make` for `LuaSnip`) are installed
- **LSP or Completion Not Working**:
  - Verify LSP servers are installed with `:Mason`
  - Check diagnostics with `<Space>d` or `:lua vim.diagnostic.setloclist()`

## Contributing

Feel free to fork this repository, add features, or submit pull requests. Suggestions for additional plugins, Git keybindings, LSP configurations, or other improvements are welcome!

## License

MIT License. See [LICENSE](LICENSE) for details.
