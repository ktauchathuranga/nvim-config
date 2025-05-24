-- ~/.config/nvim/lua/plugins/init.lua
-- Plugin Manager

return require('lazy').setup({
  -- Libraries
  { 'nvim-lua/plenary.nvim', lazy = true },

  -- UI
  { import = 'plugins.ui' },

  -- LSP
  { import = 'plugins.lsp' },

  -- Completion
  { import = 'plugins.completion' },

  -- Tools
  { import = 'plugins.tools' },

  -- Git
  { import = 'plugins.git' },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { 'bash', 'c', 'cpp', 'rust', 'lua', 'arduino', 'markdown', 'java', 'javascript', 'html', 'css' },
        additional_vim_regex_highlighting = false,
      }
    end,
  },

  -- Commenting
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },

  -- Autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      ts_config = { lua = { 'string', 'source' }, javascript = { 'string', 'template_string' } },
    },
  },
}, {
  defaults = { lazy = true },
  install = { colorscheme = { 'tokyonight', 'habamax' } },
  checker = { enabled = true, notify = false, frequency = 3600 },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = { 'gzip', 'matchit', 'matchparen', 'netrwPlugin', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin' },
    },
  },
})
