local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
  b.code_actions.refactoring,
  b.code_actions.statix,
  -- b.diagnostics.actionlint,
  -- b.diagnostics.deadnix,
  -- b.diagnostics.dotenv_linter,
  -- b.diagnostics.mypy.with {
  --   -- extra_args = function()
  --   --   local virtual = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_DEFAULT_ENV" or "/usr"
  --   --   return { "--python-executable", virtual .. "/bin/python" }
  --   -- end,
  --   only_local = ".venv/bin/",
  -- },
  -- b.diagnostics.selene,
  -- b.diagnostics.statix,
  -- b.formatting.stylua.with {
  --   extra_args = { "--config-path", vim.fn.expand "~/.config/nvim/.stylua.toml" },
  -- },
  -- b.diagnostics.write_good.with {
  --   diagnostics_postprocess = function(diagnostic)
  --     diagnostic.severity = diagnostic.message:find "really"
  --         and vim.diagnostic.severity["ERROR"]
  --       or vim.diagnostic.severity["WARN"]
  --   end,
  -- },
  -- -- bash
  -- b.formatting.shfmt,
  -- -- b.code_actions.shellcheck.with {
  -- --   diagnostic_config = {
  -- --     -- see :help vim.diagnostic.config()
  -- --     underline = true,
  -- --     virtual_text = false,
  -- --     signs = true,
  -- --     update_in_insert = false,
  -- --     severity_sort = true,
  -- --   },
  -- --   -- will show code and source name
  -- --   diagnostics_format = "[#{c}] #{m} (#{s})",
  -- -- },
  -- -- webdev
  -- b.formatting.prettier.with {
  --   extra_filetypes = { "astro", "toml" },
  -- },
  -- -- b.diagnostics.eslint.with {
  -- --   condition = function(utils)
  -- --     return utils.root_has_file "package.json"
  -- --       or utils.root_has_file ".eslintrc.json"
  -- --       or utils.root_has_file ".eslintrc.js"
  -- --   end,
  -- --   filter = function(diagnostic)
  -- --     return diagnostic.code ~= "prettier/prettier"
  -- --   end,
  -- -- },
  -- -- python
  -- b.formatting.black,
  -- b.formatting.isort,
}

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup {
  debug = true,
  sources = sources,
  -- on_attach = function(client, bufnr)
  --   if client.supports_method "textDocument/formatting" then
  --     vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         vim.lsp.buf.format { async = false }
  --       end,
  --     })
  --   end
  -- end,
}
