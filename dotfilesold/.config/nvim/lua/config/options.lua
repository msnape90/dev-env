-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- example
--
-- vim.keymap.set(
--   "n",
--   "<leader>sx",
--   require("telescope.builtin").resume,
--   { noremap = true, silent = true, desc = "Resume" }
-- )
--
-- vim.opt.winbar = "%=%m %f"
vim.opt.mouse = ""
-- this is required or wezterm crashes on copy
vim.o.clipboard = "unnamedplus"
