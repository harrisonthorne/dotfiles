-- TODO: The functions that create and update the buttons should be decoupled
-- from the dock logic. This will make it easy to create new dock themes.
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local apps = require("apps")
local cairo = require("lgi").cairo
-- local class_icons = icons.text.by_class

local item_font = "Material Design Icons 15"
local item_bg = colors.background
local item_size = dpi(48)
local item_shape = helpers.squircle(1.7, 0)
local item_margin = dpi(8) -- For spacing between items
local indicator_spacing = dpi(12)
local indicator_height = dpi(4)
-- Custom arc shape
local function draw_indicator_shape_unfocused(cr)
    cr:arc(item_size / 2, indicator_height, indicator_height, 0, 2 * math.pi)
    cr:close_path()
    cr:fill()
end

dock = awful.widget.tasklist {
    screen   = screen[1],
    filter   = awful.widget.tasklist.filter.allscreen,
    buttons  = tasklist_buttons,
    style    = {
        shape = gears.shape.rounded_rect,
    },
    layout   = {
        spacing = dpi(16),
        layout = wibox.layout.fixed.horizontal
    },
    widget_template = {
        {
            {
                id     = 'clienticon',
                widget = awful.widget.clienticon,
                forced_width    = dpi(48),
                forced_height   = dpi(48),
            },
            widget = wibox.container.margin,
            margins = dpi(8),
        },
        id = "background_role",
        widget = wibox.container.background,
        shape = helpers.rrect(beautiful.border_radius),
    },
}

app_drawer = wibox.widget({
    {
        {
            widget = dock
        },
        margins = dpi(16),
        widget = wibox.container.margin,
    },
    bg = beautiful.bg,
    widget = wibox.container.background,
})

return app_drawer
