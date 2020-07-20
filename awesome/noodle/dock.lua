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

-- TODO: These variables (and more) should ideally be retrieved through `beautiful`
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

-- >> Grouping happens based on the `class` property of each client
-------------------------------------------------------------------
-- The `dock_class_count` table is used in order to track how many clients of
-- each class exist at the moment
local dock_class_count = {}
-- The `dock_items` table is used in order to store the dock item widget that
-- corresponds to each class
local dock_items = {}
-- The `dock_recently_focused` table stores the most recently focused client
-- for each class. It is used to select the most relevant client when clicking
-- a dock icon.
local dock_recently_focused = {}

-- >> Helper functions
local function class_window_exists(class)
    return dock_class_count[class] and dock_class_count[class] > 0
end

local function class_window_focused(class)
    return client.focus and client.focus.class == class
end

-- Cycle windows of the same class
local function cycle_by_class(class, forward)
    local clients = helpers.find_clients({ class = class })
    local num_clients = #clients
    if num_clients == 0 then
        -- Nothing to do
        return
    elseif num_clients == 1 then
        clients[1]:jump_to()
    else
        -- Focus is always ends up on index 1.
        -- Depending on direction, just focus the client before or after it.
        clients[forward and 2 or num_clients]:jump_to()
    end
end

-- This function tries to get the most relevant client of this class using
-- the following steps in this order:
-- 1. If there is only one client of this class, return it
-- 2. Get an urgent client of this class (if it exists)
-- 3. Get the most recently used client of this class
-- 4. Get the first client of this class
local function find_relevant_client(class)
    -- No need to move on if there is only one client
    if dock_class_count[class] == 1 then
        return helpers.find_clients({ class = class }, true)
    end

    -- Search for urgent client
    local urgent_client = helpers.find_clients({ class = class, urgent = true }, true)
    if urgent_client then
        return urgent_client
    end

    -- Get recently focused client
    if dock_recently_focused[class] and dock_recently_focused[class].valid then
        return dock_recently_focused[class]
    end

    -- Get first found client
    return helpers.find_clients({ class = class }, true)
end

