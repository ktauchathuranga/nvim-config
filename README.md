# Neovim Configuration

A modern, standalone Neovim configuration designed for productivity and portability across Windows, Linux, and macOS. Tailored for Rust, Arduino, Java, and general development (e.g., Lua, UI), it provides robust LSP, autocompletion, debugging, Git integration, and a sleek UI.

## Features

- **Plugin Management**: [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, lazy-loaded plugins.
- **LSP Support**: Configured for Rust (`rust_analyzer`), Arduino (`arduino_language_server`), Java (`jdtls`), and Lua (`lua_ls`) via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) and [mason.nvim](https://github.com/williamboman/mason.nvim).
- **Autocompletion**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) for intelligent code completion.
- **Debugging**: [nvim-dap](https://github.com/mfussenegger/nvim-dap) for Rust and Arduino with a user-friendly UI.
- **File Navigation**: [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) for file exploration and [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for fuzzy finding.
- **UI Enhancements**: [tokyonight](https://github.com/folke/tokyonight.nvim) theme, [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) statusline, [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) for tabs, and [alpha-nvim](https://github.com/goolord/alpha-nvim) dashboard.
- **Git Integration**: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for Git gutter signs and operations.
- **Code Formatting**: [conform.nvim](https://github.com/stevearc/conform.nvim) for automatic formatting (e.g., `rustfmt`, `google-java-format`).
- **Session Management**: [persistence.nvim](https://github.com/folke/persistence.nvim) for saving/restoring sessions.
- **Treesitter**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for enhanced syntax highlighting and indentation.
- **Portability**: Cross-platform with platform-specific Arduino port handling.

## Directory Structure

```plaintext
~/.config/nvim/ (Linux) or ~/AppData/Local/nvim/ (Windows)
├── .gitignore
├── .stylua.toml
├── init.lua
└── lua/
    ├── core/
    │   ├── autocmds.lua    # Autocommands for automation
    │   ├── keymaps.lua     # Keybindings
    │   └── options.lua     # Neovim settings
    └── plugins/
        ├── completion.lua  # Autocompletion (nvim-cmp)
        ├── git.lua         # Git integration (gitsigns.nvim)
        ├── init.lua        # Plugin manager (lazy.nvim)
        ├── lsp.lua         # LSP configurations
        ├── tools.lua       # Utilities (telescope, dap, conform)
        └── ui.lua          # UI plugins (tokyonight, lualine, nvim-tree)
```

- `.gitignore`: Ignores `lazy-lock.json`, swap files, and data directories.
- `.stylua.toml`: Configures [Stylua](https://github.com/JohnnyMorganz/StyLua) for Lua formatting.
- `init.lua`: Main entry point, loads core settings and plugins.
- `lua/core/`: Core Neovim configurations.
- `lua/plugins/`: Modular plugin configurations.

## Prerequisites

Ensure the following tools are installed:

| Tool                     | Purpose                              | Windows Install                   | Linux Install (Ubuntu)            |
|--------------------------|--------------------------------------|-----------------------------------|-----------------------------------|
| Neovim (v0.9+)           | Text editor                          | `choco install neovim`           | `sudo apt install neovim`        |
| Git                      | Version control                      | `choco install git`              | `sudo apt install git`           |
| ripgrep                  | File content search (Telescope)      | `choco install ripgrep`          | `sudo apt install ripgrep`       |
| fd                       | File finder (Telescope)              | `choco install fd`               | `sudo apt install fd-find`       |
| arduino-cli              | Arduino compilation/upload           | `choco install arduino-cli`      | `sudo apt install arduino-cli`   |
| clang                    | Arduino LSP (clangd)                 | `choco install llvm`             | `sudo apt install clang`         |
| nodejs, npm              | LSP server installation              | `choco install nodejs`           | `sudo apt install nodejs npm`    |
| Stylua                   | Lua formatting                       | `cargo install stylua`           | `cargo install stylua`           |
| lldb                     | Debugging (DAP)                      | `choco install llvm`             | `sudo apt install lldb`          |
| Rust (cargo, rustfmt)    | Rust development                     | `choco install rust`             | `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh` |
| Java (JDK 17)            | Java development                     | `choco install openjdk17`        | `sudo apt install openjdk-17-jdk` |

Install LSP servers:
```bash
npm install -g @rust-lang/rust-analyzer @arduino/arduino-language-server @fsouza.jdtls
```

## Setup Instructions

### Windows

1. **Install Dependencies**:
   In an elevated Command Prompt or PowerShell:
   ```bash
   choco install -y neovim git ripgrep fd arduino-cli llvm nodejs openjdk17 rust
   npm install -g @rust-lang/rust-analyzer @arduino/arduino-language-server @fsouza.jdtls
   cargo install stylua
   ```

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/ktauchathuranga/nvim-config $HOME\AppData\Local\nvim
   ```

3. **Verify Arduino Port**:
   - The configuration uses `COM3` by default (see `lua/core/keymaps.lua`).
   - Check your port:
     ```bash
     arduino-cli board list
     ```
   - Update `lua/core/keymaps.lua` if needed:
     ```lua
     local arduino_port = vim.fn.has('win32') == 1 and 'YOUR_PORT' or '/dev/ttyACM0'
     ```

4. **Launch Neovim**:
   ```bash
   nvim
   ```
   - Plugins install via `lazy.nvim`.
   - Run `:Lazy sync` if needed.

5. **Format Configuration**:
   ```bash
   stylua $HOME\AppData\Local\nvim
   ```

6. **Verify Setup**:
   - Run `:checkhealth` to check dependencies.
   - Test LSP in a `.rs`, `.ino`, or `.java` file (e.g., `gd` for go-to-definition).
   - Use `:Mason` to verify LSP servers.

### Linux (Ubuntu/Debian)

1. **Install Dependencies**:
   ```bash
   sudo apt update
   sudo apt install -y neovim git ripgrep fd-find arduino-cli clang nodejs npm openjdk-17-jdk lldb
   npm install -g @rust-lang/rust-analyzer @arduino/arduino-language-server @fsouza.jdtls
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   rustup component add rustfmt
   cargo install stylua
   ```

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/ktauchathuranga/nvim-config ~/.config/nvim
   ```

3. **Verify Arduino Port**:
   - The configuration uses `/dev/ttyACM0` by default (see `lua/core/keymaps.lua`).
   - Check your port:
     ```bash
     ls /dev/tty*
     ```
   - Update `lua/core/keymaps.lua` if needed.
   - Ensure port access:
     ```bash
     sudo usermod -a -G dialout $USER
     ```
     Log out and back in.

4. **Install Nerd Font** (Optional):
   For icon display:
   ```bash
   sudo apt install fonts-firacode
   ```
   Set terminal to “Fira Code Nerd Font”.

5. **Launch Neovim**:
   ```bash
   nvim
   ```
   - Plugins install via `lazy.nvim`.
   - Run `:Lazy sync` if needed.

6. **Format Configuration**:
   ```bash
   stylua ~/.config/nvim
   ```

7. **Verify Setup**:
   - Run `:checkhealth` to check dependencies.
   - Test LSP in a `.rs`, `.ino`, or `.java` file.
   - Use `:Mason` to check LSP servers.

## Usage

### Opening a Project
```bash
cd ~/projects/my-rust-app
nvim .
```
- The Alpha dashboard appears.
- Press `f` to search files or `e` to open NvimTree.

### Keybindings
Defined in `lua/core/keymaps.lua`. Key examples:

| Keybinding       | Action                              | Description                       |
|------------------|-------------------------------------|-----------------------------------|
| `<leader>e`      | `:NvimTreeToggle`                   | Toggle file explorer             |
| `<leader>sf`     | Telescope find files                | Search files                     |
| `<leader>sg`     | Telescope live grep                 | Search file contents             |
| `gd`             | LSP go-to-definition                | Jump to definition               |
| `K`              | LSP hover                           | Show documentation               |
| `<leader>ca`     | LSP code action                     | Apply fixes                      |
| `<leader>f`      | Format buffer                       | Format file                      |
| `<leader>rr`     | `:!cargo run`                       | Run Rust project                 |
| `<leader>ac`     | `:!arduino-cli compile`             | Compile Arduino sketch           |
| `<leader>au`     | `:!arduino-cli upload`              | Upload Arduino sketch            |
| `<leader>db`     | DAP toggle breakpoint               | Set breakpoint                   |
| `<leader>dd`     | DAP continue                        | Start/continue debugging         |
| `<leader>hs`     | Stage Git hunk                      | Stage current change             |
| `<leader>w`      | `:w`                                | Save file                        |
| `<leader>qs`     | Restore session                     | Reload last session              |

- Leader key: `<Space>`.
- View all keymaps: `:map` or `lua/core/keymaps.lua`.

### Coding Workflow
1. **Navigate**:
   - `<leader>e`: Browse files with NvimTree.
   - `<leader>sf`: Find files with Telescope.

2. **Write Code**:
   - Autocompletion with `nvim-cmp` (`<C-n>`/`<C-p>`, `<CR>` to select).
   - LSP: `gd` (go-to-definition), `<leader>rn` (rename), `<leader>d` (diagnostics).

3. **Format**:
   - `<leader>f`: Format with `rustfmt`, `google-java-format`, or `stylua`.

4. **Build/Run**:
   - Rust: `<leader>rb` (build), `<leader>rr` (run), `<leader>rt` (test).
   - Arduino: `<leader>ac` (compile), `<leader>au` (upload).
   - Java: Add keymap in `lua/core/keymaps.lua` (e.g., `:!javac % && java %:r`).

5. **Debug**:
   - `<leader>db`: Set breakpoint.
   - `<leader>dd`: Start debugging.
   - `<leader>du`: Toggle DAP UI.

6. **Git**:
   - `<leader>hs`: Stage hunk.
   - `]c`/`[c`: Navigate hunks.
   - Commit: `git commit -m "message"`.

7. **Save/Quit**:
   - `<leader>w`: Save.
   - `<leader>q`: Quit.
   - `<leader>qs`: Restore session.

### Example: Rust Project
```bash
cd ~/projects/my-rust-app
cargo init
nvim .
```
- Open `src/main.rs` with `<leader>sf`.
- Write:
  ```rust
  fn main() {
      println!("Hello, Neovim!");
  }
  ```
- `<leader>rr` to run.
- `<leader>db`, `<leader>dd` to debug.

### Example: Arduino Project
```bash
cd ~/projects/arduino-sketch
echo "void setup() { Serial.begin(9600); } void loop() { Serial.println(\"Hello, Arduino!\"); delay(1000); }" > sketch.ino
nvim .
```
- Open `sketch.ino` with `<leader>e`.
- `<leader>ac` to compile, `<leader>au` to upload.

## Customization

- **Add LSPs**:
  In `lua/plugins/lsp.lua`:
  ```lua
  pyright = {},
  ```

- **Change Theme**:
  In `lua/plugins/ui.lua`:
  ```lua
  { 'catppuccin/nvim', as = 'catppuccin', config = function() vim.cmd 'colorscheme catppuccin' end },
  ```

- **Custom Keymaps**:
  In `lua/core/keymaps.lua`:
  ```lua
  map('n', '<leader>jr', ':!javac % && java %:r<CR>', { desc = 'Run Java file' })
  ```

## Troubleshooting

- **Plugins Not Loading**:
  - Run `:Lazy sync`.
  - Check `:Lazy log`.

- **LSP Issues**:
  - Verify servers with `:Mason`.
  - Check `:LspInfo`.
  - Ensure `node`, `npm`, LSP binaries in PATH.

- **Arduino Port Errors**:
  - Verify port with `arduino-cli board list`.
  - Linux: Ensure `dialout` group membership.

- **Slow Performance**:
  - Run `:checkhealth`.
  - Disable unused plugins in `lua/plugins/init.lua`.

- **Icon Display**:
  - Install Nerd Font and configure terminal.

## Contributing

Fork, improve, and submit pull requests. Issues/suggestions welcome on [GitHub Issues](https://github.com/ktauchathuranga/nvim-config/issues).

## License

[MIT License](LICENSE).
