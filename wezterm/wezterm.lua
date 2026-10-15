local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.font_size = 10.0
config.initial_rows = 60
config.initial_cols = 132

config.enable_scroll_bar = true
config.scrollback_lines = 1000000
config.audible_bell = "Disabled"
config.warn_about_missing_glyphs = false
config.enable_wayland = false
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

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

-- Open tab to right of current tab
-- https://github.com/wez/wezterm/issues/909#issuecomment-1738831414
local open_tab_to_right = wezterm.action_callback(function(win, pane)
  local mux_win = win:mux_window()
  local idx = active_tab_idx(mux_win)
  -- wezterm.log_info('active_tab_idx: ', idx)
  local tab = mux_win:spawn_tab({})
  -- wezterm.log_info('movetab: ', idx)
  win:perform_action(wezterm.action.MoveTab(idx+1), pane)
end)

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
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = open_tab_to_right,
   },
  {
    key = 't',
    mods = 'SUPER',
    -- https://github.com/wez/wezterm/issues/909
    action = open_tab_to_right,
  },
  -- ctrl+shift+a enters copy mode (so doing it twice selects all)
  {
    key = 'a',
    mods = 'CTRL|SHIFT',
    action = act.ActivateCopyMode,
  },
}

if wezterm.gui then
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  search_mode = wezterm.gui.default_key_tables().search_mode

  -- Make sure we clear the pattern when closing, I hate having to remember to do that
  table.insert(
    search_mode,
    {
      key = 'Escape',
      mods = 'NONE',
      action = act.Multiple {
        { CopyMode = 'ClearPattern' },
        { CopyMode = 'Close' },
      }
    }
  )

  -- Enter finds previous
  table.insert(
    search_mode,
    { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' }
  )

  -- Shift+Enter finds next (xremap turns shift+enter into ctrl+j)
  table.insert(
    search_mode,
    { key = 'j', mods = 'CTRL', action = act.CopyMode 'NextMatch' }
  )

  -- Ctrl+Shift+A selects all in copy mode
  table.insert(
    copy_mode,
    {
      key = 'a',
      mods = 'CTRL|SHIFT',
      action = act.Multiple {
        { CopyMode = 'MoveToScrollbackTop' },
        { CopyMode = { SetSelectionMode = 'Line' } },
        { CopyMode = 'MoveToScrollbackBottom' },
      }
    }
  )

  config.key_tables = {
    copy_mode = copy_mode,
    search_mode = search_mode,
  }
end

config.font = wezterm.font('JetBrains Mono')

config.mouse_bindings = {
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
      event={Up={streak=1, button="Left"}},
      mods="NONE",
      action=act.CompleteSelection("PrimarySelection"),
    },

    -- and make CTRL-Click open hyperlinks
    {
      event={Up={streak=1, button="Left"}},
      mods="CTRL",
      action=act.OpenLinkAtMouseCursor,
    },

    -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
    {
      event = { Down = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.Nop,
    }
}

-- Additional config not checked into git (ssh_domains, etc)
-- I have this defining a function `hydrate_local(config)`, example:
--
-- function hydrate_local(config)
--     config.ssh_domains = { ... }
-- end
--
local local_config = os.getenv("HOME") .. "/.config/wezterm/local.lua"
local f = io.open(local_config, "r")
if f ~= nil and io.close(f) then
    dofile(local_config)
    hydrate_local(config)
end

-- Similarly a separate file for dark mode, as I want to be able to easily
-- completely rewrite it.
rawset(_G, "dark_mode", false)
dark_mode = false

local darkmode_config_path = os.getenv("HOME") .. "/.config/wezterm/dark_mode.lua"
local f = io.open(darkmode_config_path, "r")
if f ~= nil and io.close(f) then
    dofile(darkmode_config_path)
end
if dark_mode then
    config.color_scheme = 'Vs Code Dark+ (Gogh)'
else
    config.color_scheme = 'Vs Code Light+ (Gogh)'
end


return config
