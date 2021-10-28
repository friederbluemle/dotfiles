local wezterm = require 'wezterm';
return {
  enable_scroll_bar = true,
  font_size = 13.7,
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  initial_cols = 100,
  initial_rows = 32,
  line_height = 0.85,
  scrollback_lines = 6000,
  selection_word_boundary = " \t\n{}[]()\"'`.,;:=",
  window_decorations = "RESIZE",
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
                -- "Half", "Normal" or "Bold" intensity
                -- The default is "Normal"
                intensity = "Normal",
                -- "None", "Single" or "Double" underline
                -- The default is "None"
                underline = "None",
                italic = false,
            },
            inactive_tab = {
                bg_color = "#333333",
                fg_color = "#888888",
                underline = "None",
            },
            inactive_tab_hover = {
                bg_color = "#363636",
                fg_color = "#909090",
                italic = false,
            }
        }
    }
}
