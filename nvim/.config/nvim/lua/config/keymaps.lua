-- Keymaps are automaticalLY loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
vim.keymap.set("x", "(", [[c()<Esc>hpvi(]], { desc = "surround" })
vim.keymap.set("x", "{", [[c{}<Esc>hpvi{]], { desc = "surrund" })
vim.keymap.set("x", "[", [[c\[\]<Esc>hpvi\[]], { desc = "surround" })
vim.keymap.set("x", '"', [[c""<Esc>hpvi"]], { desc = "surround" })
vim.keymap.set("x", "'", [[c''<Esc>hpvi']], { desc = "surround" })
vim.keymap.set("x", "|", [[c||<Esc>hpvi|]], { desc = "surround" })
-- vim.keymap.set("x", "<", [[c<><Esc>hpvi<]], { desc = "surround" })

-- vim.keymap.set("n", ";", [[.]], { desc = "repeat last command" })
-- Swap `.` and `;` in normal and visual mode
-- vim.keymap.set({ "n", "v" }, ";", ".", { noremap = true })

vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

vim.keymap.set("n", "<localleader>ms", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })
vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })

local runner = require("quarto.runner")
vim.keymap.set("n", "<localleader>mm", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<localleader>ma", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<localleader>ma", runner.run_below, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<localleader>mA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<localleader>ml", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<Localleader>m", runner.run_range, { desc = "run visual range", silent = true })

vim.keymap.set("n", "H", "<C-o>", { desc = "Previous jump" })
vim.keymap.set("n", "J", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "K", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "L", "<C-i>", { desc = "Next jump" })

vim.keymap.set("i", "<Esc>", "<Esc>m`")

local function jump_with_mark(key)
    return function()
        local count = vim.v.count
        if count > 0 then
            -- Feed both "m'" and the counted motion, e.g. "m'5j"
            local keys = "m'" .. count .. key
            -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", false)
            vim.api.nvim_feedkeys(keys, "n", true)
            return "" -- nothing more to process
        end
        return key -- no count, just do normal motion
    end
end

vim.keymap.set("n", "j", jump_with_mark("j"), { expr = true, desc = "Smart j with jump" })
vim.keymap.set("n", "k", jump_with_mark("k"), { expr = true, desc = "Smart k with jump" })

-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

require("nvim-treesitter.configs").setup({
    ...,
    textobjects = {
        move = {
            enable = true,
            -- set_jumps = false, -- you can change this if you want.
            goto_next_start = {
                --- ... other keymaps
                ["<localleader>mj"] = { query = "@code_cell.inner", desc = "next code block" },
            },
            goto_next_end = {
                --- ... other keymaps
                ["<localleader>mJ"] = { query = "@code_cell.inner", desc = "next code block end" },
            },
            goto_previous_start = {
                --- ... other keymaps
                ["<localleader>mk"] = { query = "@code_cell.inner", desc = "previous code block" },
            },
            goto_previous_end = {
                --- ... other keymaps
                ["<localleader>mK"] = { query = "@code_cell.inner", desc = "previous code block end" },
            },
        },
        select = {
            enable = true,
            -- lookahead = true, -- you can change this if you want
            keymaps = {
                --- ... other keymaps
                ["im"] = { query = "@code_cell.inner", desc = "in block" },
                ["am"] = { query = "@code_cell.outer", desc = "around block" },
            },
        },
        swap = { -- Swap only works with code blocks that are under the same
            -- markdown header
            enable = true,
            swap_next = {
                --- ... other keymap
                ["<leader>msj"] = "@code_cell.outer",
            },
            swap_previous = {
                --- ... other keymap
                ["<leader>msk"] = "@code_cell.outer",
            },
        },
    },
})
