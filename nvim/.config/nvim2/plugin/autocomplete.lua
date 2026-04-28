vim.pack.add { Gh "j-hui/fidget.nvim" } -- LSP Information at the bottom right
require("fidget").setup {}

vim.pack.add { Gh "folke/lazydev.nvim" }
require("lazydev").setup {
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
    },
}

vim.pack.add { Gh "mason-org/mason.nvim" }

require("mason").setup {}

vim.pack.add { Gh "neovim/nvim-lspconfig" }
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

        map("grr", function()
            Snacks.picker.lsp_references()
        end, "[G]oto [R]references")

        map("gri", function()
            Snacks.picker.lsp_implementations()
        end, "[G]oto [I]mplementation")

        map("grd", function()
            Snacks.picker.lsp_definitions()
        end, "[G]oto [D]efinition")

        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        map("grs", function()
            Snacks.picker.lsp_symbols()
        end, "Open Document Symbols")

        map("grS", function()
            Snacks.picker.lsp_workspace_symbols()
        end, "Open Document Symbols")

        -- idk what this is
        -- map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("grt", function()
            Snacks.picker.lsp_type_definitions()
        end, "[G]oto [T]ype Definition")

        map("<C-space>", vim.lsp.buf.hover, "LSP Hover")
        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
            if vim.fn.has "nvim-0.11" == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = event2.buf }
                end,
            })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    } or {},
    virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}

-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP specification.
--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
-- local capabilities = require("blink.cmp").get_lsp_capabilities()
-- server.capabilities = vim.tbl_deep_extend("force", {}, capabiliies, server.capabilities or {})

-- `friendly-snippets` contains a variety of premade snippets.
-- vim.pack.add{ Gh "L3MON4D3/LuaSnip" }

-- Build Step is needed for regex support in snippets.
-- return "make install_jsregexp"

-- dependency?
-- "folke/lazydev.nvim",

vim.pack.add { Gh "saghen/blink.lib" }
vim.pack.add { Gh "saghen/blink.cmp" }
require("blink.cmp").setup {
    keymap = {
        preset = "default",
        ["<Up>"] = false,
        ["<Down>"] = false,
        ["<C-a>"] = { "hide" },
        ["<C-i>"] = { "select_next", "fallback" },
        ["<C-s>"] = { "select_prev" },
        ["<C-t>"] = { "accept" },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = true },
        list = { selection = { preselect = true, auto_insert = false } },
    },

    sources = {
        -- default = { },
        default = { "lsp", "path", "snippets", "lazydev" },
        providers = {
            lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        },
    },
    cmdline = {
        enabled = true,
        keymap = {
            preset = "inherit",
        },
        completion = {
            ghost_text = { enabled = true },
            menu = { auto_show = true },
            list = { selection = { preselect = true, auto_insert = false } },
        },
    },

    -- snippets = {
    --     enabled = false,
    --     preset = "luasnip",
    -- },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = "lua" },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
}

-- Specific

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "recommended",
                diagnosticSeverityOverrides = {
                    reportUnreachable = "hint",
                    reportUnknownParameterType = "hint",
                    reportUnknownArgumentType = "hint",
                    reportUnknownLambdaType = "hint",
                    reportUnknownVariableType = "hint",
                    reportUnknownMemberType = "hint",
                    reportMissingParameterType = "hint",

                    reportConstantRedefinition = "hint",
                    reportOptionalSubscript = "hint",
                    reportOptionalMemberAccess = "hint",
                    reportArgumentType = "hint",
                    reportOptionalOperand = "hint",
                    reportUnannotatedClassAttribute = "hint",
                    reportOptionalCall = "hint",
                    reportUnusedCallResult = "hint",
                    reportImplicitOverride = "hint",
                },
                stubPath = "~/SyncedObsidian/.obsidian/plugins/obsidian-pyright/Pyright/customStubs",
            },
        },
    },
})
