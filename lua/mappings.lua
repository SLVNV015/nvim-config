require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

map({ "i", "s" }, "<mf>", function()
  if require("luasnip").expand_or_jumpable() then
    require("luasnip").expand_or_jump()
  end
end, { silent = true, desc = "LuaSnip jump forward" })

map({ "i", "s" }, "<mb>", function()
  if require("luasnip").jumpable(-1) then
    require("luasnip").jump(-1)
  end
end, { silent = true, desc = "LuaSnip jump backward" })
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

-- База (аналог твоих aa/an/ar)
map({ "n", "v" }, "<leader>ma", function()
  require("avante.api").ask()
end, { desc = "AI Ask (Avante)" })
map({ "n", "v" }, "<leader>me", function()
  require("avante.api").edit()
end, { desc = "AI Edit selection/block (Avante)" })
map({ "n", "v" }, "<leader>mr", function()
  require("avante.api").refresh()
end, { desc = "AI Refresh (Avante)" })

map("n", "<leader>mm", "<cmd>AvanteModels<cr>", { desc = "AI: models list" })

map("n", "<leader>ms", "<cmd>AvanteSwitchProvider claude-sonnet<cr>", { desc = "AI: use Sonnet" })
map("n", "<leader>mh", "<cmd>AvanteSwitchProvider claude-haiku<cr>", { desc = "AI: use Haiku" })
-- Быстрые “шорткаты” под твои частые кейсы
-- 1) Тест к текущему файлу (ты просил по одному — поэтому это только для текущего контекста)
map("n", "<leader>mt", function()
  require("avante.api").ask {
    prompt = "Сгенерируй unit-тесты для ЭТОГО файла. Следуй тестовому стеку проекта (Jest/Vitest/RTL и т.п.). Не делай пачку. Верни дифф/готовый файл теста и краткие шаги запуска.",
  }
end, { desc = "AI: generate tests for current file" })

-- 2) Тесты к выделенному коду (удобно для функций/хэндлеров)
map("v", "<leader>mT", function()
  require("avante.api").edit {
    prompt = "Сгенерируй unit-тесты (1 файл) для выделенного кода. Следуй тестовому стеку проекта. Комментарии в коде: EN+RU. Не делай пачку.",
  }
end, { desc = "AI: generate tests for selection" })

-- 3) Рефактор выделения без изменения поведения
map("v", "<leader>mf", function()
  require("avante.api").edit {
    prompt = "Сделай рефакторинг выделенного кода без изменения поведения. Упростить, улучшить читаемость, типы TS/Go сохранить корректными.",
  }
end, { desc = "AI: refactor selection" })

-- 4) Пояснить файл/ошибку (без правок)
map("n", "<leader>mx", function()
  require("avante.api").ask {
    prompt = "Объясни что делает этот файл и где могут быть баги/краевые случаи. Ответ на русском. Если предлагаешь правки — отдельным блоком.",
  }
end, { desc = "AI: explain current file" })
