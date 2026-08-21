return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the below with your desired setup
  opts = {
    workspaces = {
     {
        name = "Documents",
        path = "~/Documents",
      },
    },
  },
}
