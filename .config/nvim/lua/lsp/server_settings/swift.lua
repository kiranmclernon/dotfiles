local opts = require("lsp.server_settings.default")

if not opts.capabilities then
    opts.capabilities = {}
end

opts.capabilities.workspace =  {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
}

return opts
