require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", { desc = "DAP Continue" })
map("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", { desc = "DAP Step Over" })
map("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", { desc = "DAP Step Into" })
map("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", { desc = "DAP Step Out" })
map("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
map(
  "n",
  "<leader>B",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Conditional Breakpoint" }
)
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP code action" })
-- Windsurf/Codeium (insert mode) via Alt
map("i", "<M-p>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true, desc = "Codeium: accept suggestion" })

map("i", "<M-q>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true, desc = "Codeium: clear suggestion" })

-- cycle: Alt-h / Alt-l
map(
  "i",
  "<M-1>",
  "<Cmd>call codeium#CycleCompletions(-1)<CR>",
  { silent = true, desc = "Codeium: previous suggestion" }
)
map("i", "<M-2>", "<Cmd>call codeium#CycleCompletions(1)<CR>", { silent = true, desc = "Codeium: next suggestion" })

map("i", "<M-w>", function()
  return vim.fn["codeium#AcceptNextWord"]()
end, { expr = true, silent = true, desc = "Codeium: accept next word" })

map("i", "<M-t>", "<Cmd>call codeium#Complete()<CR>", { silent = true, desc = "Codeium: trigger suggestion" })

map("i", "<M-r>", function()
  return vim.fn["codeium#AcceptNextLine"]()
end, { expr = true, silent = true, desc = "Codeium: accept next line" })
-- windows mappings
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

map("n", "<leader>gd", function()
  require("neogen").generate()
end, { desc = "Generate docstring" })
