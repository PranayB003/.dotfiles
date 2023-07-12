-- toggle the tree viewer
vim.keymap.set("n", "<Leader>tt", ":NvimTreeFindFileToggle<CR>")
-- focus the tree viewer
vim.keymap.set("n", "<Leader>tf", ":NvimTreeOpen | NvimTreeFocus<CR>")

-- move to the next/previous tab
vim.keymap.set("n", "<Esc><Tab>", ":tabnext<CR>")
vim.keymap.set("n", "<Esc><S-Tab>", ":tabprevious<CR>")
