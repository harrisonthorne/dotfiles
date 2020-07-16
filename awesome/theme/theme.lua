local awful = require("awful")
local wibox = require("wibox")
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
local xrdb = xresources.get_current_theme()
-- local theme = dofile(themes_path.."default/theme.lua")
local theme = {}

-- Set theme wallpaper.
-- It won't change anything if you are using feh to set the wallpaper like I do.
-- theme.wallpaper = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/wallpaper.jpg"

-- Set the theme font. This is the font that will be used by default in menus, bars, titlebars etc.
theme.font          = "sans 10"
-- theme.font          = "monospace 10"

-- This is how to get other .Xresources values (beyond colors 0-15, or custom variables)
-- local cool_color = awesome.xrdb_get_value("", "color16")

theme.bg_dark       = colors.background
theme.bg_normal     = colors.color0
theme.bg_focus      = colors.color8
theme.bg_urgent     = "#ffaa00"
theme.bg_minimize   = colors.color8
theme.bg_systray    = colors.background

theme.fg_normal     = colors.color8
theme.fg_focus      = colors.color4
theme.fg_urgent     = colors.color0
theme.fg_minimize   = colors.color8

-- Gaps
theme.useless_gap   = dpi(4)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(4)

-- Borders
theme.border_width  = dpi(0)
-- theme.border_color = colors.color0
theme.border_normal = colors.background
theme.border_focus  = colors.background
-- Rounded corners
theme.border_radius = dpi(8)

-- Titlebars
-- (Titlebar items can be customized in titlebars.lua)
theme.titlebars_enabled = true
theme.titlebar_size = dpi(32)
theme.titlebar_title_enabled = true
theme.titlebar_font = "sans 10"
-- Window title alignment: left, right, center
theme.titlebar_title_align = "center"
-- Titlebar position: top, bottom, left, right
theme.titlebar_position = "top"
theme.titlebar_bg = colors.background.."c0"
-- theme.titlebar_bg_focus = colors.color12
-- theme.titlebar_bg_normal = colors.color8
theme.titlebar_fg_focus = colors.color15
theme.titlebar_fg_normal = colors.color15.."40"
--theme.titlebar_fg = colors.color7

-- Notifications
-- ============================
-- Note: Some of these options are ignored by my custom
-- notification widget_template
-- ============================
-- Position: bottom_left, bottom_right, bottom_middle,
--         top_left, top_right, top_middle
theme.notification_position = "top_right"
theme.notification_border_width = theme.border_width
theme.notification_border_radius = dpi(8)
theme.notification_border_color = colors.color10
theme.notification_bg = colors.background
-- theme.notification_bg = colors.color8
theme.notification_fg = colors.foreground
theme.notification_crit_bg = colors.background
theme.notification_crit_fg = colors.color1
theme.notification_icon_size = dpi(60)
-- theme.notification_height = dpi(80)
-- theme.notification_width = dpi(300)
theme.notification_margin = dpi(16)
theme.notification_opacity = 1
theme.notification_font = "sans 10"
theme.notification_padding = theme.screen_margin * 2
theme.notification_spacing = theme.screen_margin * 4

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
    "0",
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
theme.wibar_height = dpi(45)
theme.wibar_fg = colors.background
theme.wibar_bg = colors.foreground
--theme.wibar_opacity = 0.7
theme.wibar_border_color = colors.color0
theme.wibar_border_width = dpi(0)
theme.wibar_border_radius = dpi(8)
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
--theme.taglist_bg_focus = "#ff0000"

 --Tasklist
theme.tasklist_font = "sans 10"
theme.tasklist_disable_icon = true
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = colors.color0
theme.tasklist_fg_focus = colors.foreground
theme.tasklist_bg_normal = "#00000000"
theme.tasklist_fg_normal = colors.foreground.."77"
theme.tasklist_bg_minimize = "#00000000"
theme.tasklist_fg_minimize = colors.color8
-- theme.tasklist_font_minimized = "sans italic 8"
theme.tasklist_bg_urgent = "#ffaa00"
theme.tasklist_fg_urgent = colors.color0
theme.tasklist_spacing = dpi(0)
theme.tasklist_align = "center"

-- Sidebar
-- (Sidebar items can be customized in sidebar.lua)
theme.sidebar_bg = colors.background
theme.sidebar_fg = colors.color7
theme.sidebar_opacity = 0.75
theme.sidebar_position = "left" -- left or right
theme.sidebar_width = dpi(384)
theme.sidebar_x = 0
theme.sidebar_y = 0
theme.sidebar_border_radius = dpi(16)

-- Dashboard
theme.dashboard_bg = colors.color0.."c0"
theme.dashboard_fg = colors.color7

-- Exit screen
theme.exit_screen_bg = colors.color0 .. "c0"
theme.exit_screen_fg = colors.color7
theme.exit_screen_font = "sans 20"
theme.exit_screen_icon_size = dpi(180)

-- Lock screen
theme.lock_screen_bg = colors.color0.."c0"
theme.lock_screen_fg = colors.color7

