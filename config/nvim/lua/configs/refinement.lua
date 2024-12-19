return {
  format = {
    formatters_by_ft = {
      lua = { "stylua" },
      astro = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "fixjson" },
      typescript = { "prettierd" },
      python = { "isort", "black" },
      nix = { "nixfmt" },
    },

    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  lint = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    python = { "mypy" },
    nix = { "statix", "deadnix" },
  },
}
