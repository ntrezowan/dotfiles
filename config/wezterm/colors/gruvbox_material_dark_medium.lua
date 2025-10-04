-- ============================================================================= 
-- Theme for Wezterm
-- (goes to ~/.config/wezterm/colors/gruvbox-material-dark-medium.toml)
-- ============================================================================= 

local gruvbox_material_dark_medium = {
  -- Primary colors
  foreground = '#dfbf8e',
  background = '#282828',

  -- Cursor colors
  cursor_bg = '#dfbf8e',
  cursor_fg = '#282828',
  cursor_border = '#dfbf8e',

  -- Selection colors
  selection_fg = '#dfbf8e',
  selection_bg = '#665c54',

  -- Scrollbar
  scrollbar_thumb = '#665c54',

  -- Split lines between panes
  split = '#665c54',

  -- ANSI Colors (0-7)
  ansi = {
    '#665c54', -- Black
    '#ea6962', -- Red
    '#a9b665', -- Green
    '#e78a4e', -- Yellow
    '#7daea3', -- Blue
    '#d3869b', -- Magenta
    '#89b482', -- Cyan
    '#dfbf8e', -- White
  },

  -- Bright Colors (8-15)
  brights = {
    '#928374', -- Bright Black
    '#ea6962', -- Bright Red
    '#a9b665', -- Bright Green
    '#e3a84e', -- Bright Yellow
    '#7daea3', -- Bright Blue
    '#d3869b', -- Bright Magenta
    '#89b482', -- Bright Cyan
    '#dfbf8e', -- Bright White
  },

  -- Tab bar colors (for retro tab bar)
  tab_bar = {
    background = '#282828',
    active_tab = {
      bg_color = '#665c54',
      fg_color = '#dfbf8e',
    },
    inactive_tab = {
      bg_color = '#282828',
      fg_color = '#928374',
    },
    inactive_tab_hover = {
      bg_color = '#3c3836',
      fg_color = '#dfbf8e',
    },
    new_tab = {
      bg_color = '#282828',
      fg_color = '#928374',
    },
    new_tab_hover = {
      bg_color = '#3c3836',
      fg_color = '#dfbf8e',
    },
  },
}

return gruvbox_material_dark_medium