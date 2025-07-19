vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

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

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-n>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-e>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-i>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-o>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set({ "n", "x" }, "s", "<Nop>")
vim.keymap.set({ "n", "x" }, "S", "<Nop>")

vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<CR>")

-- vim.keymap.set({ "x" }, "ig", "gg0oG$")

vim.keymap.set("n", "N", "<C-o>", { desc = "Previous jump" })
-- vim.keymap.set("n", "J", ":bprevious<CR>", { desc = "Previous buffer" })
-- vim.keymap.set("n", "K", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "O", "<C-i>", { desc = "Next jump" })

vim.keymap.set("i", "<Esc>", "<Esc>m`")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("n", "<leader>n", "<cmd>lua Snacks.picker.notifications()<CR>", { desc = "Notification History" })
-- vim.keymap.set("n", "<leader>n", function()
--     Snacks.picker.notifications()
-- end, { desc = "Notification History" })

vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

vim.keymap.set("n", "<localleader>ms", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })
vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
vim.keymap.set({ "n", "x", "o" }, "n", "h")
vim.keymap.set({ "n", "x", "o" }, "e", "j")
vim.keymap.set({ "n", "x", "o" }, "i", "k")
vim.keymap.set({ "n", "x", "o" }, "o", "l")
vim.keymap.set({ "n", "x", "o" }, "h", "i")
vim.keymap.set({ "n", "x", "o" }, "j", "e")
vim.keymap.set({ "n", "x", "o" }, "k", "n")
vim.keymap.set({ "n", "x", "o" }, "l", "o")
vim.keymap.set({ "n", "x", "o" }, "H", "I")
vim.keymap.set({ "n", "x", "o" }, "J", "E")
vim.keymap.set({ "n", "x", "o" }, "K", "N")
vim.keymap.set({ "n", "x", "o" }, "L", "O")

vim.keymap.set({ "n" }, "<M-n>", "J")
vim.keymap.set({ "n" }, "<M-e>", "<cmd>m+<CR>==")
vim.keymap.set({ "n" }, "<M-i>", "<cmd>m-2<CR>==")
-- vim.keymap.set({ "x" }, "<M-e>", "<cmd>'<,'>m 10<CR>")
-- vim.keymap.set({ "x" }, "<M-i>", "<cmd>'<,'>m 20<CR>")
vim.keymap.set({ "n" }, "<M-o>", "gJ")
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

vim.cmd "autocmd BufEnter * set formatoptions-=o"
vim.cmd "autocmd BufEnter * setlocal formatoptions-=o"

--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({
    -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
    --
    -- Alternatively, use `config = function() ... end` for full control over the configuration.
    -- If you prefer to call `setup` explicitly, use:
    --    {
    --        'lewis6991/gitsigns.nvim',
    --        config = function()
    --            require('gitsigns').setup({
    --                -- Your gitsigns configuration here
    --            })
    --        end,
    --    }
    --
    -- "NMAC427/guess-indent.nvim", -- Detect tabstop and shiftwidth automatically

    -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
    --
    -- normal autocommands events (`:help autocmd-events`).
    { -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter'
        opts = {
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
        },
    },

    { -- Autoformat
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format { async = true, lsp_format = "fallback" }
                end,
                mode = "",
                desc = "[F]ormat buffer",
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { c = true, cpp = true }
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    return nil
                else
                    return {
                        timeout_ms = 500,
                        lsp_format = "fallback",
                    }
                end
            end,
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform can also run multiple formatters sequentially
                -- python = { "isort", "black" },
                --
                -- You can use 'stop_after_first' to run the first available formatter from the list
                -- javascript = { "prettierd", "prettier", stop_after_first = true },
            },
        },
    },

    -- Highlight todo, notes, etc in comments
    { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "gs", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    { "p00f/nvim-ts-rainbow" },
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs", -- Sets main module to use for opts
        -- dependencies = { "p00f/nvim-ts-rainbow", opts = {} },
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = {
            ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc", "python" },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { "ruby" },
            },
            indent = { enable = true, disable = { "ruby" } },
            -- rainbow = {
            --     enable = true,
            --     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            --     extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            --     max_file_lines = 10000, -- Do not enable for files with more than n lines, int
            --     -- colors = { "#FF0000", "#00FF00", "#0000FF" }, -- table of hex strings
            --     -- termcolors = {} -- table of colour name strings
            -- },
        },
        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    },
    {
        "nvzone/typr",
        dependencies = "nvzone/volt",
        opts = {},
        cmd = { "Typr", "TyprStats" },
    },
    -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    { import = "plugins" },
    -- { import = "ftplugins" },

    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',
    -- require 'kickstart.plugins.autopairs',
    -- require 'kickstart.plugins.neo-tree',
    -- require "kickstart.plugins.gitsigns", -- moved to plugins.git

    -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
    -- Or use telescope!
    -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
    -- you can continue same window with `<space>sr` which resumes last telescope search
}, { ui = { icons = {} } }) -- Nerd font icons

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

local runner = require "quarto.runner"
vim.keymap.set("n", "<localleader>mm", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<localleader>ma", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<localleader>ma", runner.run_below, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<localleader>mA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<localleader>ml", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<Localleader>m", runner.run_range, { desc = "run visual range", silent = true })

vim.keymap.set({ "n", "x" }, "i", "k")
