return {
  {
    "craftzdog/solarized-osaka.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        hl.LazyNormal = { bg = c.bg }
        hl.MasonNormal = { bg = c.bg }
        hl.TroubleNormal = { bg = c.bg }
        hl.MiniCursorword = { bg = c.violet900 }
        hl.MiniCursorwordCurrent = { bg = c.violet900 }
        -- hl.Visual = { bg = c.base02, reverse = false }
      end,
    },
  },

  {
    "oxfist/night-owl.nvim",
    enabled = false,
    lazy = false,
    config = function()
      vim.cmd.colorscheme("night-owl")

      require("night-owl").setup({
        transparent_background = true,
      })
    end,
  },

  ----------------------------------
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    opts = {
      compile = false,
      transparent = true,
      keywordStyle = { italic = false },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          EndOfBuffer = { fg = theme.ui.fg_dim },

          CursorLineNr = { bg = theme.ui.bg_m3 },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          LazyNormal = { bg = theme.ui.bg, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg, fg = theme.ui.fg_dim },

          TelescopePromptNormal = { bg = theme.ui.bg },
          TelescopeResultsNormal = { bg = theme.ui.bg },
          TelescopePreviewNormal = { bg = theme.ui.bg },

          BufferlineFileIcon = { bg = theme.ui.bg_m1 },
        }
      end,
    },
  },

  ----------------------------------
  {
    "rose-pine/neovim",
    enabled = false,
    name = "rose-pine",
    opts = {
      disable_float_background = true,
      disable_background = true,
      disable_italics = true,
      highlight_groups = {
        CursorLineNr = { bg = "overlay" },

        LazyNormal = { bg = "base" },
        MasonNormal = { bg = "base" },

        GitSignsAdd = { bg = "none" },
        GitSignsChange = { bg = "none" },
        GitSignsDelete = { bg = "none" },
      },
    },
  },

  ----------------------------------
  {
    "neanias/everforest-nvim",
    enabled = false,
    config = function()
      require("everforest").setup({
        transparent_background_level = 1,
        on_highlights = function(hl, palette)
          hl.NormalFloat = { fg = palette.none, bg = palette.none, sp = palette.none }
          hl.FloatBorder = { fg = palette.none, bg = palette.none }
          hl.LazyNormal = { bg = palette.bg0 }
          hl.MasonNormal = { bg = palette.bg0 }
        end,
      })
    end,
  },

  ----------------------------------

  ----------------------------------
  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = { floats = "transparent" },
        on_highlights = function(hl, c)
          hl.LazyNormal = { bg = c.bg_dark }
          hl.MasonNormal = { bg = c.bg_dark }
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  ----------------------------------
}
