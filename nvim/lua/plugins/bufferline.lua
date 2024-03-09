return {
  {
    "akinsho/bufferline.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    enabled = true,
    keys = {
      { "te", "<cmd>:tabedit<cr>", desc = "New Tab" },
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Tab next" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Tab prev" },
    },
    opts = function()
      -- local colors = require("kanagawa.colors").setup()
      -- local palette_colors = colors.palette
      -- local p = require("rose-pine.palette")
      return {
        options = {
          mode = "tabs",
          always_show_bufferline = false,
          show_buffer_close_icons = false,
          show_close_icon = false,
          color_icons = true,
        },
        -- highlights = {
        --
        --   --Rose Pine
        --   fill = {
        --     bg = p.surface,
        --   },
        --   separator = {
        --     fg = p.surface,
        --     bg = p.base,
        --   },
        --   separator_selected = {
        --     fg = p.surface,
        --   },
        --
        --   buffer_selected = {
        --     fg = p.text,
        --     bold = true,
        --     italic = true,
        --   },
        --   background = {
        --     bg = p.base,
        --     fg = p.muted,
        --   },
        --   modified = {
        --     bg = p.base,
        --   },
        --   --Kanagawa theme
        --   -- fill = {
        --   -- 	bg = palette_colors.sumiInk2,
        --   -- },
        --   -- separator = {
        --   -- 	fg = palette_colors.sumiInk2,
        --   -- 	bg = palette_colors.sumiInk0,
        --   -- },
        --   -- separator_selected = {
        --   -- 	fg = palette_colors.sumiInk2
        --   -- },
        --   -- background = {
        --   -- 	bg = palette_colors.sumiInk0,
        --   -- 	fg = palette_colors.fujiWhite
        --   -- },
        --   -- buffer_selected = {
        --   -- 	fg = palette_colors.fujiWhite,
        --   -- 	bold = true
        --   -- },
        --   -- modified = {
        --   -- 	bg = palette_colors.sumiInk0
        --   -- }
        --
        --   --Solarized theme
        --   -- separator = {
        --   --   fg = "#073642",
        --   --   bg = "#002b36",
        --   -- },
        --   -- separator_selected = {
        --   --   fg = "#073642",
        --   -- },
        --   -- background = {
        --   --   fg = "#657b83",
        --   --   bg = "#002b36",
        --   -- },
        --   -- buffer_selected = {
        --   --   fg = "#fdf6e3",
        --   --   bold = true,
        --   -- },
        --   -- fill = {
        --   --   bg = "#073642",
        --   -- },
        -- },
      }
    end,
  },
}
