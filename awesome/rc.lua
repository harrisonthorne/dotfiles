--[[
   ___       ___       ___       ___       ___       ___       ___
  /\  \     /\__\     /\  \     /\  \     /\  \     /\__\     /\  \
 /  \  \   / /\__\   /  \  \   /  \  \   /  \  \   /  L_L_   /  \  \
/  \ \__\ / / /\__\ /  \ \__\ /\ \ \__\ / /\ \__\ / /L \__\ /  \ \__\
\/\  /  / \  / /  / \ \ \/  / \ \ \/__/ \ \/ /  / \/_/ /  / \ \ \/  /
  / /  /   \  /  /   \ \/  /   \  /  /   \  /  /    / /  /   \ \/  /
  \/__/     \/__/     \/__/     \/__/     \/__/     \/__/     \/__/
--]]

--[[
Hot corners

+-----------------------------------------------------+
|                                 Media/notifications |
|                                                     |
|                                                     |
|                                                     |
|                                                     |
|                                                     |
|                                                     |
|                                                     |
|                                                     |
| App tray/system controls     Calendar/notifications |
+-----------------------------------------------------+
--]]

colors = require("colors")
local awful = require("awful")

-- Start apps
awful.spawn.with_shell(os.getenv("HOME") .. "/.config/wpg/wp_init.sh")
awful.spawn.with_shell(os.getenv("HOME") .. "/.config/awesome/autostart.sh")

local terminal = "kitty"
user = {
    -- >> Default applications <<
    -- Check apps.lua for more
    terminal = terminal,
    floating_terminal = terminal,
    browser = "firefox",
    file_manager = terminal.." --class files -e ranger",
    editor = terminal.." --class editor -e nvim",
    email_client = "thunderbird",
    music_client = "spotify",

    -- >> Web Search <<
    web_search_cmd = "xdg-open https://duckduckgo.com/?q=",

    -- >> User profile <<
    profile_picture = os.getenv("HOME").."/.config/awesome/profile.png",

    -- Directories with fallback values
    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        music = os.getenv("XDG_MUSIC_DIR") or "~/Music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
        videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
        -- Make sure the directory exists so that your screenshots
        -- are not lost
        screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Pictures/Screenshots",
    },

    -- >> calendar_drawer <<
    calendar_drawer = {
        hide_on_mouse_leave = true,
        show_on_mouse_screen_edge = true,
    },

    -- >> Battery <<
    -- You will receive notifications when your battery reaches these
    -- levels.
    battery_threshold_low = 20,
    battery_threshold_critical = 5,

    -- >> Weather <<
    -- Get your key and find your city id at
    -- https://openweathermap.org/
    -- (You will need to make an account!)
    openweathermap_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    openweathermap_city_id = "yyyyyy",
    -- > Use "metric" for Celcius, "imperial" for Fahrenheit
    weather_units = "imperial",
}
-- ===================================================================

-- Initialization
-- ===================================================================

-- Load keybinds and mousebinds
local keys = require("keys")

-- Theme handling library
local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()

-- Make dpi function global
dpi = beautiful.xresources.apply_dpi

-- Load AwesomeWM libraries
local gears = require("gears")
require("awful.autofocus")
-- Default notification library
local naughty = require("naughty")

-- Load theme
local theme_dir = os.getenv("HOME") .. "/.config/awesome/theme/"
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")


-- -- Error handling
-- -- ===================================================================
-- naughty.connect_signal("request::display_error", function(message, startup)
--     naughty.notification {
--         urgency = "critical",
--         title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
--         message = message
--     }
-- end)

-- Features
-- ===================================================================

-- Load notification daemons and notification theme
local notifications = require("notifications")
notifications.init()

-- Load window decoration theme and custom decorations
local decorations = require("decorations")
decorations.init()

-- Load helper functions
local helpers = require("helpers")

-- >> Elements - Desktop components
-- Statusbar(s)
require("elemental.bar")

-- Exit screen
require("elemental.exit")

-- calendar_drawer
require("elemental.calendar_drawer")

