if not vim.g.vscode then
  return {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>tz", "<cmd>ZenMode<cr>", desc = "toggle zen mode" },
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function (_, opts)
      require('zen-mode').setup(opts);
    end
  }
end
