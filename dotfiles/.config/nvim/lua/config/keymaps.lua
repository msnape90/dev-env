-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set(
  "n",
  "<leader>tc",
  ":setlocal <C-R>=&conceallevel ? 'conceallevel=0' : 'conceallevel=2'<CR><CR>",
  { desc = "[T]oggle [C]onceallevel" }
)

vim.keymap.set("n", "<leader>pa", ":ProjectRoot<CR>", { desc = "[P]roject [A]dd" })

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode with jj" })

vim.keymap.set("n", "<leader>fs", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "[f]ind tmux-[s]ession" })
