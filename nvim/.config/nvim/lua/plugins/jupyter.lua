return {
    {

        "quarto-dev/quarto-nvim",
        ft = { "quarto", "markdown" },
        dependencies = {
            "jmbuhr/otter.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            local quarto = require "quarto"
            quarto.setup {
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
            }
        end,
    },
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        build = ":UpdateRemotePlugins",
        init = function()
            -- this is an example, not a default. Please see the readme for more configuration options
            vim.g.molten_output_win_max_height = 12
            --
            -- I find auto open annoying, keep in mind setting this option will require setting
            -- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
            vim.g.molten_auto_open_output = false

            -- this guide will be using image.nvim
            -- Don't forget to setup and install the plugin if you want to view image outputs
            vim.g.molten_image_provider = "image.nvim"

            -- optional, I like wrapping. works for virt text and the output window
            vim.g.molten_wrap_output = true

            vim.g.molten_show_mimetype_debug = false

            -- Output as virtual text. Allows outputs to always be shown, works with images, but can
            -- be buggy with longer images
            vim.g.molten_virt_text_output = false

            -- this will make it so the output shows up below the \`\`\` cell delimiter
            vim.g.molten_virt_lines_off_by_1 = false
        end,
    },
    {
        "GCBallesteros/jupytext.nvim",
        -- config = true,
        -- Depending on your nvim distro or config you may need to make the loading not lazy
        lazy = false,

        opts = {
            style = "markdown",
            output_extension = "md",
            force_ft = "markdown",
        },
        -- config = function()
        --     require("jupytext").setup {
        --         -- custom_language_formatting = {},
        --     }
        -- end,
    },
    {
        "3rd/image.nvim",
    },
}
