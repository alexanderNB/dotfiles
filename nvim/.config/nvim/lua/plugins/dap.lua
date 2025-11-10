-- return {
--     "mfussenegger/nvim-dap",
--     dependencies = {
--         "mfussenegger/nvim-dap-python",
--         "theHamsta/nvim-dap-virtual-text",
--     },
--     opts = {},
--     config = function()
--         require("dap-python").setup "python3"
--     end,
--
-- }

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "mfussenegger/nvim-dap-python",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
    },
    config = function()
        local dap = require "dap"
        local ui = require "dapui"

        require("dapui").setup()
        require("dap-python").setup "python3"
        require("nvim-dap-virtual-text").setup()

        -- Handled by nvim-dap-go
        -- dap.adapters.go = {
        --   type = "server",
        --   port = "${port}",
        --   executable = {
        --     command = "dlv",
        --     args = { "dap", "-l", "127.0.0.1:${port}" },
        --   },
        -- }

        -- local elixir_ls_debugger = vim.fn.exepath "elixir-ls-debugger"
        -- if elixir_ls_debugger ~= "" then
        --     dap.adapters.mix_task = {
        --         type = "executable",
        --         command = elixir_ls_debugger,
        --     }
        --
        --     dap.configurations.elixir = {
        --         {
        --             type = "mix_task",
        --             name = "phoenix server",
        --             task = "phx.server",
        --             request = "launch",
        --             projectDir = "${workspaceFolder}",
        --             exitAfterTaskReturns = false,
        --             debugAutoInterpretAllModules = false,
        --         },
        --     }
        -- end

        vim.keymap.set("n", "<space>bt", dap.toggle_breakpoint)
        vim.keymap.set("n", "<space>bh", dap.run_to_cursor)

        -- Eval var under cursor
        -- vim.keymap.set("n", "<space>bv" function()
        --     ui.eval(nil, { enter = true })
        -- end)

        -- vim.keymap.set("n", "<M-t>", dap.new)
        vim.keymap.set("n", "<M-s>", dap.step_back)
        vim.keymap.set("n", "<M-i>", dap.continue)
        vim.keymap.set("n", "<M-a>", dap.restart)

        -- vim.keymap.set("n", "<space>bi", dap.step_into)
        -- vim.keymap.set("n", "<space>bo", dap.step_over)
        -- vim.keymap.set("n", "<space>bo", dap.step_out)

        -- dap.listeners.before.attach.dapui_config = function()
        --     ui.open()
        -- end
        -- dap.listeners.before.launch.dapui_config = function()
        --     ui.open()
        -- end
        -- dap.listeners.before.event_terminated.dapui_config = function()
        --     ui.close()
        -- end
        -- dap.listeners.before.event_exited.dapui_config = function()
        --     ui.close()
        -- end

        -- vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
        -- vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
        -- vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
        -- vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
        -- vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
        -- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
        -- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        -- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
        -- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
        -- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
        --   require('dap.ui.widgets').hover()
        -- end)
        -- vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
        --   require('dap.ui.widgets').preview()
        -- end)
        -- vim.keymap.set('n', '<Leader>df', function()
        --   local widgets = require('dap.ui.widgets')
        --   widgets.centered_float(widgets.frames)
        -- end)
        -- vim.keymap.set('n', '<Leader>ds', function()
        --   local widgets = require('dap.ui.widgets')
        --   widgets.centered_float(widgets.scopes)
        -- end)
    end,
}
