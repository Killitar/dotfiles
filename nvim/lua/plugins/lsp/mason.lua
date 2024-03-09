return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  cmd = "Mason",
  keys = { { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    -- local mason_nullls = require("mason-null-ls")

    local icons = {
      ui = require("helpers.icons").get("ui", true),
      misc = require("helpers.icons").get("misc", true),
    }

    mason.setup({
      ui = {
        icons = {
          package_pending = icons.ui.Modified_alt,
          package_installed = icons.ui.Check,
          package_uninstalled = icons.misc.Ghost,
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "tsserver",
        "cssls",
        "html",
        "tailwindcss",
        "volar",
        "jsonls",
        "marksman",
        "pyright",
      },
      automatic_installation = true,
    })
  end,
}
