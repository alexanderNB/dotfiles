vim.g.python3_host_prog = vim.fn.expand "~/.virtualenvs/neovim/bin/python3"
vim.g.mapleader = " "
vim.g.maplocalleader = " "


vim.o.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.commentstring = "// %s"

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"


-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"
-- Decrease update time
vim.o.updatetime = 250

vim.o.timeout = true
vim.o.timeoutlen = 10000

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.wrap = false
-- set.formatoptions:remove "o"

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- WARN: likely want to change this
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })

vim.keymap.set({ "n", "x", "o" }, "<leader>n", "<C-w>v<C-w><C-h>")
vim.keymap.set({ "n", "x", "o" }, "<leader>e", "<C-w>s")
vim.keymap.set({ "n", "x", "o" }, "<leader>r", "<C-w>s<C-w><C-k>")
vim.keymap.set({ "n", "x", "o" }, "<leader>o", "<C-w>v")

vim.keymap.set({ "n", "x" }, "s", "<Nop>")
vim.keymap.set({ "n", "x" }, "S", "<Nop>")

-- vim.keymap.del({ "n" }, "gd")
-- vim.keymap.del({ "n" }, "grr")
-- vim.keymap.del({ "n", "x" }, "gra")
-- vim.keymap.del({ "n" }, "gri")
-- vim.keymap.del({ "n" }, "grt")
-- vim.keymap.del({ "n" }, "grn")

vim.keymap.set({ "n" }, "<C-s>", "<cmd>w<CR>")

-- vim.keymap.set({ "x" }, "ig", "gg0oG$")

vim.keymap.set("i", "<Esc>", "<Esc>m`")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("n", "<M-n>", "2<C-w><")
vim.keymap.set("n", "<M-e>", "2<C-w>-")
vim.keymap.set("n", "<M-r>", "2<C-w>+")
vim.keymap.set("n", "<M-o>", "2<C-w>>")
vim.keymap.set("n", "<leader>=", "<C-w>=")

-- vim.keymap.set("n", "<leader>n", "<cmd>lua Snacks.picker.notifications()<CR>", { desc = "Notification History" })
-- vim.keymap.set("n", "<leader>n", function()
--     Snacks.picker.notifications()
-- end, { desc = "Notification History" })

-- vim.keymap.set({ "n", "i" }, "<C-i>", function()
--     vim.api.nvim_err_writeln "hello"
-- end)
-- vim.keymap.set({ "n", "i" }, "<Tab>", function()
--     vim.api.nvim_err_writeln "hi"
-- end)

vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

vim.keymap.set("n", "<localleader>ms", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })
vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })

vim.keymap.set("n", "N", "<C-o>", { desc = "Previous jump" })
-- vim.keymap.set("n", "J", ":bprevious<CR>", { desc = "Previous buffer" })
-- vim.keymap.set("n", "K", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "O", "<C-i>", { desc = "Next jump" })

vim.keymap.set({ "n", "x", "o" }, "n", "h")
vim.keymap.set({ "n", "x", "o" }, "e", "j")
vim.keymap.set({ "n", "x", "o" }, "r", "k")
vim.keymap.set({ "n", "x", "o" }, "o", "l")
vim.keymap.set({ "n", "x", "o" }, "h", "n")
vim.keymap.set({ "n", "x", "o" }, "j", "e")
vim.keymap.set({ "n", "x", "o" }, "k", "r")
vim.keymap.set({ "n", "x", "o" }, "l", "o")
vim.keymap.set({ "n", "x", "o" }, "H", "N")
vim.keymap.set({ "n", "x", "o" }, "J", "E")
vim.keymap.set({ "n", "x", "o" }, "K", "R")
vim.keymap.set({ "n", "x", "o" }, "L", "O")

vim.g.split_keyboard = true
vim.keymap.set("n", "<leader>tk", function()
    vim.g.split_keyboard = not vim.g.split_keyboard
    if vim.g.split_keyboard then
        vim.keymap.set({ "n", "x", "o" }, "n", "h")
        vim.keymap.set({ "n", "x", "o" }, "e", "j")
        vim.keymap.set({ "n", "x", "o" }, "r", "k")
        vim.keymap.set({ "n", "x", "o" }, "o", "l")
        vim.keymap.set({ "n", "x", "o" }, "h", "n")
        vim.keymap.set({ "n", "x", "o" }, "j", "e")
        vim.keymap.set({ "n", "x", "o" }, "k", "r")
        vim.keymap.set({ "n", "x", "o" }, "l", "o")
        vim.keymap.set({ "n", "x", "o" }, "H", "N")
        vim.keymap.set({ "n", "x", "o" }, "J", "E")
        vim.keymap.set({ "n", "x", "o" }, "K", "R")
        vim.keymap.set({ "n", "x", "o" }, "L", "O")
    else
        vim.keymap.del({ "n", "x", "o" }, "n")
        vim.keymap.del({ "n", "x", "o" }, "e")
        vim.keymap.del({ "n", "x", "o" }, "r")
        vim.keymap.del({ "n", "x", "o" }, "o")
        vim.keymap.del({ "n", "x", "o" }, "h")
        vim.keymap.del({ "n", "x", "o" }, "j")
        vim.keymap.del({ "n", "x", "o" }, "k")
        vim.keymap.del({ "n", "x", "o" }, "l")
        vim.keymap.del({ "n", "x", "o" }, "H")
        vim.keymap.del({ "n", "x", "o" }, "J")
        vim.keymap.del({ "n", "x", "o" }, "K")
        vim.keymap.del({ "n", "x", "o" }, "L")
    end
end)

