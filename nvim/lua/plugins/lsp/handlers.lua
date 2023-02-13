local M = {}

--------------------------------
-- Global Config for all servers
--------------------------------

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local cmp_status_ok, cmp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
    return
end

lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        cmp.default_capabilities()
    )

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
        end,
    })
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Displays hover information about the symbol under the cursor
        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

        -- Jump to the definition
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

        -- Jump to declaration
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

        -- Lists all the implementations for the symbol under the cursor
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

        --TroubleToggle
        bufmap('n', '<leader>ld', '<cmd>TroubleToggle<cr>')
    end
})


------------------------------
-- Specific LSP servers config
------------------------------

--NOTE: jdtls setup is done in ftplugin/java.lua file because it requires special arguments

lspconfig.lua_ls.setup({
    on_attach = function(client, bufnr)
        enable_format_on_save(client, bufnr)
    end,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },

            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
        },
    },
})
lspconfig.jsonls.setup({})
lspconfig.bashls.setup({})
lspconfig.emmet_ls.setup({
    filetypes = {
        "css",
        "django-html",
        "ejs",
        "handlebars",
        "hbs",
        "html",
        "htmldjango",
        "javascriptreact",
        "less",
        "pug",
        "sass",
        "scss",
        "typescriptreact",
        "vue"
    },
    init_options = {
        html = {
            options = {
                ["output.selfClosingStyle"] = "xhtml", -- Style of self-closing tags: html (`<br>`), xml (`<br/>`) or xhtml (`<br />`)
                ["jsx.enabled"] = true, -- Enable/disable JSX addon
                ["bem.enable"] = true
            },
        },
    }
})
lspconfig.omnisharp.setup({
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    analyze_open_documents_only = true,
})
lspconfig.tsserver.setup({})
lspconfig.volar.setup({})
lspconfig.pyright.setup({})
lspconfig.cssls.setup({})
lspconfig.marksman.setup({})

----------------------
-- Load Snippet Engine
----------------------
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require('luasnip.loaders.from_vscode').lazy_load()


----------------------------
-- Global Diagnostics Config
----------------------------

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn",  text = "" },
        { name = "DiagnosticSignHint",  text = "" },
        { name = "DiagnosticSignInfo",  text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_lines = false,
        virtual_text = false, -- Don't show diagnostics automatically
        signs = {
            active = signs,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "single",
            source = "always",
            header = "",
            prefix = "",
        },
        flags = {
            debounce_text_changes = 300, --Amount of miliseconds neovim will wait to send the next document update notification
        },
    }

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = 'rounded' }
        )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'rounded' }
        )

    vim.diagnostic.config(config)
end


return M
