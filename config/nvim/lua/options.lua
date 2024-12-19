require "nvchad.options"

local o = vim.o
local fn = vim.fn
local autogroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

o.cursorlineopt = "both" -- to enable cursorline!
o.cmdheight = 0

vim.filetype.add {
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
}

autogroup("bufcheck", { clear = true })
-- reload config file on change
autocmd("BufWritePost", {
  group = "bufcheck",
  pattern = vim.env.MYVIMRC,
  command = "silent source %",
})
-- autocmd("TextYankPost", {
--   group = "bufcheck",
--   pattern = "*",
--   callback = function()
--     fn.setreg("+", fn.getreg "*")
--   end,
-- })

autocmd("VimEnter", {
  command = ":silent !kitty @ set-spacing padding=0 margin=0",
})

autocmd("VimLeavePre", {
  command = ":silent !kitty @ set-spacing padding=20 margin=10",
})

autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = false
  end,
})
