local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.check_for_updates = true

config.default_cwd = wezterm.home_dir

-- Ask for confirmation before closing any windows, panes, or tabs
config.skip_close_confirmation_for_processes_named = {}

-- Window appearance

config.window_close_confirmation = "AlwaysPrompt"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

-- Fonts
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "JetBrainsMono Nerd Font Mono",
  "FiraCode Nerd Font Mono",
  "NotoMono Nerd Font",
  "NotoMono Nerd Font Mono",
  "Fira Code Symbol",
  "Noto Sans Symbol",
  "PingFang SC",
})

-- Cursor
config.default_cursor_style = "BlinkingBlock"

config.cursor_blink_rate = 512
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.force_reverse_video_cursor = false

-- Color scheme
config.color_scheme = "Dracula (Official)"

-- Key mappings
config.keys = {
  {
    key = "t",
    mods = "CMD",
    action = wezterm.action.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
  },
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane({ confirm = false }),
  },
  {
    key = "|",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "_",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    key = "k",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "j",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
}

return config
