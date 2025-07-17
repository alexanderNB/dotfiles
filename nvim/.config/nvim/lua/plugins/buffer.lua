return {
    {
        "kwkarlwang/bufjump.nvim",
        opts = {
            forward_key = "I",
            backward_key = "E",
            on_success = function()
                vim.cmd [[execute "normal! g`\"zz"]]
            end,
        },
    },
}
