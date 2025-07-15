return {
    {
        "kwkarlwang/bufjump.nvim",
        opts = {
            forward_key = "K",
            backward_key = "J",
            on_success = function()
                vim.cmd [[execute "normal! g`\"zz"]]
            end,
        },
    },
}
