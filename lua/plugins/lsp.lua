-- C:\Users\Ashen Chathuranga\AppData\Local\nvim\lua\plugins\lsp.lua
-- LSP Configuration

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      require('neodev').setup()

      local lspconfig = require 'lspconfig'
      local mason_lspconfig = require 'mason-lspconfig'
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Diagnostics signs
      local signs = {
        { name = 'DiagnosticSignError', text = '󰅚' },
        { name = 'DiagnosticSignWarn', text = '󰀪' },
        { name = 'DiagnosticSignHint', text = '󰌶' },
        { name = 'DiagnosticSignInfo', text = '󰋽' },
      }
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
      end

      -- Diagnostics config
      vim.diagnostic.config {
        virtual_text = true,
        signs = { active = signs },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = { focusable = true, style = 'minimal', border = 'rounded', source = 'always' },
      }

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

      -- LSP keymaps
      local on_attach = function(client, bufnr)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
        end, '[T]oggle Inlay [H]ints')
      end

      -- LSP servers
      local servers = {
        rust_analyzer = { settings = { ['rust-analyzer'] = { checkOnSave = { command = 'clippy' } } } },
        arduino_language_server = {
          cmd = { 'arduino-language-server', '-cli', 'arduino-cli', '-clangd', 'clangd' },
          filetypes = { 'arduino' },
        },
        jdtls = {}, -- Java support
        lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' }, diagnostics = { globals = { 'vim' } } } } },
      }

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            server.on_attach = on_attach
            lspconfig[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
