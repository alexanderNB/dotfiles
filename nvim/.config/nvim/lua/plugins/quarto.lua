return {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
        "jmbuhr/otter.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local quarto = require("quarto")
        quarto.setup({
            lspFeatures = {
                languages = { "python" },
                chunks = "all",
                diagnostics = {
                    enabled = true,
                    triggers = { "BufWritePost" },
                },
                completion = {
                    enabled = true,
                },
            },
            keymap = {
                -- hover = "H",
                -- definition = "gd",
                -- rename = "<leader>rn",
                -- references = "gr",
                -- format = "<leader>gf",
            },
            codeRunner = {
                enabled = true,
                default_method = "molten",
            },
        })
    end,
}
