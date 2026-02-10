require "nvchad.options"

-- add yours here!

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldenable = true
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
