local opts = require("lsp.server_settings.default")

local settings = {
    pylsp = {
        plugins = {
            pycodestyle = {
                enabled = true,
                ignore = {'W391'},
                maxLineLength = 79
            },
            pylint = {
                enabled = true
            }
      }
    }
}

opts["settings"] = settings
return opts
