local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"
--rust
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilites = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ['rust_analyzer'] = {
      cargo = {
        allFeatures = true
      },
      diagnostics = {
        enable = true,
      }
    },
  }
})

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilites = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  }
}
lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { 'utf-8', 'utf-16' },
  },
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  single_file_support = true,
  settings = {
    clangd = {
      compilationDatabasePath = "",
      args = {
        "--header-insertion=never", -- adjust as needed
        "--include-directory=/opt/homebrew/include/tree_sitter",
      }
    }
  }
}
lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json"),
  settings = {
    format = { enable = true },   -- Enable formatting
    lintTask = { enable = true }, -- Run lint task
  },
  handlers = {
    ["eslint/noLibrary"] = function()
      vim.notify("[lspconfig] Unable to find ESLint library.", vim.log.levels.WARN)
      return {}
    end,
  },
}
