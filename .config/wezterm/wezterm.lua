local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.color_scheme = "Dracula (Official)"

-- Key mappings
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = '|',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = "-",
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },

  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
}

return config

