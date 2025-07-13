-- Import the wezterm api
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of WezTerm, use the config_builder which is recommended.
if wezterm.config_builder then
  config = wezterm.config_builder()
end


--================================================================
-- Appearance
--================================================================

config.enable_wayland = false

-- Font configuration
config.font = wezterm.font_with_fallback({
  'CaskaydiaCove Nerd Font Mono',
  'monospace',
})
config.font_size = 14.0

-- WezTerm's equivalent of "modify_font cell_width 95%"
config.cell_width = 0.95

-- Window settings
config.audible_bell = "Disabled"
config.window_padding = {
  left = 25,
  right = 25,
  top = 25,
  bottom = 25,
}

-- Commented-out kitty options, translated for WezTerm
-- config.window_background_opacity = 0.60
-- config.window_decorations = "NONE"
-- config.warn_about_multiple_windows_when_quitting = false

--================================================================
-- Theme & Colors
--================================================================
config.colors = {
  foreground = '#FFFFFF',
  background = '#0F1318',

  selection_fg = '#0F1318',
  selection_bg = '#FFFFFF',

  cursor_bg = '#B298CB',
  cursor_fg = '#0C0D0C',
  cursor_border = '#B298CB',

  -- Tab Bar
  tab_bar = {
    background = '#0F1318',
    active_tab = {
      bg_color = '#525263',
      fg_color = '#0F1318',
    },
    inactive_tab = {
      bg_color = '#0F1318',
      fg_color = '#525263',
    },
  },

  -- ANSI Colors (color0-7)
  ansi = {
    '#293B52', -- black
    '#E6CCFF', -- red
    '#CCE3FF', -- green
    '#CCCCFF', -- yellow
    '#9ABBE6', -- blue
    '#9ABBE6', -- magenta
    '#9A9AE6', -- cyan
    '#E6CCFF', -- white
  },

  -- Bright ANSI Colors (color8-15)
  brights = {
    '#57708F', -- bright black
    '#CEAAF0', -- bright red
    '#AAC9F0', -- bright green
    '#AAAAF0', -- bright yellow
    '#9ABBE6', -- bright blue
    '#9ABBE6', -- bright magenta
    '#9A9AE6', -- bright cyan
    '#CEAAF0', -- bright white
  },
}


--================================================================
-- Cursor
--================================================================
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 500 -- A standard blink rate, 0 to disable.

-- Note: WezTerm does not have a GPU cursor trail effect like Kitty's
-- `cursor_trail`. This feature cannot be translated.

--================================================================
-- Keybindings
--================================================================
config.keys = {
  -- Equivalent of `map ctrl+shift+t new_tab_with_cwd`
  {
    key = 'T',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = 'CurrentPaneDomain',
    },
  },
  -- Equivalent of `map ctrl+alt+t new_tab`
  {
    key = 'T',
    mods = 'CTRL|ALT',
    action = wezterm.action.SpawnCommandInNewTab {
      -- No cwd specified, so it uses the default path (e.g., home directory)
    },
  },
  -- Equivalent of `map ctrl+shift+space enter_vi_mode`
  {
    key = ' ',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateCopyMode,
  },
}

--================================================================
-- Final return
--================================================================
return config
