-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.g.lazyvim_python_lsp = "basedpyright"

vim.lsp.enable("basedpyright")
vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                inlayHints = {
                    variableTypes = false,
                    callArgumentNames = false,
                    functionReturnTypes = false,
                    genericTypes = false,
                },
            },
        },
    },
})

-- @type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
    strategy = {
        [""] = "rainbow-delimiters.strategy.global",
        vim = "rainbow-delimiters.strategy.local",
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
    },
    priority = {
        [""] = 110,
        lua = 210,
    },
    highlight = {
        "RainbowDelimiter1",
        "RainbowDelimiter2",
        "RainbowDelimiter3",
    },
}

vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

-- require("config.snacks")
-- require("config.ui")
