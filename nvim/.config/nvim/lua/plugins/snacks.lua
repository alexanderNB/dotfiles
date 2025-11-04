return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {
                "<S-Esc>",
                function()
                    Snacks.explorer()
                end,
                desc = "Open explorer",
            },
            {
                "<leader>st",
                function()
                    Snacks.picker.smart()
                end,
                desc = "Smart Find Files",
            },
            {
                "<leader>sg",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep",
            },
            {
                "<leader><leader>",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>s:",
                function()
                    Snacks.picker.command_history()
                end,
                desc = "Command History",
            },
            {
                "<leader>sN",
                function()
                    Snacks.picker.notifications()
                end,
                desc = "[S]earch [N]otifications",
            },

            {
                "<leader>sh",
                function()
                    Snacks.picker.help()
                end,
                desc = "[S]earch [H]elp",
            },
            {
                "<leader>sk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "[S]earch [K]eymaps",
            },
            {
                "<leader>ss",
                function()
                    Snacks.picker.pick()
                end,
                desc = "[S]earch [S]earch",
            },
            {
                "<leader>sw",
                function()
                    Snacks.picker.grep_word()
                end,
                desc = "[S]earch [W]ord",
            },
            -- {
            --     "<leader>s/",
            --     function()
            --         Snacks.picker.
            --     end,
            --     desc = "[S]earch current buffer",
            -- },
            {
                "<leader>se",
                function()
                    Snacks.picker.diagnostics_buffer()
                end,
                desc = "[S]earch [e]rrors in current file",
            },
            {
                "<leader>sE",
                function()
                    Snacks.picker.diagnostics()
                end,
                desc = "[S]earch [E]rrors",
            },
            {
                "<leader>sr",
                function()
                    Snacks.picker.resume()
                end,
                desc = "[S]earch [R]esume",
            },
            {
                "<leader>s.",
                function()
                    Snacks.picker.recent()
                end,
                desc = "[S]earch recent files",
            },
            {
                "<leader>sd",
                function()
                    Snacks.picker.smart { cwd = "~/dotfiles/" }
                end,
                desc = "[S]earch [D]otfiles",
            },
            {
                "<leader>sn",
                function()
                    Snacks.picker.smart { cwd = "~/.config/nvim/" }
                end,
                desc = "[S]earch [N]eovim files",
            },
        },
        opts = {

            --- @type snacks.Config
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            explorer = { enabled = false },
            indent = { enabled = true },
            input = { enabled = false },
            picker = {
                enabled = false,
                win = {
                    input = {
                        keys = {
                            ["j"] = "",
                            ["k"] = "",
                            ["e"] = "list_down",
                            ["r"] = "list_up",
                            -- ["<a-p>"] = "",
                            ["<a-p>"] = { "", mode = { "i", "n" } },
                            ["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
                            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                        },
                    },
                    keys = {
                        ["j"] = "",
                        ["k"] = "",
                        ["e"] = "list_down",
                        ["r"] = "list_up",
                        ["<a-p>"] = "",
                        ["<c-p>"] = "toggle_preview",
                    },
                },
                sources = {
                    explorer = {
                        layout = {
                            layout = {
                                position = "right",
                            },
                        },
                        hidden = true,
                        follow_file = true,
                        auto_close = false,
                        focus = "list",
                        enter = false,
                        win = {
                            list = {
                                keys = {
                                    ["<BS>"] = "explorer_up",
                                    ["<CR>"] = "explorer_open",
                                    ["o"] = "confirm",
                                    ["n"] = "explorer_close", -- close directory
                                    ["c"] = "explorer_rename",
                                    ["r"] = "list_up",
                                    ["q"] = "",
                                },
                            },
                        },
                        jump = {
                            -- reuse_win = true,
                            close = false,
                        },
                    },
                    smart = {
                        multi = { "files" },
                        hidden = true,
                        exclude = { "Steam", "Games" },
                        supports_live = true,
                        icon = true,
                    },
                },

                layouts = {
                    ["default"] = {
                        layout = {
                            box = "horizontal",
                            width = 0.95,
                            min_width = 120,
                            height = 0.93,
                            {
                                box = "vertical",
                                border = true,
                                title = "{title} {live} {flags}",
                                { win = "input", height = 1, border = "bottom" },
                                { win = "list", border = "none" },
                            },
                            { win = "preview", title = "{preview}", border = true, width = 0.5 },
                        },
                        icon = true,
                    },
                },
            },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = false },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = false },
            terminal = { enabled = true },
            image = {
                image = {
                    enabled = false,
                    doc = {
                        enabled = true,
                        inline = false,
                        max_width = 100,
                        max_height = 100,
                    },
                    resolve = function(path, src)
                        if require("obsidian.api").path_is_note(path) then
                            return require("obsidian.api").resolve_image_path(src)
                        end
                    end,
                    ---@class snacks.image.convert.Config
                    convert = {
                        notify = true, -- show a notification on error
                        ---@type snacks.image.args
                        mermaid = function()
                            local theme = vim.o.background == "light" and "neutral" or "dark"
                            return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
                        end,
                        ---@type table<string,snacks.image.args>
                        magick = {
                            default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
                            vector = { "-density", 192, "{src}[0]" }, -- used by vector images like svg
                            math = { "-density", 192, "{src}[0]", "-trim" },
                            pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
                        },
                    },
                    math = {
                        enabled = true, -- enable math expression rendering
                        -- in the templates below, `${header}` comes from any section in your document,
                        -- between a start/end header comment. Comment syntax is language-specific.
                        -- * start comment: `// snacks: header start`
                        -- * end comment:   `// snacks: header end`
                        typst = {
                            tpl = [[
            #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
            #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
            #set text(size: 12pt, fill: rgb("${color}"))
            ${header}
            ${content}]],
                        },
                        latex = {
                            font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
                            -- for latex documents, the doc packages are included automatically,
                            -- but you can add more packages here. Useful for markdown documents.
                            packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
                            tpl = [[
            \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
            \usepackage{${packages}}
            \begin{document}
            ${header}
            { \${font_size} \selectfont
              \color[HTML]{${color}}
            ${content}}
            \end{document}]],
                        },
                    },
                },
            },
            styles = {
                terminal = {
                    "terminal",
                    bo = {
                        filetype = "snacks_terminal",
                    },
                    wo = {},
                    keys = {
                        q = "hide",
                        gf = function(self)
                            local f = vim.fn.findfile(vim.fn.expand "<cfile>", "**")
                            if f == "" then
                                Snacks.notify.warn "No file under cursor"
                            else
                                self:hide()
                                vim.schedule(function()
                                    vim.cmd("e " .. f)
                                end)
                            end
                        end,
                        term_normal = {
                            "<esc>",
                            "<C-\\><C-n>",
                            mode = "t",
                            -- expr = true,
                            desc = "Escape to normal mode",
                        },
                    },
                },
            },
        },
    },
}
