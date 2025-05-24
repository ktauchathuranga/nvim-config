# nvim-config

A lightweight Neovim configuration tailored for efficient Git workflows and development in C, Python, Java, and Rust. Written in Lua, this configuration provides custom keybindings to execute common Git and development commands directly from Neovim, without relying on third-party plugins. It’s designed for simplicity and speed, ideal for developers working on Arch Linux, Windows, or other platforms.

## Features

- **Custom Git Keybindings**: Run Git commands like `git add`, `git commit`, `git push`, `git pull`, and more with simple key combinations, with output displayed in Neovim’s command-line area.
- **Language-Specific Support**: Optimized settings and keybindings for C/C++, Python, Java, and Rust development, including compilation, execution, debugging, and formatting.
- **Lua-Based Configuration**: Uses Neovim’s modern Lua scripting for a clean and maintainable setup.
- **Smart Push and Pull**: Automatically handles upstream branches for `git push` and `git pull`, with merge strategy for divergent branches.
- **No External Plugins**: Relies on Neovim’s built-in capabilities and shell commands for all operations.

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

4. **Install Language Tools** (optional, for development features):
   - **C/C++**: Install `gcc` or `g++` for compilation and `gdb` for debugging.
   - **Python**: Install `python3`, and optionally `flake8`, `pylint`, `pycodestyle`, `black`, or `autopep8` for linting and formatting.
   - **Java**: Install `java` (JDK) and `javac`.
   - **Rust**: Install `rustc` and `cargo`.

5. **Start Neovim**:
   ```bash
   nvim
   ```
   The configuration in `init.lua` is loaded automatically from `~/.config/nvim/init.lua`.

## Keybindings

The configuration uses `<Space>` as the leader key and `,` as the local leader key. Below are the keybindings for Git and development tasks:

### Git Keybindings

| Keybinding       | Command                                    | Description                                      |
|------------------|--------------------------------------------|--------------------------------------------------|
| `<Space>ga`      | `git add .`                                | Stage all changes in the current directory.      |
| `<Space>gc`      | `git commit -m ""`                         | Start a commit with a prompt for the message.    |
| `<Space>gp`      | `git push` or `git push --set-upstream`    | Push changes, setting upstream if needed.        |
| `<Space>gs`      | `git status`                               | Show repository status in the command-line area. |
| `<Space>gd`      | `git diff`                                 | View changes in the command-line area.           |
| `<Space>gl`      | `git log --oneline --graph --all`          | Display concise, graphical commit history in the command-line area. |
| `<Space>gb`      | `git branch`                               | List all branches in the command-line area.      |
| `<Space>gi`      | `git init`                                 | Initialize a new Git repository.                 |
| `<Space>gv`      | `git remote -v`                            | List remote repositories and their URLs.         |
| `<Space>gr`      | `git remote add <name> <url>`              | Add a new remote (prompts for name and URL).     |
| `<Space>gpl`     | `git pull --no-rebase` or with `--set-upstream` | Pull changes, using merge strategy and setting upstream if needed. |

### Development Keybindings

| Keybinding       | Language  | Description                                      |
|------------------|-----------|--------------------------------------------------|
| `<Space>cc`      | C/C++     | Compile the current file (`gcc` or `g++`).        |
| `<Space>cr`      | C/C++     | Run the compiled executable.                     |
| `<Space>cd`      | C/C++     | Debug with `gdb` in a terminal.                  |
| `<Space>cm`      | C/C++     | Run `make` if a Makefile exists.                 |
| `<Space>pr`      | Python    | Run the current Python file.                     |
| `<Space>pt`      | Python    | Run tests with `pytest` or `unittest`.           |
| `<Space>pl`      | Python    | Lint with `flake8`, `pylint`, or `pycodestyle`.  |
| `<Space>pf`      | Python    | Format with `black` or `autopep8`.               |
| `<Space>pi`      | Python    | Open an interactive Python session.              |
| `<Space>jc`      | Java      | Compile the current Java file (`javac`).         |
| `<Space>jr`      | Java      | Run the compiled Java program.                   |
| `<Space>jf`      | Java      | Set filetype to Java.                            |
| `<Space>rc`      | Rust      | Compile and run the current Rust file (`rustc`). |
| `<Space>rb`      | Rust      | Build with `cargo build`.                        |
| `<Space>rr`      | Rust      | Run with `cargo run`.                            |
| `<Space>rt`      | Rust      | Run tests with `cargo test`.                     |
| `<Space>rf`      | Rust      | Set filetype to Rust.                            |

