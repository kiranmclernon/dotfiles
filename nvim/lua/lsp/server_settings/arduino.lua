local on_attach_default = require"lsp.handlers".on_attach
local capabilities = require("lsp.handlers").capabilities

local function on_attach(client, bufnr)
    on_attach_default(client, bufnr)
    vim.api.nvim_buf_set_keymap()
    local mappings = {
        { 'aa', 'ArduinoAttach' },
        { 'av', 'ArduinoVerify' },
        { 'au', 'ArduinoUpload' },
        { 'aus', 'ArduinoUploadAndSerial' },
        { 'as', 'ArduinoSerial' },
        { 'ab', 'ArduinoChooseBoard' },
        { 'ap', 'ArduinoChooseProgrammer' }
    }
    for _, mapping in pairs(mappings) do
        local key, cmd = mapping[1], mapping[2]
        vim.cmd(string.format([[
            nnoremap <buffer> <leader>%s <cmd>%s<CR>
        ]], key, cmd))
    end
    local function arduino_status()
      if vim.bo.filetype ~= "arduino" then
        return ""
      end
      local port = vim.fn["arduino#GetPort"]()
      local line = string.format("[%s]", vim.g.arduino_board)
      if vim.g.arduino_programmer ~= "" then
        line = line .. string.format(" [%s]", vim.g.arduino_programmer)
      end
      if port ~= 0 then
        line = line .. string.format(" (%s:%s)", port, vim.g.arduino_serial_baud)
      end
      return line
    end
    require("lualine").sections.lualine_x = arduino_status
    require("lualine").refresh()

    local clangd_install = require('mason-registry')
    .get_package('clangd')
    :get_install_path()
end

local opts = { on_attach, capabilities }
return opts
