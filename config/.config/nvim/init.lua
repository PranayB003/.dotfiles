-- share plugins with vim
vim.cmd("set runtimepath^=~/.vim runtimepath+=~/.vim/after")
vim.cmd("let &packpath = &runtimepath")
-- load vim configuration
vim.cmd.source("~/.vim/vimrc")
-- override some config options from vimrc
vim.cmd.set("noshowmode")

require("keybindings")
require("plugins")
