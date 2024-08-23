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

-- Open tab to right of current tab
-- https://github.com/wez/wezterm/issues/909#issuecomment-1738831414
function active_tab_idx(mux_win)
   for _, item in ipairs(mux_win:tabs_with_info()) do
      -- wezterm.log_info('idx: ', idx, 'tab:', item)
      if item.is_active then
         return item.index
      end
   end
end

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
  -- Open tab to right of current tab
  -- https://github.com/wez/wezterm/issues/909#issuecomment-1738831414
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    -- https://github.com/wez/wezterm/issues/909
    action = wezterm.action_callback(function(win, pane)
      local mux_win = win:mux_window()
      local idx = active_tab_idx(mux_win)
      -- wezterm.log_info('active_tab_idx: ', idx)
      local tab = mux_win:spawn_tab({})
      -- wezterm.log_info('movetab: ', idx)
      win:perform_action(wezterm.action.MoveTab(idx+1), pane)
    end),
   },
}

config.font = wezterm.font('JetBrains Mono')

-- Additional config not checked into git (ssh_domains, etc)
local local_config = os.getenv("HOME") .. "/.config/wezterm/local.lua"
local f = io.open(local_config, "r")
if f ~= nil and io.close(f) then
    dofile(local_config)
    hydrate_local(config)
end


return config