-- Function that creates a dock icon and attaches buttons to it.
local function generate_dock_icon(c, bg, fg, symbol)
    local icon = wibox.widget({
        forced_height = item_size,
        forced_width = item_size,
        widget = awful.widget.clienticon(c)
    })

    local indicator_focused = cairo.ImageSurface.create(cairo.Format.ARGB32, item_size, indicator_height)
    local indicator_unfocused = cairo.ImageSurface.create(cairo.Format.ARGB32, item_size, indicator_height)

    local cr
    cr = cairo.Context(indicator_unfocused)
    cr:set_source(gears.color(fg))
    draw_indicator_shape_unfocused(cr)

    -- Put everything together
    local w = wibox.widget({
        {
            icon,
            {
                {
                    id = "indicator_unfocused",
                    bgimage = indicator_unfocused,
                    widget = wibox.container.background
                },
                {
                    id = "indicator_focused",
                    bg = fg,
                    shape = helpers.rect,
                    visible = false,
                    widget = wibox.container.background
                },
                forced_height = indicator_height,
                forced_width = item_size - item_margin * 2,
                id = "indicator",
                visible = not c.ghost,
                layout = wibox.layout.stack
            },
            spacing = dpi(8),
            layout = wibox.layout.fixed.vertical
        },
        left = item_margin,
        right = item_margin,
        widget = wibox.container.margin
    })

    -- Store class here because c will become nil whenever it closes
    local class = c.class

    -- Set mousebinds
    w:buttons(gears.table.join(
        -- Left click: Focus 'relevant' client of class, minimize if already
        -- focused
        awful.button({ }, 1, function ()
            if class_window_focused(class) then
                client.focus.minimized = true
            else
                find_relevant_client(class):jump_to()
            end
        end),

        -- Super + Left click: Move client to current tag
        awful.button({ superkey }, 1, function ()
            local found = find_relevant_client(class)
            if found then
                found:move_to_tag(mouse.screen.selected_tag)
                found.minimized = false
                found:activate()
            end
        end),

        -- Middle click: Kill client of class
        -- If a window with this class is already focused, then kill the
        -- focused window, else kill a 'relevant' client of this class
        awful.button({ }, 2, function ()
            if class_window_exists(class) then
                if class_window_focused(class) then
                    client.focus:kill()
                else
                    find_relevant_client(class):kill()
                end
            end
        end),

        -- Super + middle click: Kill ALL clients that match this class
        awful.button({ superkey }, 2, function ()
            helpers.find_clients_and_do({ class = class }, function (ci)
                ci:kill()
            end)
        end),

        -- Right click: Spawn rofi menu that allows picking between all windows
        -- of this class
        awful.button({ }, 3, function ()
            local clients = helpers.find_clients({ class = class })
            -- Stop if no such client was found
            if #clients == 0 then return end

            -- Create icon prefix
            local i = {
                color = colors.foreground,
                symbol = ""
            }
            local prefix = "<span font_family='Material Design Icons' foreground='"..i.color.."'>"..i.symbol.."</span>"

            -- Generate input for rofi
            -- Each line corresponds to 1 client
            local rofi_input = ""
            for i = 1, #clients do
                if clients[i].name then
                    rofi_input = rofi_input..prefix..'  '..clients[i].name..'\n'
                end
            end

            -- Nothing to do
            if rofi_input == "" then return end

            -- Remove last \n
            rofi_input = rofi_input:sub(1, #rofi_input - 1)

            -- Pass lines to rofi and get user choice
            awful.spawn.easy_async_with_shell('echo "'..rofi_input..'" | rofi -format d -markup-rows -i -matching fuzzy -dmenu -p "Which window?"', function(out, _, __, exit_code)
                -- If user did not cancel rofi
                if exit_code == 0 then
                    -- Jump to chosen client
                    clients[tonumber(out)]:jump_to()
                end
            end)
        end),

        -- Scrolling: cycle through classes
        awful.button({ }, 4, function ()
            cycle_by_class(class, false)
        end),
        awful.button({ }, 5, function ()
            cycle_by_class(class, true)
        end)
    ))

    return w
end

-- Dock items will be inserted into this layout
local dock = wibox.widget({
    layout = wibox.layout.fixed.horizontal
})

-- >> Helper functions used by signals
local add_client
local remove_client
add_client = function(c)
    if not c.class then return end -- Some windows have no class (rare)

    -- Increment class count
    dock_class_count[c.class] = (dock_class_count[c.class] or 0) + 1

    -- Check if we need to create a new item
    if dock_class_count[c.class] == 1 then
        local i = {
            color = colors.foreground,
            symbol = ""
        }

        -- Create a new item if it has not been created yet
        dock_items[c.class] = generate_dock_icon(c, item_bg, i.color, i.symbol)
        dock:add(dock_items[c.class])
    end

    local old_class = c.class
    -- Handle clients which change their own class
    local handle_class_change
    handle_class_change = function(c)
        c:disconnect_signal("property::class", handle_class_change)
        remove_client({ class = old_class })
        add_client(c)
    end
    c:connect_signal("property::class", handle_class_change)
end

remove_client = function(c)
    if not c.class then return end -- Some clients have no class (rare)
    
    if not dock_class_count[c.class] then
        dock_class_count[c.class] = 0
    else
        -- Decrement class count
        dock_class_count[c.class] = dock_class_count[c.class] - 1
    end

    -- Check if we need to hide the item from the dock
    if dock_class_count[c.class] == 0 then
        -- Remove item
        dock:remove_widgets(dock_items[c.class])
        dock_items[c.class] = nil
    end
end

local function update_focus(c)
    if not c.class then return end -- Some windows have no class (rare)

    local item = dock_items[c.class]
    if not item then return end
    local indicator_focused = item:get_children_by_id("indicator_focused")[1]
    local indicator_unfocused = item:get_children_by_id("indicator_unfocused")[1]
    if client.focus and client.focus == c then
        indicator_unfocused.visible = false
        indicator_focused.visible = true
    else
        indicator_unfocused.visible = true
        indicator_focused.visible = false

        -- Update the reference to the most recently used window of this class
        dock_recently_focused[c.class] = c
    end
end

-- Signals used to update the dock
client.connect_signal("manage", add_client)
client.connect_signal("unmanage", remove_client)
client.connect_signal("property::hidden", function(c)
    if c.hidden then
        remove_client(c)
    else
        add_client(c)
    end
end)
client.connect_signal("focus", update_focus)
client.connect_signal("unfocus", update_focus)

return dock
