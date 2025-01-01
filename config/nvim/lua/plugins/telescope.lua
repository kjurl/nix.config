---@type NvPluginSpec[]
return {
  {
    "1riz/telescope-macros.nvim",
    config = function()
      require("telescope").load_extension "macros"
    end,
    keys = {
      { "<leader>tm", "<cmd>Telescope macros<cr>", desc = "Manage  macros" },
    },
  },
}
