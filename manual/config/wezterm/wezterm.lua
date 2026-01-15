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
    -- Re-enable standard Readline combinations (CMD is located in ALT position on Apple keyboards)
    {key="b", mods="CMD", action=wezterm.action.SendKey{key="b", mods="ALT"}},
    {key="d", mods="CMD", action=wezterm.action.SendKey{key="d", mods="ALT"}},
    {key="f", mods="CMD", action=wezterm.action.SendKey{key="f", mods="ALT"}},
    -- search for things that look like git hashes
    {key="H", mods="SHIFT|CTRL", action=wezterm.action{Search={Regex="[a-f0-9]{6,}"}}},
    -- Prevent WezTerm from overriding standard 'undo' Readline action (C-_)
    {key="-", mods="SHIFT|CTRL", action=wezterm.action.DisableDefaultAssignment},
    {key="_", mods="SHIFT|CTRL", action=wezterm.action.DisableDefaultAssignment},
    -- Enable multi-line edit (Shift+Enter inserts line break)
    {key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"}},
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
  },
  hyperlink_rules = {
    {
      regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },
    {
      regex = "\\bfile://\\S*\\b",
      format = "$0",
    },
    {
      regex = "\\b([A-Z]{3,9}-\\d+)\\b",
      format = "https://linear.app/0xproject/issue/$1",
    },
  }
}
