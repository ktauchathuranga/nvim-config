# nvim-config

A lightweight Neovim configuration tailored for efficient Git workflows, written in Lua. This configuration provides custom keybindings to execute common Git commands directly from Neovim, without relying on third-party plugins. It’s designed for simplicity and speed, ideal for developers working on Arch Linux, Windows, or other platforms.

## Features

- **Custom Git Keybindings**: Run Git commands like `git add`, `git commit`, `git push`, and `git pull` with simple key combinations.
- **Lua-Based Configuration**: Uses Neovim’s modern Lua scripting for a clean and maintainable setup.
- **Smart Push and Pull**: Automatically handles upstream branches for `git push` and `git pull`, with merge strategy for divergent branches.
- **No External Plugins**: Relies on Neovim’s built-in capabilities and shell commands for Git operations.

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

The configuration uses `<Space>` as the leader key. Below are the custom Git keybindings:

| Keybinding       | Command                                    | Description                                      |
|------------------|--------------------------------------------|--------------------------------------------------|
| `<Space>ga`      | `git add .`                                | Stage all changes in the current directory.      |
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

## Usage

1. **Open Neovim** in a Git repository:
   ```bash
   cd /path/to/your/repo
   nvim
   ```

2. **Use Git Commands**:
   - Stage changes: `<Space>ga`
   - Commit: `<Space>gc`, type your message, and press Enter.
   - Push: `<Space>gp` (shows success/failure feedback).
   - Pull: `<Space>gpl` (uses merge strategy for divergent branches).
   - Check status: `<Space>gs`
   - Add a remote: `<Space>gr`, then enter the remote name (e.g., `origin`) and URL.

3. **Resolve Merge Conflicts**:
   - If `<Space>gpl` triggers conflicts, open affected files in Neovim, resolve conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`), then stage (`<Space>ga`) and commit (`<Space>gc`).

4. **View Feedback**:
   - Most commands display output in Neovim’s command-line area or a new buffer.
   - For `<Space>gp`, success or error messages are printed (e.g., `Git push successful: Everything up-to-date`).

## Configuration Details

- **File**: `init.lua`
- **Leader Key**: `<Space>`
- **Git Handling**:
  - The `smart_git_push` function checks for a Git repository and upstream branch, pushing with `--set-upstream` if needed.
  - The `smart_git_pull` function uses `--no-rebase --allow-unrelated-histories` to handle divergent branches with a merge strategy.
  - The `add_git_remote` function prompts for a remote name and URL, adding it to the repository.
- **No Plugins**: All functionality uses Neovim’s built-in Lua API and shell commands.

## Troubleshooting

- **No Feedback for `<Space>gp`**:
  - Ensure you’re in a Git repository (`<Space>gs` to check).
  - Verify authentication (SSH keys or HTTPS credentials).
  - Check `:messages` for output or run `:new | r !git push` to debug.
- **Divergent Branches Error**:
  - Run `git config --global pull.rebase false` to set merge as the default pull strategy.
  - Resolve conflicts manually after `<Space>gpl`.
- **Command Fails**:
  - Ensure Git is installed (`git --version`).
  - Check remote setup with `<
Space>gv`.

## Contributing

Feel free to fork this repository, add features, or submit pull requests. Suggestions for additional Git keybindings or improvements are welcome!

## License

MIT License. See [LICENSE](LICENSE) for details.
