return {
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        enabled = true,
        languages = {
          javascript = { template = { annotation_convention = "jsdoc" } },
          typescript = { template = { annotation_convention = "tsdoc" } },
          go = { template = { annotation_convention = "godoc" } },
        },
      }
    end,
  },
}
