return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- важно
    build = vim.fn.has "win32" ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",

      -- опционально, но я рекомендую для удобного input UI:
      "stevearc/dressing.nvim",
      -- или если ты юзаешь snacks.nvim, можно его вместо dressing
      -- "folke/snacks.nvim",
    },
    opts = {
      -- Avante по умолчанию в agentic-режиме (это и есть “жир”)
      -- Если вдруг будет слишком автономно — можно переключить в legacy:
      -- mode = "legacy",

      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          -- model = "claude-sonnet-4-20250514",
          -- model = "claude-haiku-4-5-20251001",
          timeout = 30000,
          -- api_key_name по умолчанию смотрит на env var.
          -- Если хочешь явно:
          api_key_name = "ANTHROPIC_API_KEY",

          -- разумные лимиты чтобы не улетать по токенам в жирных репах:
          extra_request_body = {
            temperature = 0.2,
            max_tokens = 4096,
          },
        },

        ["claude-sonnet"] = {
          __inherited_from = "claude",
          -- поставь ТОЧНОЕ имя модели из твоего списка (у тебя он уже работает)
          model = "claude-sonnet-4-20250514",
          display_name = "Claude Sonnet (tests/refactor)",
          extra_request_body = {
            temperature = 0.2,
            max_tokens = 4096,
          },
        },

        ["claude-haiku"] = {
          __inherited_from = "claude",
          -- тоже возьми точное имя из твоего /v1/models
          model = "claude-haiku-4-5-20251001",
          display_name = "Claude Haiku (comments/quick)",
          extra_request_body = {
            temperature = 0.1,
            max_tokens = 8192,
          },
        },
      },

      -- Инструкции по проекту можно хранить в файле в корне проекта:
      -- очень удобно для разных реп (Go/Node/Next).
      instructions_file = "avante.md", -- Avante будет искать его в проекте :contentReference[oaicite:3]{index=3}

      -- Глобальные правила (по умолчанию для всех проектов)
      -- (это именно “system_prompt”, Avante поддерживает кастомизацию промптов/правил) :contentReference[oaicite:4]{index=4}
      system_prompt = [[
Ты помощник разработчика. Всегда отвечай на русском.
Не генерируй тесты пачкой. Генерируй тесты только по запросу пользователя и строго для текущего файла/выделения.
При генерации тестов: сначала выясни/выведи (если видно по репе) используемый стек тестирования (Jest/Vitest/RTL/Go test), затем следуй ему.
      ]],

      -- Маппинги Avante (важно: Avante сам экспонирует публичный API: avante.api
      -- и рекомендует мапить ask/edit/refresh через него) :contentReference[oaicite:5]{index=5}
      mappings = {
        ask = "<leader>ma",
        edit = "<leader>me",
        refresh = "<leader>mr",
      },

      -- Не авто-добавлять кучу файлов из файлового дерева (если используешь расширения)
      selector = {
        exclude_auto_select = { "NvimTree", "neo-tree" },
      },
    },
  },
}
