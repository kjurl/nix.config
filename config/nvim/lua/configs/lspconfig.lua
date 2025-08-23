-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local status, schemastore = pcall(require, "schemastore")

local flake_path = os.getenv "HOME" .. "/.nixos-config"
local getFlake = '(builtins.getFlake "' .. flake_path .. '")'
local fromFlake = {
  nixpkgs = table.concat({ "import", getFlake .. ".inputs.nixpkgs", "{ }" }, " "),
  options = getFlake .. ".nixosConfigurations.di15-7567g.options",
  hm_options = getFlake .. ".nixosConfigurations.di15-7567g.options.hm.value",
}

---@type table<string, table>
local servers = {
  nixd = {
    settings = {
      ["nixd"] = {
        formatting = { command = { "nixfmt" } },
        nixpkgs = { expr = fromFlake.nixpkgs },
        options = {
          nixos = { expr = fromFlake.options },
          home_manager = { expr = fromFlake.hm_options },
        },
      },
    },
  },
  -- "lua_ls",
  -- bash
  bashls = {},
  -- config
  jsonls = status and {
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
        validate = { enable = true },
      },
    },
  } or {},
  yamlls = status and {
    settings = {
      yaml = {
        validate = true,
        schemaStore = { enable = false, url = "" },
        schemas = schemastore.yaml.schemas(),
      },
    },
  } or {},
  taplo = {},
  -- webdev
  html = {},
  cssls = {},
  ts_ls = {
    init_options = {
      preferences = {
        disableSuggestions = true,
      },
    },
    commands = {
      OrganizeImports = {
        function()
          local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
          }
          vim.lsp.buf.execute_command(params)
        end,
        description = "Organize Imports",
      },
    },
  },
  -- python
  pyright = {},
  -- rust
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        diagnostics = { enable = true },
        cargo = { features = "all" },
        completion = { privateEditable = { enable = true } },
        check = { command = "clippy" },
      },
    },
  },
}

for server_name, config in pairs(servers) do
  if type(config) == "table" then
    config.on_attach = nvlsp.on_attach
    config.on_init = nvlsp.on_init
    config.capabilities = nvlsp.capabilities
    lspconfig[server_name].setup(config)
  else
    -- Print a warning if the server is skipped
    print("Skipping setup for " .. server_name .. " due to invalid config.")
  end
end
