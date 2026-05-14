-- Disable netrw before runtime plugins load; nvim-tree replaces it.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- load vim configuration
vim.cmd.source("~/.vim/vimrc")
-- Load only the legacy Oracle gf helper; do not source all ~/.vim/plugin files.
local ora_goto = vim.fn.expand("~/.vim/plugin/ora_goto.vim")
if vim.fn.filereadable(ora_goto) == 1 then
  vim.cmd.source(ora_goto)
end
-- override some config options from vimrc
vim.cmd.set("noshowmode")

require("keybindings")
require("plugins")
