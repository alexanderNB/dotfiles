return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            {
                "<S-Esc>",
                "<cmd>lua Snacks.explorer()<CR>",
                desc = "Open explorer",
            },
        },
        opts = {

            --- @type snacks.Config
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = {
                enabled = false,
                preset = {
                    pick = function(cmd, opts)
                        return LazyVim.pick(cmd, opts)()
                    end,
                    -- stylua: ignore
                    header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
                    ---@type snacks.dashboard.Item[]
                    keys = {
                        { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
                        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
            },
            explorer = {
                enabled = true,
            },
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
                        },
                    },
                    keys = {
                        ["j"] = "",
                        ["k"] = "",
                        ["e"] = "list_down",
                        ["r"] = "list_up",
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
                },
            },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = false },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = false },
            image = {
                enabled = false,
                doc = {
                    enabled = true,
                    inline = false,
                    max_width = 100,
                    max_height = 100,
                },
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
    },
}
