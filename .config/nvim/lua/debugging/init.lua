local function get_package_path(package)
    local mason_package_path = vim.env.MASON .. "/packages/"
    local path = mason_package_path .. package
    local file = io.open(path, "r")
    if file then
        file:close()
        return path
    else
        error("cant find " .. path)
    end
end

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            lazy = false,
            "rcarriga/nvim-dap-ui",
            dependencies = "nvim-neotest/nvim-nio",
        },
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        local debugpy_path = get_package_path("debugpy")
        local debugpy_venv = debugpy_path .. "/venv/bin/python"
        require("dap-python").setup(debugpy_venv)
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()
        vim.keymap.set("n", "<leader>dc", dap.continue)
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
}
