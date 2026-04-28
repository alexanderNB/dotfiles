vim.pack.add { Gh "folke/tokyonight.nvim" }

-- rainbow-delimiters.nvim
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
    -- plugins = {
    --     -- enable all plugins when not using lazy.nvim
    --     -- set to false to manually enable/disable plugins
    --     all = package.loaded.lazy == nil,
    --     -- uses your plugin manager to automatically enable needed plugins
    --     -- currently only lazy.nvim is supported
    --     auto = true,
    --     -- add any plugins here that you want to enable
    --     -- for all possible plugins, see:
    --     --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
    --     -- rainbow = true,
    -- },
}
vim.cmd.colorscheme "tokyonight-night"
