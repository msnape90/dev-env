-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
	--	window:gui_window():toggle_fullscreen()
end)

-- wezterm.on("toggle-fullscreen", function(window)
-- 	window:toggle_fullscreen()
-- 	window:set_config_overrides({ window_background_opacity = 0.6 })
-- end)

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- Fixing copy paste bug
config.default_domain = "local"
-- config.enable_wayland = false
config.default_cursor_style = "BlinkingBlock"
config.force_reverse_video_cursor = true
config.window_background_gradient = nil -- Disable gradients if set

-- wezterm-wl-clipboard fix reducing notification triggers from clipboard actions
config.disable_default_key_bindings = true
config.keys = {
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "F11", action = wezterm.action.ToggleFullScreen },
}
-- config.force_reverse_video_cursor = true

-- font size and color scheme.
config.font_size = 14
config.color_scheme = "rose-pine"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.65
config.window_decorations = "RESIZE"

-- Finally, return the configuration to wezterm:
return config
