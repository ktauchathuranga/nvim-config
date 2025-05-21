-- C:\Users\Ashen Chathuranga\AppData\Local\nvim\lua\plugins\ui.lua
-- UI Plugins

return {
  -- Colorscheme
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'storm',
        transparent = false,
        terminal_colors = true,
        styles = { comments = { italic = true }, keywords = { italic = true } },
      }
      vim.cmd 'colorscheme tokyonight'
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        theme = 'tokyonight',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = { 'nvim-tree', 'toggleterm', 'quickfix' },
    },
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        mode = 'buffers',
        separator_style = 'slant',
        diagnostics = 'nvim_lsp',
        offsets = {
          { filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory', separator = true },
        },
      },
    },
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file explorer' },
      { '<leader>o', '<cmd>NvimTreeFocus<CR>', desc = 'Focus file explorer' },
    },
    opts = {
      filters = { dotfiles = false },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      update_focused_file = { enable = true, update_root = true },
      view = { adaptive_size = false, side = 'left', width = 30 },
      git = { enable = true, ignore = false },
      renderer = { root_folder_label = false, highlight_git = true, indent_markers = { enable = true } },
    },
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = { char = '│', tab_char = '│' },
      scope = { enabled = false },
      exclude = {
        filetypes = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason', 'notify', 'toggleterm' },
      },
    },
  },

  -- Dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    opts = function()
      local dashboard = require 'alpha.themes.dashboard'
      dashboard.section.header.val = {
        [[                                                                       ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
      }
      dashboard.section.buttons.val = {
        dashboard.button('f', '📂 Find file', ':Telescope find_files <CR>'),
        dashboard.button('n', '📝 New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', '🕒 Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', '🔍 Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '⚙️ Config', ':e $MYVIMRC <CR>'),
        dashboard.button('s', '💾 Restore Session', ':lua require("persistence").load() <CR>'),
        dashboard.button('l', '🔌 Lazy', ':Lazy<CR>'),
        dashboard.button('q', '🚪 Quit', ':qa<CR>'),
      }
      dashboard.section.footer.val = 'Neovim loaded ' .. require('lazy').stats().count .. ' plugins'
      dashboard.config.opts.noautocmd = true
      return dashboard
    end,
    config = function(_, dashboard)
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end
      require('alpha').setup(dashboard.opts)
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = 'Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- Notifications
  {
    'rcarriga/nvim-notify',
    lazy = false,
    config = function()
      local notify = require 'notify'
      notify.setup { background_colour = '#000000', stages = 'fade', timeout = 3000 }
      vim.notify = notify
    end,
  },

  -- Enhanced UI for inputs
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Session management
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = { options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals' } },
    keys = {
      { '<leader>qs', function() require('persistence').load() end, desc = 'Restore session' },
      { '<leader>ql', function() require('persistence').load { last = true } end, desc = 'Restore last session' },
      { '<leader>qd', function() require('persistence').stop() end, desc = "Don't save current session" },
    },
  },

  -- LSP progress
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = { notification = { window = { winblend = 0 } } },
  },
}
