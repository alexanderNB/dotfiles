vim.pack.add { Gh "kwkarlwang/bufjump.nvim" }
require("bufjump").setup {
    forward_key = "R",
    backward_key = "E",
    on_success = function()
        vim.cmd [[execute "normal! g`\"zz"]]
    end,
}
