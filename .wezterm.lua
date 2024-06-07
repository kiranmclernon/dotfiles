local wezterm = require "wezterm"

local config = {}

config.font_size = 12.5
config.color_scheme = 'nord'
config.font = wezterm.font('JetBrains Mono', {weight = "Bold"})

config.hide_tab_bar_if_only_one_tab = true


return config
