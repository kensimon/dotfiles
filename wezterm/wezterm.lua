local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = 'Vs Code Light+ (Gogh)'
config.font_size = 10.0
config.initial_rows = 60
config.initial_cols = 132

config.enable_scroll_bar = true
config.scrollback_lines = 1000000

-- fuuuuck ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.keys = {
  -- Clears the scrollback and viewport, and then sends CTRL-L to ask the
  -- shell to redraw its prompt
  {
    key = 'k',
    mods = 'SUPER',
    action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'L', mods = 'CTRL' },
    },
  },
  {
    key = 'Home',
    mods = 'SHIFT',
    action = act.ScrollToTop,
  },
  {
    key = 'End',
    mods = 'SHIFT',
    action = act.ScrollToBottom,
  },
}

config.font = wezterm.font('JetBrains Mono')

return config
