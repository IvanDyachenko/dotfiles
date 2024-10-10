local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.check_for_updates = true

-- Ask for confirmation before closing any windows, panes, or tabs
config.skip_close_confirmation_for_processes_named = {}

config.window_close_confirmation = "AlwaysPrompt"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 256

config.color_scheme = "Dracula (Official)"

-- Key mappings
config.keys = {
	-- Create a new tab in the default domain
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
	},
	--
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
}

return config
