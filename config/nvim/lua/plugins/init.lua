---@type NvPluginSpec[]
return {
  -- https://github.com/VonHeikemen/lsp-zero.nvim
  { "nvim-treesitter/nvim-treesitter", opts = require "configs.treesitter" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "b0o/schemastore.nvim" },
    opts = require "configs.lspconfig",
  },
  {
    "nvimtools/none-ls.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      require "configs.none-ls"
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = require("configs.refinement").format,
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = require("configs.refinement").lint,
    config = function(_, opts)
      require("lint").linters_by_ft = opts
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" },
        {
          group = lint_augroup,
          callback = function()
            require("lint").try_lint()
          end,
        }
      )
    end,
  },
}
