return {
    {
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
        "folke/tokyonight.nvim",

        dependencies = { "https://github.com/HiPhish/rainbow-delimiters.nvim" },
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("tokyonight").setup {
                styles = {
                    comments = {
                        italic = false,
                    }, -- Disable italics in comments
                },
                -- on_colors = function(colors)
                --     colors.Comment = "#FFFFFF"
                -- end,
                -- on_highlight = function(highlight, colors)
                --     highlight.Comment = "#FFFFFF"
                -- end,
                plugins = {
                    -- enable all plugins when not using lazy.nvim
                    -- set to false to manually enable/disable plugins
                    all = package.loaded.lazy == nil,
                    -- uses your plugin manager to automatically enable needed plugins
                    -- currently only lazy.nvim is supported
                    auto = true,
                    -- add any plugins here that you want to enable
                    -- for all possible plugins, see:
                    --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
                    rainbow = true,
                },
            }
            vim.cmd.colorscheme "tokyonight-night"
        end,
    },
    { "rose-pine/neovim", name = "rose-pine" },
    -- { "HiPhish/rainbow-delimiters.nvim" },
}
