local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Ask for confirmation before closing any windows, panes, or tabs
config.skip_close_confirmation_for_processes_named = {}

config.window_close_confirmation = 'AlwaysPrompt'
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.color_scheme = "Dracula (Official)"

-- Key mappings
config.keys = {
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = "v",
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}

return config

