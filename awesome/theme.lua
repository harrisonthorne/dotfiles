local awful = require("awful")
local gears = require("gears")
local theme_name = "amarena"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/icons/layout/"
local titlebar_icon_path = os.getenv("HOME") .. "/.config/awesome/icons/titlebar/"
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/icons/taglist/"
local tip = titlebar_icon_path --alias to save time/space
local theme = {}

local bg_alpha_hex = "c0"
local unfocused_alpha = "40"

-- Set the theme font. This is the font that will be used by default in menus, bars, titlebars etc.
theme.font          = "sans 10"

theme.bg            = colors.color0 .. bg_alpha_hex
theme.bg_dark       = theme.bg
theme.bg_normal     = theme.bg
theme.bg_focus      = colors.color8
theme.bg_urgent     = "#ffaa00"
theme.bg_minimize   = theme.bg
theme.bg_systray    = theme.bg

theme.fg            = colors.color15
theme.fg_normal     = theme.fg
theme.fg_unfocused  = theme.fg .. unfocused_alpha
theme.fg_focus      = theme.fg
theme.fg_urgent     = colors.color0
theme.fg_minimize   = colors.color8

theme.transparent   = "#00000000"

-- Gaps
theme.useless_gap   = dpi(8)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(8)

-- Borders
theme.border_width  = dpi(0)
theme.border_color = theme.bg
theme.border_normal = colors.background
theme.border_focus  = colors.background

-- Rounded corners
theme.border_radius = dpi(0)

-- Titlebars
-- (Titlebar items can be customized in titlebars.lua)
theme.titlebars_enabled = true
theme.titlebar_size = dpi(32)
theme.titlebar_title_enabled = true
theme.titlebar_font = "sans 10"
theme.titlebar_title_align = "center"
theme.titlebar_position = "top"
theme.titlebar_bg = theme.bg
theme.titlebar_fg_focus = theme.fg
theme.titlebar_fg_normal = theme.fg_unfocused

-- Notifications
-- ============================
-- Note: Some of these options are ignored by my custom
-- notification widget_template
-- ============================
-- Position: bottom_left, bottom_right, bottom_middle, top_left, top_right, top_middle
theme.notification_position = "top_right"
theme.notification_border_width = theme.border_width
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = theme.border_color
theme.notification_bg = theme.bg
theme.notification_fg = theme.fg
theme.notification_crit_bg = theme.bg
theme.notification_crit_fg = colors.color1
theme.notification_icon_size = dpi(32)
theme.notification_margin = dpi(16)
theme.notification_opacity = 1
theme.notification_font = "sans 10"
theme.notification_padding = dpi(16)
theme.notification_spacing = dpi(8)

-- Edge snap
theme.snap_shape = gears.shape.rectangle
theme.snap_bg = colors.foreground
theme.snap_border_width = dpi(4)

-- Tag names
theme.tagnames = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
}

-- Widget separator
theme.separator_text = "|"
--theme.separator_text = " :: "
--theme.separator_text = " • "
-- theme.separator_text = " •• "
theme.separator_fg = colors.color8

-- Wibar(s)
-- Keep in mind that these settings could be ignored by the bar theme
theme.wibar_position = "bottom"
theme.wibar_height = dpi(64)
theme.wibar_fg = colors.background
theme.wibar_bg = colors.foreground..bg_alpha_hex
--theme.wibar_opacity = 0.7
theme.wibar_border_color = theme.bg
theme.wibar_border_width = dpi(0)
theme.wibar_border_radius = theme.border_radius
theme.wibar_width = dpi(380)

theme.prefix_fg = colors.color8

 --There are other variable sets
 --overriding the default one when
 --defined, the sets are:
 --taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
 --tasklist_[bg|fg]_[focus|urgent]
 --titlebar_[bg|fg]_[normal|focus]
 --tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
 --mouse_finder_[color|timeout|animate_timeout|radius|factor]
 --prompt_[fg|bg|fg_cursor|bg_cursor|font]
 --hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
 --Example:
 theme.hotkeys_bg = theme.bg
 theme.hotkeys_fg = theme.fg
 theme.hotkeys_modifiers_fg = colors.color14
 theme.hotkeys_font = "sans 10"
 theme.hotkeys_description_font = "sans 8"
 theme.hotkeys_label_bg = colors.color0
 theme.hotkeys_label_fg = colors.color13
 theme.hotkeys_group_margin = dpi(16)

 --Tasklist
theme.tasklist_font = "sans 10"
theme.tasklist_disable_icon = true
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.bg
theme.tasklist_fg_focus = colors.foreground
theme.tasklist_bg_normal = "#00000000"
theme.tasklist_fg_normal = colors.foreground.."77"
theme.tasklist_bg_minimize = "#00000000"
theme.tasklist_fg_minimize = colors.color8
theme.tasklist_font_minimized = "sans italic 10"
theme.tasklist_bg_urgent = "#ffaa00"
theme.tasklist_fg_urgent = theme.bg
theme.tasklist_spacing = dpi(0)
theme.tasklist_align = "center"

