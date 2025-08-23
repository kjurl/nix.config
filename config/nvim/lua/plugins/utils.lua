---@type NvPluginSpec[]
return {
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },
  { --require("otter").activate({"javascript", "python", "lua", "css"}, true, true, nil)
    "jmbuhr/otter.nvim",
    ft = { "nix", "lua" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "toppair/peek.nvim",
    event = "VeryLazy",
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup {
        app = { "firefox", "--new-window", "--kiosk", "--safe-mode" },
      }
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    cmd = "RenderMarkdown",
    ft = function()
      local plugin = require("lazy.core.config").spec.plugins["render-markdown.nvim"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      return opts.file_types or { "markdown" }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons", -- if you prefer nvim-web-devicons
      -- "echasnovski/mini.icons", -- if you use standalone mini plugins
    },
  },
}