-- Normal mode: swap insert and left
-- vim.keymap.set("n", "h", "i", { desc = "h enters insert mode" })
-- vim.keymap.set("n", "i", "h", { desc = "i moves left" })

-- Operator-pending and visual: swap inner text object prefix
-- vim.keymap.set({ "o", "x" }, "h", "i", { remap = true, desc = "h as text object inner" })
-- vim.keymap.set({ "o", "x" }, "i", "h", { remap = true, desc = "i as previous h" })

-- vim.keymap.set({ "n" }, "<M-n>", "J")
-- vim.keymap.set({ "n" }, "<M-e>", "<cmd>m+<CR>==")
-- vim.keymap.set({ "n" }, "<M-r>", "<cmd>m-2<CR>==")
-- vim.keymap.set({ "n" }, "<M-o>", "gJ")

vim.keymap.set({ "n", "x", "o" }, "-", "^")
vim.keymap.set({ "n", "x", "o" }, "^", "-")
vim.keymap.set({ "n", "x", "o" }, "+", "$")
vim.keymap.set({ "n", "x", "o" }, "$", "+")

vim.keymap.set("n", "<leader>ct", "<cmd>close<CR>", { desc = "[c]lose [t]his window", silent = true })
vim.keymap.set("n", "<leader>co", "<cmd>only<CR>", { desc = "[c]lose [t]his window", silent = true })

vim.keymap.set("n", "<leader>tt", "<cmd>lua Snacks.terminal.toggle()<CR>", { desc = "[t]oggle [t]erminal", silent = true })
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set("n", "<leader>c", '"_c', { desc = "Change without yanking" })
vim.keymap.set("x", "<leader>p", "P", { desc = "Paste without yanking" })
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

vim.cmd "autocmd BufEnter * set formatoptions-=o"
vim.cmd "autocmd BufEnter * setlocal formatoptions-=o"

-- vim.api.nvim_create_autocmd("BufLeave", {
--     desc = "Some desc",
--     group = vim.api.nvim_create_augroup("save-on-buf-leave", { clear = true }),
--     callback = function()
--         vim.notify "test"
--         -- vim.keymap.set({ "n" }, "<C-s>", "<cmd>w<CR>")
--     end,
-- })

--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

Gh = function(x)
    return "https://github.com/" .. x
end

vim.pack.add { Gh "folke/which-key.nvim" }
require("which-key").setup {
    delay = 0,
    icons = {
        mappings = vim.g.have_nerd_font,
        keys = {}, -- It will use the default Nerd Font icons
    },

    -- Document existing key chains
    spec = {
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
    },
}

vim.pack.add { Gh "stevearc/conform.nvim" }
require("conform").setup {
    formatters_by_ft = {
        lua = { "stylua" },

        -- Notes
        -- Conform will run multiple formatters sequentially
        -- python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        -- rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
}

vim.keymap.set("n", "<leader>f", function()
    require("conform").format { async = true, lsp_format = "fallback" }
end, { desc = "[F]ormat buffer" })

vim.pack.add { Gh "nvim-lua/plenary.nvim" }
vim.pack.add { Gh "folke/todo-comments.nvim" }
require("todo-comments").setup {
    signs = false,
}


vim.pack.add { Gh "nvim-treesitter/nvim-treesitter" }
-- require("nvim-treesitter").setup({
--     ensure_installed = { "python" },
--     auto_install = true,
--     highlight = {
--         enable = true
--     },
--     indent = { enable = true },
-- })
-- require("nvim-treesitter").setup()

-- { -- Highlight, edit, and navigate code
--     "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate",
--     main = "nvim-treesitter.configs", -- Sets main module to use for opts
--     -- dependencies = { "p00f/nvim-ts-rainbow", opts = {} },
--     -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
--     opts = {
--         ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc", "python" },
--         -- Autoinstall languages that are not installed
--         auto_install = true,
--         highlight = {
--             enable = true,
--             -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
--             --  If you are experiencing weird indenting issues, add the language to
--             --  the list of additional_vim_regex_highlighting and disabled languages for indent.
--             additional_vim_regex_highlighting = { "ruby" },
--         },
--         indent = { enable = true, disable = { "ruby" } },
--     },
-- },
