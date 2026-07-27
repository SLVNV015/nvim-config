return {
  "stevearc/conform.nvim",
  event = 'BufWritePre', -- Форматирование при сохранении
  opts = {
    formatters_by_ft = {
      sql = { "sleek" }, -- Используем sleek для sql
    },
    -- Если хочешь форматировать только вручную, убери 'format_on_save'
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
