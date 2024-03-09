return {
  {
    "nmac427/guess-indent.nvim",
    event = "InsertEnter",
    opts = {},
  },

  {
    "axelvc/template-string.nvim",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python", "vue", "svelte" },
    opts = {},
  },

  ----------------------------------
  {
    "barrett-ruth/live-server.nvim",
    cmd = {
      "LiveServerStart",
      "LiveServerStop",
    },
    opts = {},
  },

  ----------------------------------
  {
    "nkakouros-original/numbers.nvim",
    event = "InsertEnter",
    opts = {
      excluded_filetypes = {
        "alpha",
        "neo-tree",
        "mason",
        "lazy",
      },
    },
  },

  ----------------------------------
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   event = "VeryLazy",
  --   opts = {
  --     filetypes = {
  --       "*", -- Highlight all files, but customize some others.
  --       "!lazy",
  --     },
  --     user_default_options = {
  --       names = false, -- "Name" codes like Blue or blue
  --       RRGGBBAA = true, -- #RRGGBBAA hex codes
  --       rgb_fn = true, -- CSS rgb() and rgba() functions
  --       hsl_fn = true, -- CSS hsl() and hsla() functions
  --       css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  --       css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  --       -- Available modes for `mode`: foreground, background,  virtualtext
  --       mode = "background", -- Set the display mode.
  --       -- Available methods are false / true / "normal" / "lsp" / "both"
  --       -- True is same as normal
  --       tailwind = true, -- Enable tailwind colors
  --       -- parsers can contain values used in |user_default_options|
  --       sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
  --       virtualtext = "■",
  --     },
  --   },
  -- },

  ----------------------------------
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
        ignore_lsp = { "efm", "copilot" },
        exclude_dirs = { "~/.config/nvim/*" },
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = "global",
        datapath = vim.fn.stdpath("data"),
      })
    end,
  },
}
