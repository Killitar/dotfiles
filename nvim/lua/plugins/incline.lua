return {
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    opts = function()
      local colors = require("solarized-osaka.colors").setup()
      return {
        highlight = {
          groups = {
            IncLineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            IncLineNormalNC = { guibg = colors.base03, guifg = colors.violet500 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_colors(filename)

          if vim.bo[props.buf].modified then
            filename = "[+]" .. filename
          end

          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      }
    end,
  },
}
