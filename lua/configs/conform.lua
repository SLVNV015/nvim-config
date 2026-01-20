local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    go = { "gofmt", "goimports" },
    html = { "prettier" },
  },

  -- format_on_save = {
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