-- Dashboard (previously called: Start screen)
require("elemental.dashboard")

-- Window switcher
require("elemental.window_switcher")

-- >> Daemons
-- Most widgets that display system/external info depend on evil.
-- Make sure to initialize it last in order to allow all widgets to connect to
-- their needed evil signals.
require("evil")
-- ===================================================================
-- ===================================================================

-- Get screen geometry
-- I am using a single screen setup and I assume that screen geometry will not
-- change during the session.
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- Layouts
-- ===================================================================
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.append_default_layouts({
    awful.layout.suit.tile,
    -- awful.layout.suit.floating,
    awful.layout.suit.max,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
})

-- Wallpaper
-- ===================================================================
local function set_wallpaper(s)
    -- Wallpaper
    awful.spawn.easy_async_with_shell('wpg -c', function(stdout, _, __, ___) 
        local wallpaper = os.getenv("HOME") .. "/.config/wpg/wallpapers/" .. (stdout:match "^%s*(.-)%s*$")
        print(wallpaper)

        gears.wallpaper.maximized(wallpaper, s, false)
    end)
end

-- Set wallpaper
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
end)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Focus on hover
client.connect_signal("mouse::enter", function(c)                                                                                                                           
    client.focus = c 
end)

-- Tags
-- ===================================================================
awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    local l = awful.layout.suit -- Alias to save time :)

    -- Tag names
    local tagnames = beautiful.tagnames or { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }
    -- Create all tags at once (without seperate configuration for each tag)
    awful.tag(tagnames, s, l.tile)

    -- Create tags with seperate configuration for each tag
    -- awful.tag.add(tagnames[1], {
    --     layout = layouts[1],
    --     screen = s,
    --     master_width_factor = 0.6,
    --     selected = true,
    -- })
    -- ...
end)

-- Determines how floating clients should be placed
local floating_client_placement = function(c)
    -- If the layout is floating or there are no other visible
    -- clients, center client
    if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating or #mouse.screen.clients == 1 then
        return awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
    end

    -- Else use this placement
    local p = awful.placement.no_overlap + awful.placement.no_offscreen
    return p(c, {honor_padding = true, honor_workarea=true, margins = beautiful.useless_gap * 2})
end

local centered_client_placement = function(c)
    return gears.timer.delayed_call(function ()
        awful.placement.centered(c, {honor_padding = true, honor_workarea=true})
    end)
end

-- Rules
-- ===================================================================
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    {
        -- All clients will match this rule.
        rule = { },
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            screen = awful.screen.focused,
            size_hints_honor = true,
            honor_workarea = true,
            honor_padding = true,
            titlebars_enabled = beautiful.titlebars_enabled,
            fullscreen = false,
        },
    }
}

-- Signals
-- ===================================================================
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set every new window as a slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if c.requests_no_titlebar then
        awful.titlebar:hide(c)
    end
end)

if beautiful.border_width and beautiful.border_width > 0 then
    client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
    client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
end

-- Set mouse resize mode (live or after)
awful.mouse.resize.set_mode("live")

-- When switching to a tag with urgent clients, raise them.
-- This fixes the issue (visual mismatch) where after switching to
-- a tag which includes an urgent client, the urgent client is
-- unfocused but still covers all other windows (even the currently
-- focused window).
awful.tag.attached_connect_signal(s, "property::selected", function ()
    local urgent_clients = function (c)
        return awful.rules.match(c, { urgent = true })
    end
    for c in awful.client.iterate(urgent_clients) do
        if c.first_tag == mouse.screen.selected_tag then
            client.focus = c
        end
    end
end)

-- Raise focused clients automatically
client.connect_signal("focus", function(c) c:raise() end)

-- Always keep floating clients on top
client.connect_signal('property::floating', function(c)
    if c.floating then
        c.ontop = true
    else
        c.ontop = false
    end
end)

-- Garbage collection
-- Enable for lower memory consumption
-- ===================================================================

-- collectgarbage("setpause", 160)
-- collectgarbage("setstepmul", 400)

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
