return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    -- "ray-x/lsp_signature.nvim",
    { "smjonas/inc-rename.nvim", cmd = "IncRename", opts = {} },
    "mason.nvim",
    { "folke/neodev.nvim", opts = {} },
    { "pmizio/typescript-tools.nvim", opts = {} },
  },
  config = function()
    -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
    require("neodev").setup({})

    local lspconfig = require("lspconfig")

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local on_attach = function(_, bufnr)
      local lsp_map = require("helpers.keys").lsp_map

      lsp_map("gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
      lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")
      lsp_map("<C-j>", vim.diagnostic.goto_next, bufnr, "Move to the next diagnostic")
      lsp_map("gl", vim.diagnostic.open_float, bufnr, "Show line diagnostics")
      lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Doc")
      -- lsp_map("gh", "<Cmd>Lspsaga lsp_finder<CR>", bufnr, "Find the symbol's definition")
      lsp_map("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
      lsp_map("gd", function()
        require("telescope.builtin").lsp_definitions({ reuse_win = true })
      end, bufnr, "Go to definition")
      lsp_map("gp", function()
        require("telescope.builtin").lsp_implementations({ reuse_win = true })
      end, bufnr, "Goto Implementation")

      vim.keymap.set("n", "gr", function()
        return ":IncRename" .. " " .. vim.fn.expand("<cword")
      end, { expr = true })
      -- lsp_map("gr", ":IncRename " .. vim.fn.expand("<cword>"), bufnr, "Rename")
      --
      -- -- code action
      lsp_map("<leader>ca", vim.lsp.buf.code_action, bufnr, "Code actions")
      -- lsp_map("ca", "<cmd>Lspsaga code_action<CR>", bufnr, "Code actions")
      --
    end

    local config = {
      virtual_text = true,
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }
    vim.diagnostic.config(config)

    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- configure lua server
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
          workspace = {
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })

    -- -- configure ts/js server
    -- lspconfig["tsserver"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })
    --

    lspconfig["eslint"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        workingDirectory = { mode = "auto" },
      },
    })

    -- configure python server
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure emmet language server
    lspconfig["emmet_language_server"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    -- configure css server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure tailwindcss server
    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure vuejs server
    lspconfig["volar"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- configure svelte server
    lspconfig["svelte"].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            if client.name == "svelte" then
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
            end
          end,
        })
      end,
    })

    -- configure astro server
    lspconfig["astro"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
