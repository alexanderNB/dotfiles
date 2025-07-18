return { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup {
            n_lines = 500,
            mappings = {
                inside = "h",
                inside_next = "hn",
                inside_last = "hl",
            },
        }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup {
            -- `:h MiniSurround.config`.
            custom_surroundings = {
                ["("] = { output = { left = "(", right = ")" } },
                [")"] = { output = { left = "( ", right = " )" } },
                ["["] = { output = { left = "[", right = "]" } },
                ["]"] = { output = { left = "[ ", right = " ]" } },
                ["{"] = { output = { left = "{", right = "}" } },
                ["}"] = { output = { left = "{ ", right = " }" } },
                ["<"] = { output = { left = "<", right = ">" } },
                [">"] = { output = { left = "< ", right = " >" } },
            },

            highlight_duration = 500,

            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                add = "Sa", -- Add surrounding in Normal and Visual modes
                delete = "Sd", -- Delete surrounding
                find = "Sf", -- Find surrounding (to the right)
                find_left = "SF", -- Find surrounding (to the left)
                highlight = "Sh", -- Highlight surrounding
                replace = "Sr", -- Replace surrounding
                update_n_lines = "Sn", -- Update `n_lines`

                suffix_last = "l", -- Suffix to search with "prev" method
                suffix_next = "n", -- Suffix to search with "next" method
            },
            n_lines = 20,
            respect_selection_type = false,
            search_method = "cover",
            silent = false,
        }

        -- Simple and easy statusline.
        local statusline = require "mini.statusline"
        statusline.setup { use_icons = vim.g.have_nerd_font }

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return "%2l:%-2v"
        end

        require("mini.pairs").setup()
        require("mini.sessions").setup()

        --  Check out: https://github.com/echasnovski/mini.nvim
    end,
}
