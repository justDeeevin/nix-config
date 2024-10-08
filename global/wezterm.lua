local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Oxocarbon Dark (Gogh)"

config.font = wezterm.font({
	family = "Monaspace Neon",
	harfbuzz_features = { "calt", "ss01", "ss02", "ss03", "ss04", "ss05", "ss07", "ss08", "ss09", "liga" },
})

config.keys = {
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({}),
	},
	{
		key = "Enter",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitVertical({}),
	},
	{
		key = "i",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "e",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "n",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "m",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
	},
}

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)
