-- C:\Users\Ashen Chathuranga\AppData\Local\nvim\lua\plugins\tools.lua
-- Utility Plugins

return {
  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function() return vim.fn.executable 'make' == 1 end },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require('telescope').setup {
        extensions = { ['ui-select'] = { require('telescope.themes').get_dropdown() } },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find buffers' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    end,
  },

  -- Autoformat
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    opts = {
      format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt' },
        java = { 'google-java-format' },
      },
    },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
  },

  -- Debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'rcarriga/nvim-dap-ui', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dap-ui'

      dapui.setup()

      dap.adapters.lldb = {
        type = 'executable',
        command = 'lldb-vscode',
        name = 'lldb',
      }

      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      vim.keymap.set('n', '<leader>dd', dap.continue, { desc = 'Start/Continue Debugging' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })
      vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Open Debug [R]EPL' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle DAP [U]I' })
    end,
  },
}
