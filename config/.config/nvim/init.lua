-- load vim configuration
vim.cmd.source("~/.vimrc")
-- override some config options from vimrc
vim.cmd.set("noshowmode")

require("core.keybindings")
require("core.plugins")
require("core.plugin_config")