### General Keybindings

| Keybinding       | Description                                      |
|------------------|--------------------------------------------------|
| `jk` (insert mode) | Exit insert mode (alternative to `<Esc>`).      |
| `<Space>h`       | Clear search highlights.                         |
| `<C-h/j/k/l>`    | Navigate between windows.                        |
| `<C-Up/Down>`    | Resize windows vertically.                       |
| `<C-Left/Right>` | Resize windows horizontally.                     |
| `<Space>bn/bp`   | Navigate to next/previous buffer.                |
| `<Space>bd`      | Delete current buffer.                           |
| `<Space>bl`      | List all buffers.                                |
| `<Space>tn/tc/tm`| Create/close/move tabs.                          |
| `<Space>w/q/x`   | Save/quit/save-and-quit current buffer.          |
| `<Space>t`       | Open a terminal.                                 |

## Usage

1. **Open Neovim** in a Git repository or project:
   ```bash
   cd /path/to/your/repo
   nvim
   ```

2. **Use Git Commands**:
   - Stage changes: `<Space>ga`
   - Commit: `<Space>gc`, type your message, and press Enter.
   - Push: `<Space>gp` (shows success/failure feedback).
   - Pull: `<Space>gpl` (uses merge strategy for divergent branches).
   - Check status: `<Space>gs` (output in command-line area).
   - Add a remote: `<Space>gr`, then enter the remote name (e.g., `origin`) and URL.

3. **Use Development Commands**:
   - Compile and run a C++ file: `<Space>cc` then `<Space>cr`.
   - Format a Python file: `<Space>pf` (requires `black` or `autopep8`).
   - Run a Rust project: `<Space>rr` (uses `cargo run`).

4. **Resolve Merge Conflicts**:
   - If `<Space>gpl` triggers conflicts, open affected files in Neovim, resolve conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`), then stage (`<Space>ga`) and commit (`<Space>gc`).

5. **View Feedback**:
   - Git commands like `<Space>gs`, `<Space>gd`, and `<Space>gl` display output in Neovim’s command-line area.
   - Development commands (e.g., `<Space>cc`, `<Space>pr`) show success or error messages in the command-line area, with some (e.g., `<Space>cd`, `<Space>pi`) opening a terminal.

## Configuration Details

- **File**: `init.lua`
- **Leader Key**: `<Space>`
- **Local Leader Key**: `,`
- **Git Handling**:
  - The `smart_git_push` function checks for a Git repository and upstream branch, pushing with `--set-upstream` if needed.
  - The `smart_git_pull` function uses `--no-rebase --allow-unrelated-histories` to handle divergent branches with a merge strategy.
  - The `add_git_remote` function prompts for a remote name and URL, adding it to the repository.
  - Commands like `git status`, `git diff`, and `git log` display output in the command-line area for quick viewing.
- **Language Support**:
  - C/C++: Configured with 4-space indentation, 80-column limit, and `gcc`/`g++` integration.
  - Python: 4-space indentation, 79-column limit, supports `pytest`/`unittest` and multiple linters/formatters.
  - Java: 4-space indentation, 120-column limit, with `javac` and `java` commands.
  - Rust: 4-space indentation, 100-column limit, with `rustc` and `cargo` integration.
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
  - Check remote setup with `<Space>gv`.
  - For development commands, verify required tools (e.g., `gcc`, `python3`, `cargo`) are installed.
- **Output Truncated**:
  - For large outputs from `<Space>gs`, `<Space>gd`, or `<Space>gl`, check `:messages` to view the full output.

## Contributing

Feel free to fork this repository, add features, or submit pull requests. Suggestions for additional keybindings, language support, or improvements are welcome!

## License

MIT License. See [LICENSE](LICENSE) for details.

