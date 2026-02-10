require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")
-- scroll
map("i", "<A-z>", "<C-o>zz", { desc = "Center screen in insert mode" })
map("i", "<A-j>", "<C-o><C-e>", { desc = "Scroll down" })
map("i", "<A-k>", "<C-o><C-y>", { desc = "Scroll up" })

map("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Open NvimTree" })
map("n", "J", "j", { desc = "move down" })
map("v", "J", "j", { desc = "Move down" })
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
map("n", "<A-sj>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- debugger actions
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
end, { expr = true, silent = true, desc = "Codeium: accept next word suggestion" })

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

-- map telescope

local function visual_selection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg "v"
  vim.fn.setreg("v", {})
  return text
end

map("v", "<leader>fg", function()
  local selection = visual_selection()
  require("telescope.builtin").live_grep { default_text = selection }
end, { desc = "Search selection" })

map("v", "<leader>fz", function()
  local selection = visual_selection()
  require("telescope.builtin").current_buffer_fuzzy_find { default_text = selection }
end, { desc = "Search selection" })

map("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Resume last telescope" })
map("n", "db", "<cmd>Telescope delete_buffer<cr>", { desc = "Resume last telescope" })