-- Icon taglist
local ntags = 10
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}
-- table.insert(tag_icons, tag)
for i = 1, ntags do
  theme.taglist_icons_empty[i] = taglist_icon_path .. tostring(i) .. "_empty.png"
  theme.taglist_icons_occupied[i] = taglist_icon_path .. tostring(i) .. "_occupied.png"
  theme.taglist_icons_focused[i] = taglist_icon_path .. tostring(i) .. "_focused.png"
  theme.taglist_icons_urgent[i] = taglist_icon_path .. tostring(i) .. "_urgent.png"
end

-- Noodle Text Taglist
theme.taglist_text_font = "monospace 25"
-- theme.taglist_text_font = "sans bold 15"
theme.taglist_text_empty    = {"","","","","","","","","",""}
theme.taglist_text_occupied = {"","","","","","","","","",""}
theme.taglist_text_focused  = {"o","o","o","o","o","o","o","o","o","o"}
-- theme.taglist_text_focused  = {"","","","","","","","","",""}
theme.taglist_text_urgent   = {"+","+","+","+","+","+","+","+","+","+"}
-- theme.taglist_text_urgent   = {"","","","","","","","","",""}
-- theme.taglist_text_urgent   = {"","","","","","","","","",""}

theme.taglist_text_color_empty  = { colors.background.."22", colors.background.."22", colors.background.."22", colors.background.."22", colors.background.."22", colors.background.."22", colors.background.."22", colors.background.."22", colors.background.."22", colors.background.."22" }
-- theme.taglist_text_color_occupied  = { colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0" }
-- theme.taglist_text_color_focused  = { colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0", colors.foreground.."F0" }
-- theme.taglist_text_color_urgent  = { colors.foreground, colors.foreground, colors.foreground, colors.foreground, colors.foreground, colors.foreground, colors.foreground, colors.foreground, colors.foreground, colors.foreground }

theme.taglist_text_color_occupied  = { colors.color1.."99", colors.color2.."99", colors.color3.."99", colors.color4.."99", colors.color5.."99", colors.color6.."99", colors.color1.."99", colors.color2.."99", colors.color3.."99", colors.color4.."99" }
theme.taglist_text_color_focused  = { colors.color9, colors.color10, colors.color11, colors.color12, colors.color13, colors.color14, colors.color9, colors.color10, colors.color11, colors.color12 }
theme.taglist_text_color_urgent   = { "#ffaa00", "#ffaa00", "#ffaa00", "#ffaa00", "#ffaa00", "#ffaa00", "#ffaa00", "#ffaa00", "#ffaa00", "#ffaa00" }
-- theme.taglist_text_color_urgent   = { colors.color0, colors.color0, colors.color0, colors.color0, colors.color0, colors.color0, colors.color0, colors.color0, colors.color0, colors.color0 }

-- Prompt
theme.prompt_fg = colors.color12

-- Text Taglist (default)
theme.taglist_font = "monospace 10"
theme.taglist_bg_focus = colors.background
theme.taglist_fg_focus = colors.color12
theme.taglist_bg_occupied = colors.background
theme.taglist_fg_occupied = colors.color8
theme.taglist_bg_empty = colors.background
theme.taglist_fg_empty = colors.background
theme.taglist_bg_urgent = "#ffaa00"
theme.taglist_fg_urgent = colors.color0
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(0)
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming the menu:
theme.menu_height = dpi(32)
theme.menu_width  = dpi(128)
theme.menu_bg_normal = colors.color0
theme.menu_fg_normal= colors.color7
theme.menu_bg_focus = colors.color8 .. "55"
theme.menu_fg_focus= colors.color7
theme.menu_border_width = dpi(0)
theme.menu_border_color = colors.color0

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

-- Recolor layout icons
--theme = theme_assets.recolor_layout(theme, colors.color1)

-- Noodle widgets customization --
-- Desktop mode widget variables
-- Symbols     
-- theme.desktop_mode_color_floating = colors.color4
-- theme.desktop_mode_color_tile = colors.color3
-- theme.desktop_mode_color_max = colors.color1
-- theme.desktop_mode_text_floating = "f"
-- theme.desktop_mode_text_tile = "t"
-- theme.desktop_mode_text_max = "m"

-- Minimal tasklist widget variables
theme.minimal_tasklist_visible_clients_color = colors.color4
theme.minimal_tasklist_visible_clients_text = ""
theme.minimal_tasklist_hidden_clients_color = colors.color7
theme.minimal_tasklist_hidden_clients_text = ""

-- Mpd song
theme.mpd_song_title_color = colors.color7
theme.mpd_song_artist_color = colors.color7
theme.mpd_song_paused_color = colors.color8

-- Volume bar
theme.volume_bar_active_color = colors.color5
theme.volume_bar_active_background_color = colors.color0
theme.volume_bar_muted_color = colors.color8
theme.volume_bar_muted_background_color = colors.color0

-- Temperature bar
theme.temperature_bar_active_color = colors.color1
theme.temperature_bar_background_color = colors.color0

-- Battery bar
theme.battery_bar_active_color = colors.color6
theme.battery_bar_background_color = colors.color0

-- CPU bar
theme.cpu_bar_active_color = colors.color2
theme.cpu_bar_background_color = colors.color0

-- RAM bar
theme.ram_bar_active_color = colors.color4
theme.ram_bar_background_color = colors.color0

-- Brightness bar
theme.brightness_bar_active_color = colors.color3
theme.brightness_bar_background_color = colors.color0

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Flat-Remix-Blue-Dark"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
