-- bootstrap lazy.nvim, LazyVim and your plugins

require("config.lazy")
require("plugins.plugin_options.telescope")
require("plugins.plugin_options.snacks")

vim.cmd("colorscheme arctic")

-- vim.lsp.config("basedpyright", {
--     cmd = { "basedpyright-langserver", "--stdio" },
-- })
