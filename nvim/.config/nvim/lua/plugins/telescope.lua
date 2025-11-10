return {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    event = "VimEnter",
    dependencies = {
        "nvim-lua/plenary.nvim", -- This line is interpreted as { 'nvim-lua/plenary.nvim' }, by lua
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            "nvim-telescope/telescope-fzf-native.nvim",

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = "make",

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable "make" == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
        --  - Insert mode: <c-/>
        --  - Normal mode: ?
        --
        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
        require("telescope").setup {
            defaults = {
                mappings = {
                    -- i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                    i = {
                        ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
                    },
                },
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        height = 0.95,
                        preview_cutoff = 120,
                        preview_width = 0.6,
                        prompt_position = "bottom",
                        width = 0.95,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = {
                        "fd",
                        "--type",
                        "f",
                        "--hidden",
                        "--exclude",
                        "Steam",
                        "--exclude",
                        "Games",
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
                ["media_files"] = {
                    -- filetypes whitelist
                    -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                    filetypes = { "png", "webp", "jpg", "jpeg" },
                    -- find command (defaults to `fd`)
                    find_cmd = "rg",
                },
            },
        }

        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")
        pcall(require("telescope").load_extension, "media_files")

        -- See `:help telescope.builtin`
        local builtin = require "telescope.builtin"

        -- vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        -- vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        -- vim.keymap.set("n", "<leader>st", builtin.find_files, { desc = "[S]earch [T]his directory" })
        -- vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        -- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        -- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        -- vim.keymap.set("n", "<leader>se", builtin.diagnostics, { desc = "[S]earch [E]rrors" })
        -- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
        -- vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        -- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
        --
        -- -- Slightly advanced example of overriding default behavior and theme
        -- vim.keymap.set("n", "<leader>/", function()
        --     -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        --     builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        --         winblend = 10,
        --         previewer = true,
        --     })
        -- end, { desc = "[/] Fuzzily search in current buffer" })
        --
        -- -- It's also possible to pass additional configuration options.
        -- --  See `:help telescope.builtin.live_grep()` for information about particular keys
        -- vim.keymap.set("n", "<leader>s/", function()
        --     builtin.live_grep {
        --         grep_open_files = true,
        --         prompt_title = "Live Grep in Open Files",
        --     }
        -- end, { desc = "[S]earch [/] in Open Files" })
        --
        -- -- Shortcut for searching your Neovim configuration files
        -- vim.keymap.set("n", "<leader>sn", function()
        --     builtin.find_files { cwd = vim.fn.stdpath "config" }
        -- end, { desc = "[S]earch [N]eovim files" })
        --
        -- -- Shortcut for searching configuration files
        -- vim.keymap.set("n", "<leader>sd", function()
        --     builtin.find_files { cwd = "~/dotfiles/" }
        -- end, { desc = "[S]earch [D]otfiles" })
    end,
}
