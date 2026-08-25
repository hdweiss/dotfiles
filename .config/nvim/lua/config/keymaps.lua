-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- remove LazyVim's default window-nav mappings...
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")

-- ...then re-apply herdr-nvim-nav's, since this file loads last
require("herdr-nvim-nav").setup({
  with_tmux = nil,
  keymaps = {
    left = { "<C-h>", "<C-Left>" },
    down = { "<C-j>", "<C-Down>" },
    up = { "<C-k>", "<C-Up>" },
    right = { "<C-l>", "<C-Right>" },
  },
  socket_path = nil,
  cache_dir = nil,
  herdr_bin = nil,
  socket_timeout_ms = 150,
})
