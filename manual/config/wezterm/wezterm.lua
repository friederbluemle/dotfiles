local wezterm = require 'wezterm'

wezterm.on("window-config-reloaded", function(window, pane)
  window:toast_notification("wezterm", "config reloaded!", nil, 2000)
end)

return {
  enable_scroll_bar = true,
  font_size = 15,
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  initial_cols = 132,
  initial_rows = 36,
  line_height = 0.85,
  scrollback_lines = 9000,
  selection_word_boundary = " \t\n{}[]()\"'`,;=",
  window_decorations = "RESIZE",
  window_padding = {
    left = 2,
    right = 2,
    top = 1,
    bottom = 1,
  },
  keys = {
    -- search for things that look like git hashes
    {key="H", mods="SHIFT|CTRL", action=wezterm.action{Search={Regex="[a-f0-9]{6,}"}}},
  },
  colors = {
    tab_bar = {
      background = "#222222",
      active_tab = {
        bg_color = "#0066bb",
        fg_color = "#ffffff",
      },
      inactive_tab = {
        bg_color = "#333333",
        fg_color = "#888888",
      },
      inactive_tab_hover = {
        bg_color = "#333333",
        fg_color = "#888888",
      }
    }
  }
}
