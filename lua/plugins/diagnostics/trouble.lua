if not vim.g.vscode then
  return {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = { "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "toggle trouble"
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
    },
    priority = 750,
    config = function()
      local status, tr = pcall(require, 'trouble')
      if status then
        tr.setup(
          {
            position = "bottom",
            height = 10,
            width = 50,
            group = true,
            padding = true,
            action_keys = {
              -- key mappings for actions in the trouble list
              -- map to {} to remove a mapping, for example:
              -- close = {},
              close = "q",                  -- close the list
              cancel = "<esc>",             -- cancel the preview and get back to your last window / buffer / cursor
              refresh = "r",                -- manually refresh
              jump = { "<cr>", "<tab>" },   -- jump to the diagnostic or open / close folds
              open_split = { "<c-x>" },     -- open buffer in new split
              open_vsplit = { "<c-v>" },    -- open buffer in new vsplit
              open_tab = { "<c-t>" },       -- open buffer in new tab
              jump_close = { "o" },         -- jump to the diagnostic and close the list
              toggle_mode = "m",            -- toggle between "workspace" and "document" diagnostics mode
              toggle_preview = "P",         -- toggle auto_preview
              hover = "K",                  -- opens a small popup with the full multiline message
              preview = "p",                -- preview the diagnostic location
              close_folds = { "zM", "zm" }, -- close all folds
              open_folds = { "zR", "zr" },  -- open all folds
              toggle_fold = { "zA", "za" }, -- toggle fold of current file
              previous = "k",               -- previous item
              next = "j"                    -- next item
            },
            indent_lines = true,
            -- auto_open = true,
            auto_close = true,
          }
        )
        -- auto close on buffer exits
        local autoclose = vim.api.nvim_create_augroup('autoclose', { clear = true })
        vim.api.nvim_clear_autocmds({
          buffer = vim.api.nvim_get_current_buf(),
          group = autoclose
        })
        vim.api.nvim_create_autocmd({ "QuitPre", "ExitPre" }, {
          callback = function()
            local ok, trouble = pcall(require, 'trouble')
            if ok then
              if trouble.is_open() then
                trouble.close()
              end
            end
          end,
          group = autoclose,
        })
      end
    end
  }
end
