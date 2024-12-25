local wezterm = require("wezterm")
config = wezterm.config_builder()

config = {

    --font
    font = wezterm.font("CaskaydiaCove Nerd Font Mono"),
    font_size = 17,

    -- theame
    window_background_opacity = 0.97,
    window_background_image = "/Users/jonas/.config/wezterm/assets/blury_background.jpg",
    macos_window_background_blur = 10,

    colors = {
        cursor_bg = "white",
        cursor_border = "white"
    },

    -- random
    automatically_reload_config = true,
    enable_tab_bar = false,
}

return config
