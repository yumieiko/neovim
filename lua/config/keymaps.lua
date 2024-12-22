
vim.keymap.set({ "n", "x" }, "vp", '"+y') -- copy from system clipboard
vim.keymap.set({ "n", "x" }, "vv", '"+p') -- paste from system clipboard
-- Delete without changing the registers
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set("n", "<leader>o", function() vim.cmd[[:NERDTreeToggle]]
end)
vim.keymap.set("n", "<leader>e", function() vim.cmd[[:NERDTreeFocus]] end)
vim.keymap.set("n", "]b", function() vim.cmd[[:BufferNext]] end)
vim.keymap.set("n", "[b", function() vim.cmd[[:BufferPrevious]] end)
-- comment code
