return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      -- чтобы меню не прыгало и ничего не было выбрано заранее
      opts.preselect = cmp.PreselectMode.None
      opts.completion = opts.completion or {}
      opts.completion.completeopt = "menu,menuone,noinsert"

      -- если у тебя Enter подтверждает “само”, это тоже важно:
      -- (в NvChad обычно уже ок, но лучше зафиксировать)
      opts.mapping = opts.mapping or {}
      opts.mapping["<CR>"] = cmp.mapping.confirm({ select = false })

      return opts
    end,
  },
}