-- Sidebar
-- (Sidebar items can be customized in sidebar.lua)
theme.sidebar_bg = colors.background
theme.sidebar_fg = colors.color7
theme.sidebar_opacity = 0.75
theme.sidebar_position = "left" -- left or right
theme.sidebar_width = dpi(384)
-- XXX These were removed from sidebar.lua
-- theme.sidebar_x = dpi(8)
-- theme.sidebar_y = dpi(8)
theme.sidebar_border_radius = theme.border_radius

-- Dashboard
theme.dashboard_bg = theme.bg..bg_alpha_hex
theme.dashboard_fg = colors.color7

-- Exit screen
theme.exit_screen_bg = theme.bg .. bg_alpha_hex
theme.exit_screen_fg = colors.color7
theme.exit_screen_font = "sans 20"
theme.exit_screen_icon_size = dpi(180)

-- Lock screen
theme.lock_screen_bg = theme.bg..bg_alpha_hex
theme.lock_screen_fg = colors.color7

-- Prompt
theme.prompt_fg = colors.color12

-- Text Taglist (default)
theme.taglist_font = "sans 10"
theme.taglist_bg_focus = theme.transparent
theme.taglist_bg_occupied = theme.transparent
theme.taglist_bg_empty = colors.background
theme.taglist_bg_urgent = "#ffaa00"
theme.taglist_fg_focus = theme.fg
theme.taglist_fg_occupied = theme.fg_unfocused
theme.taglist_fg_empty = theme.transparent
theme.taglist_fg_urgent = theme.bg
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(0)

-- Variables set for theming the menu:
theme.menu_height = dpi(32)
theme.menu_width  = dpi(128)
theme.menu_bg_normal = theme.bg
theme.menu_fg_normal= colors.color7
theme.menu_bg_focus = colors.color8 .. "80"
theme.menu_fg_focus= colors.color7
theme.menu_border_width = dpi(0)
theme.menu_border_color = theme.bg

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#ce5000"

-- You can use your own layout icons like this:
theme.layout_fairh = layout_icon_path .. "fairh.png"
theme.layout_fairv = layout_icon_path .. "fairv.png"
theme.layout_floating  = layout_icon_path .. "floating.png"
theme.layout_magnifier = layout_icon_path .. "magnifier.png"
theme.layout_max = layout_icon_path .. "max.png"
theme.layout_fullscreen = layout_icon_path .. "fullscreen.png"
theme.layout_tilebottom = layout_icon_path .. "tilebottom.png"
theme.layout_tileleft   = layout_icon_path .. "tileleft.png"
theme.layout_tile = layout_icon_path .. "tile.png"
theme.layout_tiletop = layout_icon_path .. "tiletop.png"
theme.layout_spiral  = layout_icon_path .. "spiral.png"
theme.layout_dwindle = layout_icon_path .. "dwindle.png"
theme.layout_cornernw = layout_icon_path .. "cornernw.png"
theme.layout_cornerne = layout_icon_path .. "cornerne.png"
theme.layout_cornersw = layout_icon_path .. "cornersw.png"
theme.layout_cornerse = layout_icon_path .. "cornerse.png"

-- Mpd song
theme.mpd_song_title_color = colors.color7
theme.mpd_song_artist_color = colors.color7
theme.mpd_song_paused_color = colors.color8

-- Volume bar
theme.volume_bar_active_color = colors.color5
theme.volume_bar_active_background_color = theme.bg
theme.volume_bar_muted_color = colors.color8
theme.volume_bar_muted_background_color = theme.bg

-- Temperature bar
theme.temperature_bar_active_color = colors.color1
theme.temperature_bar_background_color = theme.bg

-- Battery bar
theme.battery_bar_active_color = colors.color6
theme.battery_bar_background_color = theme.bg

-- CPU bar
theme.cpu_bar_active_color = colors.color2
theme.cpu_bar_background_color = theme.bg

-- RAM bar
theme.ram_bar_active_color = colors.color4
theme.ram_bar_background_color = theme.bg

-- Brightness bar
theme.brightness_bar_active_color = colors.color3
theme.brightness_bar_background_color = theme.bg

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Flat-Remix-Blue-Dark"

theme.cpu_bar_active_color = "#ff00aa"
theme.brightness_bar_active_color = "#00ffaa"
theme.battery_bar_active_color = "#00aaff"
theme.temperature_bar_active_color = "#aa00ff"
theme.volume_bar_active_color = "#aaff00"
theme.ram_bar_active_color = "#aa00aa"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
