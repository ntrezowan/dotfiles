local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Gruvbox Material Dark Medium colors
config.colors = {
  -- The default text color
  foreground = '#d4be98',
  -- The default background color
  background = '#282828',

  -- Overrides the cursor color.
  cursor_bg = '#d4be98',
  cursor_fg = '#282828',
  cursor_border = '#d4be98',

  -- the foreground color of selected text
  selection_fg = '#d4be98',
  -- the background color of selected text
  selection_bg = '#3c3836',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#928374',

  -- The color of the split lines between panes
  split = '#32302f',

  ansi = {
    '#32302f', -- black (normal)
    '#ea6962', -- red
    '#a9b665', -- green
    '#d8a657', -- yellow
    '#7daea3', -- blue
    '#d3869b', -- magenta
    '#89b482', -- cyan
    '#d4be98', -- white
  },
  brights = {
    '#928374', -- black (bright)
    '#ea6962', -- red
    '#a9b665', -- green
    '#d8a657', -- yellow
    '#7daea3', -- blue
    '#d3869b', -- magenta
    '#89b482', -- cyan
    '#ddc7a1', -- white
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  indexed = { [136] = '#d8a657' },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = '#e78a4e',

  -- Colors for copy_mode and quick_select
  -- available since: 20220807-113146-c2fee766
  -- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { Color = '#3c3836' },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using the name of the color role.
  copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
  copy_mode_inactive_highlight_bg = { Color = '#45403d' },
  copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

  quick_select_label_bg = { Color = '#d8a657' },
  quick_select_label_fg = { Color = '#282828' },
  quick_select_match_bg = { Color = '#e78a4e' },
  quick_select_match_fg = { Color = '#282828' },
}

-- Font configuration
config.font = wezterm.font('JetBrains Mono NL', { weight = 'Light' })
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font_size = 14
--config.freetype_load_target = 'Normal'
--config.freetype_render_target = 'Normal'
--config.freetype_load_target = "HorizontalLcd"
--config.freetype_render_target = "HorizontalLcd"
config.freetype_load_target = "Light"
config.freetype_render_target = "Light"

-- Window configuration
config.window_padding = {
  left = 15,
  right = 15,
  top = 10,
  bottom = 10,
}
config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 0.6,
}

-- Cursor configuration
config.default_cursor_style = 'SteadyBlock'
config.cursor_thickness = 1
config.selection_word_boundary = " \t\n{}[]()\"'`"

-- Performance optimizations
config.max_fps = 120
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'

-- Scrollback
config.scrollback_lines = 20000
config.enable_scroll_bar = false

-- Shell configuration
config.default_prog = { '/opt/homebrew/bin/fish' }

-- Security and behavior settings
config.audible_bell = 'Disabled'

-- Disable risky features
config.allow_square_glyphs_to_overflow_width = 'Never'
config.warn_about_missing_glyphs = false

-- Mouse configuration
config.hide_mouse_cursor_when_typing = true

-- Key bindings - Alt+Left/Right for word movement + additional useful ones
config.disable_default_key_bindings = true
config.keys = {
  -- Word movement (matching your Fish setup)
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = wezterm.action.SendString '\x1bb',
  },
  {
    key = 'RightArrow', 
    mods = 'ALT',
    action = wezterm.action.SendString '\x1bf',
  },
  -- Copy/paste improvements
  {
    key = 'c',
    mods = 'CMD',
    action = wezterm.action.CopyTo 'Clipboard',
  },
  {
    key = 'v', 
    mods = 'CMD',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  -- Font size adjustments
  {
    key = '=',
    mods = 'CMD',
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = '-',
    mods = 'CMD', 
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = '0',
    mods = 'CMD',
    action = wezterm.action.ResetFontSize,
  },
  -- Pane splitting
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'CTRL',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'f',
    mods = 'CMD',
    action = wezterm.action.Search { CaseInSensitiveString = '' },
  },
  {
    key = 'q',
    mods = 'CMD',
    action = wezterm.action.QuitApplication,
  },
  {
    key = 'UpArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
}

-- Hyperlink detection and opening
config.hyperlink_rules = {
  -- HTTP and HTTPS
  {
    regex = 'https?://[^\\s<>\"\\[\\]{}^⟨⟩`]+',
    format = '$0',
  },
  -- File URLs
  {
    regex = 'file://[^\\s<>\"\\[\\]{}^⟨⟩`]+',
    format = '$0',
  },
  -- Git URLs
  {
    regex = 'git://[^\\s<>\"\\[\\]{}^⟨⟩`]+',
    format = '$0',
  },
}

-- Smart selection patterns for double-click
config.quick_select_patterns = {
  -- URLs (http, https, ftp)
  'https?://[\\w\\d\\-\\.]+\\.[a-zA-Z]{2,}[^\\s]*',
  'ftp://[\\w\\d\\-\\.]+\\.[a-zA-Z]{2,}[^\\s]*',
  
  -- File paths (absolute and relative)
  '/[\\w\\d\\-\\._/]+',
  '\\./[\\w\\d\\-\\._/]+',
  '\\.\\.?/[\\w\\d\\-\\._/]+',
  '~/[\\w\\d\\-\\._/]+',
  
  -- IP addresses
  '\\b(?:[0-9]{1,3}\\.){3}[0-9]{1,3}\\b',
  
  -- Kubernetes resource names
  '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9]',
  
  -- AWS ARNs
  'arn:aws:[a-zA-Z0-9\\-]+:[a-zA-Z0-9\\-]*:[0-9]*:[a-zA-Z0-9\\-/\\._]+',
  
  -- Git commit hashes
  '\\b[a-f0-9]{7,40}\\b',
  
  -- Email addresses
  '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}',
  
  -- Hostnames/FQDNs
  '[a-zA-Z0-9][a-zA-Z0-9\\-\\.]*\\.[a-zA-Z]{2,}',
  
  -- UUIDs
  '[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}',
  
  -- File extensions and filenames
  '[\\w\\d\\-\\.]+\\.[a-zA-Z0-9]+',
  
  -- Command line flags
  '--?[a-zA-Z0-9][a-zA-Z0-9\\-]*',
  
  -- Environment variables
  '\\$[A-Za-z_][A-Za-z0-9_]*',
  
  -- Hex values
  '0x[a-fA-F0-9]+',
  
  -- Port numbers in context
  ':[0-9]{1,5}\\b'
}

-- Mouse bindings for hyperlinks (Ctrl+Click to open)
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
  },
  {
    event = { Up = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.SelectTextAtMouseCursor 'Word',
  },
  {
    event = { Up = { streak = 3, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.SelectTextAtMouseCursor 'Line',
  },
}

-- Better tab bar (even though disabled, good for future)
config.enable_tab_bar = false


-- Environment variables
config.set_environment_variables = {
  TERM = 'wezterm',
}

--Reduce unncessary processing
config.check_for_updates = false
--config.automatically_reload_config = false

return config
