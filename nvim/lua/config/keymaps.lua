-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- map({ "i", "x", "n", "s" }, "<leader>w", "<cmd>w<cr><esc>", { desc = "Save file" })
map({ "x", "n", "s" }, "<leader>w", "<cmd>w<cr><esc>", { desc = "Save file" })
vim.keymap.set("n", "\\", "gcc", { desc = "Toggle comment", silent = true, remap = true })
vim.keymap.set("v", "\\", "gc", { desc = "Toggle comment", silent = true, remap = true })

-- windows
-- vim.keymap.del("n", "<leader>ww")
vim.keymap.del("n", "<leader>wd")
-- vim.keymap.del("n", "<leader>w-")
-- vim.keymap.del("n", "<leader>w|")
vim.keymap.del("n", "<leader>wm")
map("n", "<leader>Ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<leader>Wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>W-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>W|", "<C-W>v", { desc = "Split Window Right", remap = true })
-- map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
-- map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
