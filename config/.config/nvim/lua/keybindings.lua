-- toggle the tree viewer
vim.keymap.set("n", "<Leader>tt", ":NvimTreeFindFileToggle<CR>")
-- Open Telescope
vim.keymap.set("n", "<Leader>tl", ":Telescope<CR>")

-- move to the next/previous tab
vim.keymap.set("n", "<Esc><Tab>", ":tabnext<CR>")
vim.keymap.set("n", "<Esc><S-Tab>", ":tabprevious<CR>")
