local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

local helpers = require("helpers")

-- Note: This theme does not show image notification icons

-- For antialiasing
-- The real background color is set in the widget_template
-- beautiful.notification_bg = "#00000000"

local urgency_color = {
    ['low'] = colors.active,
    ['normal'] = colors.color15,
    ['critical'] = "#000000",
}

-- Template
-- ===================================================================
naughty.connect_signal("request::display", function(n)
    local color = urgency_color[n.urgency]

    local actions = wibox.widget {
        notification = n,
        base_layout = wibox.widget {
            spacing = dpi(4),
            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id = 'text_role',
                        font = beautiful.notification_font,
                        widget = wibox.widget.textbox
                    },
                    left = dpi(8),
                    right = dpi(8),
                    widget = wibox.container.margin
                },
                widget = wibox.container.place
            },
            bg = beautiful.bg,
            forced_height = dpi(24),
            forced_width = dpi(64),
            widget = wibox.container.background
        },
        style = {
            underline_normal = false,
            underline_selected = true
        },
        widget = naughty.list.actions
    }

    naughty.layout.box {
        notification = n,
        type = "notification",
        shape = gears.shape.rectangle,
        border_width = beautiful.notification_border_width,
        border_color = beautiful.notification_border_color,
        position = beautiful.notification_position,
        widget_template = {
            {
                {
                    {
                        {
                            {
                                widget = naughty.widget.icon,
                            },
                            halign = "center",
                            valign = "center",
                            widget  = wibox.container.place,
                        },
                        {
                            {
                                {
                                    {
                                        align = "left",
                                        visible = n.title,
                                        font = beautiful.notification_font,
                                        markup = helpers.colorize_text("<b>"..n.title.."</b>", color),
                                        wrap = "word",
                                        widget = wibox.widget.textbox,
                                    },
                                    {
                                        align = "left",
                                        font = beautiful.notification_font,
                                        markup = helpers.colorize_text(n.message, color),
                                        wrap = "word",
                                        widget = wibox.widget.textbox,
                                    },
                                    {
                                        helpers.vertical_pad(dpi(16)),
                                        {
                                            actions,
                                            widget = wibox.container.background,
                                        },
                                        visible = n.actions and #n.actions > 0,
                                        layout  = wibox.layout.fixed.vertical
                                    },
                                    layout  = wibox.layout.align.vertical,
                                },
                                valign = "center",
                                layout = wibox.container.place,
                            },
                            left = beautiful.notification_margin,
                            widget = wibox.container.margin,
                        },
                        layout  = wibox.layout.fixed.horizontal,
                    },
                    margins = beautiful.notification_margin,
                    widget = wibox.container.margin,
                },
                strategy = "max",
                width    = beautiful.notification_max_width or dpi(512),
                height   = beautiful.notification_max_height or dpi(256),
                widget   = wibox.container.constraint,
            },
            bg = n.urgency == "critical" and "#ffaa00c0" or beautiful.bg,
            widget = wibox.container.background
        }
    }
end)
