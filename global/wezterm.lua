local config = wezterm.config_builder()

config.color_scheme = "Oxocarbon Dark (Gogh)"

config.font = wezterm.font({
	family = "Monaspace Neon",
	harfbuzz_features = { "calt", "ss01", "ss02", "ss03", "ss04", "ss05", "ss07", "ss08", "ss09", "liga" },
})

config.window_background_opacity = 0.5

config.enable_tab_bar = false

return config
