require("nvchad.configs.lspconfig").defaults()

-- 1. Убираем "ts_ls" из общего массива, чтобы настроить его отдельно
local servers = { "html", "cssls", "gopls", "tailwindcss", "dockerls", "prismals", "sqls", "buf_ls", "clangd" }
vim.lsp.enable(servers)

-- 2. Настраиваем ts_ls под чистый ESM (nodenext)
vim.lsp.config("ts_ls", {
  init_options = {
    hostInfo = "neovim",
    preferences = {
      includeCompletionsForModuleExports = true, -- Искать автоимпорты по всем пакетам
      includeCompletionsWithImportStatements = true, -- Показывать варианты, даже если нет импорта в файле
      importModuleSpecifierPreference = "non-relative",
    },
  },
  settings = {
    typescript = {
      suggest = {
        -- Включаем автоимпорты на полную мощность
        autoImports = true,
        completeFunctionCalls = true,
      },
      preferences = {
        -- КРИТИЧНО ДЛЯ ESM: заставляет ts_ls автоматически подставлять .js / .ts расширения файлов
        importModuleSpecifierEnding = "js",
        -- Предпочитать абсолютные пути (или non-relative, зависит от вашего стиля)
        importModuleSpecifierPreference = "non-relative",
        -- Позволяет искать автоимпорты по всем экспортам в node_modules
        includeCompletionsForModuleExports = true,
      },
    },
    javascript = {
      suggest = {
        autoImports = true,
      },
      preferences = {
        importModuleSpecifierEnding = "js",
        importModuleSpecifierPreference = "non-relative",
        includeCompletionsForModuleExports = true,
      },
    },
  },
})

-- 3. Активируем настроенный ts_ls
vim.lsp.enable "ts_ls"
