-- C:\Users\Ashen Chathuranga\AppData\Local\nvim\lua\plugins\git.lua
-- Git Plugins

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      current_line_blame = true,
      current_line_blame_opts = { virt_text = true, virt_text_pos = 'eol', delay = 1000 },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, 'Next hunk')
        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, 'Previous hunk')
        map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
        map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Stage selected hunk')
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Reset selected hunk')
        map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
        map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')
        map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
        map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'Blame line')
      end,
    },
  },
}
