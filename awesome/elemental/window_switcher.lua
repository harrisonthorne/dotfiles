local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local keys = require("keys")
local gears = require("gears")
local capi = { screen = screen, client = client }

-- TODO ability to switch to specific minimized clients without using the mouse:
-- Might need to ditch the "easy" tasklist approach for something manual

local window_switcher_margin = dpi(10)
local item_height = dpi(50)
local item_width = dpi(500)

local window_switcher_hide
local get_num_clients
awful.screen.connect_for_each_screen(function(s)
    -- Tasklist
    s.window_switcher_tasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = keys.tasklist_buttons,
        style    = {
            font = beautiful.tasklist_font,
            -- font = "sans 10 medium",
            bg = colors.color0.."00",
        },
        layout   = {
            layout  = wibox.layout.fixed.vertical
        },
        widget_template = {
            {
                -- Standard icon (from beautiful.icon_theme)
                {
                    awful.widget.clienticon,
                    margins = 5,
                    widget  = wibox.container.margin
                },
                {
                    {
                        id     = 'text_role',
                        align  = "center",
                        widget = wibox.widget.textbox,
                    },
                    left = dpi(6),
                    right = dpi(14),
                    -- Add margins to top and bottom in order to force the
                    -- text to be on a single line, if needed. Might need
                    -- to adjust them according to font size.
                    top  = dpi(14),
                    bottom = dpi(14),
                    widget = wibox.container.margin
                },
                layout  = wibox.layout.fixed.horizontal
            },
            forced_height = item_height,
            id = "bg_role",
            widget = wibox.container.background,
        },
    }

    s.window_switcher = awful.popup({
        visible = false,
        ontop = true,
        screen = s,
        bg = "#00000000",
        fg = colors.foreground,
        widget = {
            {
                s.window_switcher_tasklist,
                forced_width = item_width,
                margins = window_switcher_margin,
                widget = wibox.container.margin
            },
            bg = colors.color0.."c0",
            shape = helpers.rrect(beautiful.border_radius),
            widget = wibox.container.background
        }
    })

    -- Center window switcher whenever its height changes
    s.window_switcher:connect_signal("property::height", function()
        awful.placement.centered(s.window_switcher, { honor_workarea = true, honor_padding = true })
        if get_num_clients(s) == 0 then
            window_switcher_hide()
        end
    end)
end)

get_num_clients = function(s)
    local minimized_clients_in_tag = 0
    local matcher = function (c)
        return awful.rules.match(c, { minimized = true, skip_taskbar = false, hidden = false, first_tag = s.selected_tag })
    end
    for c in awful.client.iterate(matcher) do
        minimized_clients_in_tag = minimized_clients_in_tag + 1
    end
    return minimized_clients_in_tag + #s.clients
end

-- The client that was focused when the window_switcher was activated
local window_switcher_first_client

-- Keygrabber configuration
-- Helper functions for keybinds
local window_switcher_grabber
window_switcher_hide = function()
    -- Add currently focused client to history
    if client.focus then
        local window_switcher_last_client = client.focus
        awful.client.focus.history.add(window_switcher_last_client)
        -- Raise client that was focused originally
        -- Then raise last focused client
        if window_switcher_first_client and window_switcher_first_client.valid then
            window_switcher_first_client:raise()
            window_switcher_last_client:raise()
        end
    end
    -- Resume recording focus history
    awful.client.focus.history.enable_tracking()
    -- Stop and hide window_switcher
    local s = awful.screen.focused()
    awful.keygrabber.stop(window_switcher_grabber)
    s.window_switcher.visible = false
end

local window_search = function()
    window_switcher_hide()
    awful.spawn.with_shell("rofi_awesome_window")
end

local unminimize = function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
        client.focus = c
    end
end

local close = function()
    if client.focus then client.focus:kill() end
end

-- Set up keybinds
-- Single keys only
local keybinds = {
    ['Escape'] = window_switcher_hide,
    ['Tab'] = function() awful.client.focus.byidx(1) end,
    -- (Un)Minimize
    ['n'] = function() if client.focus then client.focus.minimized = true end end,
    ['N'] = unminimize,
    ['u'] = unminimize, -- `u` for up
    -- Close
    ['d'] = close,
    ['q'] = close,
    -- Move with vim keys
    ['j'] = function() awful.client.focus.byidx(1) end,
    ['k'] = function() awful.client.focus.byidx(-1) end,
    -- Move with arrow keys
    ['Down'] = function() awful.client.focus.byidx(1) end,
    ['Up'] = function() awful.client.focus.byidx(-1) end,
    -- Space
    [' '] = window_search
}

function window_switcher_show(s)
    if get_num_clients(s) == 0 then
        return
    end
    -- Store client that is focused in a variable
    window_switcher_first_client = client.focus

    -- Stop recording focus history
    awful.client.focus.history.disable_tracking()

    -- Go to previously focused client (in the tag)
    awful.client.focus.history.previous()

    -- Start the keygrabber
    window_switcher_grabber = awful.keygrabber.run(function(_, key, event)
        if event == "release" then
            -- Hide if the modifier was released
            -- We try to match Super or Alt or Control since we do not know which keybind is
            -- used to activate the window switcher (the keybind is set by the user in keys.lua)
            if key:match("Super") or key:match("Alt") or key:match("Control") then
                window_switcher_hide()
            end
            -- Do nothing
            return
        end

        -- Run function attached to key, if it exists
        if keybinds[key] then
            keybinds[key]()
        end
    end)

    gears.timer.delayed_call(function()
        -- Finally make the window switcher wibox visible after
        -- a small delay, to allow the popup size to update
        s.window_switcher.visible = true
    end)
end

