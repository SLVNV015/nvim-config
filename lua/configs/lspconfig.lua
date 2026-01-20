require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "gopls", "tailwindcss", "dockerls", "prismals" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
