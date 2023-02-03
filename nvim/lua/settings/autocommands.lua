-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
      command = "silent! lua vim.highlight.on_yank()",
      group = yankGrp,
})

--Don't autostart new comment line after a comment
vim.api.nvim_create_autocmd({ "BufEnter" }, {
      callback = function()
            vim.cmd("set formatoptions-=cro")
            vim.cmd("highlight statusline ctermfg=NONE ctermbg=NONE guifg=#525252 guibg=NONE")
      end,
})
