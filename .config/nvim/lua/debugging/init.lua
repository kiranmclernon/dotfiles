
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            dependencies = "nvim-neotest/nvim-nio",
        },
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        local debugpy_venv = "/usr/local/Caskroom/miniconda/base/envs/debug/bin/python"
        require("dap-python").setup(debugpy_venv)
        local dap, dapui = require("dap"), require("dapui")
        -- dap.listeners.before.attach.dapui_config = function()
        --     dapui.open()
        -- end
        -- dap.listeners.before.launch.dapui_config = function()
        --     dapui.open()
        -- end
        -- dap.listeners.before.event_terminated.dapui_config = function()
        --     dapui.close()
        -- end
        -- dap.listeners.before.event_exited.dapui_config = function()
        --     dapui.close()
        -- end
        vim.keymap.set("n", "<leader>dc", dap.continue)
    end,
}
