-- /home/archnb/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/ui.lua
return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
        { "<C-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "<C-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
}
