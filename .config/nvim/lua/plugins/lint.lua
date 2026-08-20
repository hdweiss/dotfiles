return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", "~/.config/markdownlint-cli2/config.jsonc", "--" },
        },
      },
    },
  },
}
