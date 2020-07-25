local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")
local apps = require("apps")
local decorations = require("decorations")

local helpers = require("helpers")

local keys = {}
local hotkeys_popup = require("awful.hotkeys_popup")

-- Mod keys
superkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"
shiftkey = "Shift"

local function enable_floating_video(c, height)
    decorations.hide(c)
    c.floating = true
    c.width = height * 16 / 9
    c.height = height
    c.sticky = true
    c.ontop = true
    awful.placement.top_right(c, { honor_workarea = true, margins = 32 })

    local disable_floating_video = function()
        if not c.floating then
            decorations.show(c)
            c.sticky = false
            c.ontop = false
        end
    end

    c:connect_signal("property::floating", disable_floating_video)
end

-- {{{ Mouse bindings on desktop
keys.desktopbuttons = gears.table.join(
    awful.button({ }, 1, function ()
        -- Single tap
        awesome.emit_signal("elemental::dismiss")
        naughty.destroy_all_notifications()
        if mymainmenu then
            mymainmenu:hide()
        end
        if sidebar_hide then
            sidebar_hide()
        end
        -- Double tap
        local function double_tap()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then
                awful.tag.history.restore()
            else
                awful.client.urgent.jumpto()
            end
        end
        helpers.single_double_tap(function() end, double_tap)
    end),

    -- Right click - Show app drawer
    -- awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 3, function ()
        if app_drawer_show then
            app_drawer_show()
        end
    end),

    -- Middle button - Toggle dashboard
    awful.button({ }, 2, function ()
        if dashboard_show then
            dashboard_show()
        end
    end),

    -- Scrolling - Switch tags
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),

    -- Side buttons - Control volume
    awful.button({ }, 9, function () helpers.volume_up() end),
    awful.button({ }, 8, function () helpers.volume_down() end)

    -- Side buttons - Minimize and restore minimized client
    -- awful.button({ }, 8, function()
    --     if client.focus ~= nil then
    --         client.focus.minimized = true
    --     end
    -- end),
    -- awful.button({ }, 9, function()
    --       local c = awful.client.restore()
    --       -- Focus restored client
    --       if c then
    --           client.focus = c
    --       end
    -- end)
)
-- }}}

-- {{{ Key bindings
keys.globalkeys = gears.table.join(
    -- key help
    awful.key({ superkey }, "F1", hotkeys_popup.show_help,
          {description = "show help", group = "awesome"}),
    
    -- focus next screen
    awful.key({ superkey }, "Tab",
        function()
            awful.screen.focus_relative(1)
        end,
        {description = "focus next screen", group = "screen"}),

    -- Focus client by direction (hjkl keys) {{{
    awful.key({ superkey }, "j",
        function()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus down", group = "client"}),
    awful.key({ superkey }, "k",
        function()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus up", group = "client"}),
    awful.key({ superkey }, "h",
        function()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus left", group = "client"}),
    awful.key({ superkey }, "l",
        function()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus right", group = "client"}),
    awful.key({ superkey }, "Down",
        function()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus down", group = "client"}),
    awful.key({ superkey }, "Up",
        function()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus up", group = "client"}),
    awful.key({ superkey }, "Left",
        function()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus left", group = "client"}),
    awful.key({ superkey }, "Right",
        function()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus right", group = "client"}),
    -- }}}

    -- Window switcher
    awful.key({ altkey }, "Tab",
        function ()
            window_switcher_show(awful.screen.focused())
        end,
        {description = "activate window switcher", group = "client"}),

    -- Restore a minimized window
    awful.key({ superkey, shiftkey }, "v",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
            end
        end,
        {description = "restore minimized", group = "client"}),

    -- Jump to urgent client or go back to the last tag
    awful.key({ superkey }, "u",
        function ()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then
                awful.tag.history.restore()
            else
                awful.client.urgent.jumpto()
            end
        end,
        {description = "jump to urgent client", group = "client"}),

    -- Reload Awesome
    awful.key({ superkey, shiftkey }, "r", awesome.restart,
        {description = "reload", group = "awesome"}),

    -- Quit Awesome
    -- Logout, Shutdown, Restart, Suspend, Lock
    awful.key({ superkey, ctrlkey }, "q",
        function ()
            exit_screen_show()
        end,
        {description = "quit awesome", group = "awesome"}),

    -- Lock
    awful.key({ superkey }, "Escape",
        function ()
            awful.spawn.with_shell(os.getenv("HOME").."/.config/i3/lock.sh")
        end,
        {description = "lock", group = "awesome"}),

    -- Layout options {{{
    -- increase/decrease master clients (mnemonic by direction)
    awful.key({ superkey, ctrlkey }, "j",   
        function () 
            awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ superkey, ctrlkey }, "k",   
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ superkey, ctrlkey }, "Down",   
        function () 
            awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ superkey, ctrlkey }, "Up",   
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of master clients", group = "layout"}),
    -- Number of columns
    awful.key({ superkey, ctrlkey }, "l",   
        function () 
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ superkey, ctrlkey }, "h",   
        function () 
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}),
    awful.key({ superkey, ctrlkey }, "Left",   
        function () 
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ superkey, ctrlkey }, "Right",   
        function () 
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}),
    --}}}

    -- App shortcuts {{{
    -- Spawn terminal
    awful.key({ superkey }, "Return", function () awful.spawn(user.terminal) end,
        {description = "open a terminal", group = "apps"}),

    -- Pomodoro timer TODO: I'd like this
    -- awful.key({ superkey }, "slash", function() awful.spawn.with_shell("pomodoro") end,
    --     {description = "pomodoro", group = "apps"}),

    -- Spawn file manager
    awful.key({ superkey }, "e", apps.file_manager,
        {description = "file manager", group = "apps"}),

    -- Spawn music client
    awful.key({ superkey }, "b", apps.music,
        {description = "music client", group = "apps"}),

    -- Quick note
    awful.key({ superkey, ctrlkey }, "n", apps.quick_note,
        {description = "quick note", group = "apps"}),

    -- Browser
    awful.key({ superkey }, "w", apps.browser,
        {description = "browser", group = "apps"}),

    -- Editor
    awful.key({ superkey }, "n", apps.editor,
        {description = "editor", group = "apps"}),

    -- htop
    awful.key({ superkey }, "p", apps.process_monitor,
        {description = "process monitor", group = "apps"}),

    -- ponies
    awful.key({ superkey, shiftkey }, "p", apps.ponies,
        {description = "ponies", group = "apps"}),

    -- redshift toggle
    awful.key({ superkey, ctrlkey }, "r", apps.toggle_redshift,
        {description = "toggle redshift", group = "apps"}),

    -- launch shell authenticator
    awful.key({ superkey }, "g", apps.authenticator,
        {description = "authenticator", group = "apps"}),

    -- launch qalc in terminal
    awful.key({ superkey }, "c", apps.calculator,
        {description = "calculator", group = "apps"}),

    -- pauvcontrol
    awful.key({ superkey, ctrlkey }, "p", apps.pavucontrol,
        {description = "volume control", group = "apps"}),

    -- notebook
    awful.key({ superkey, shiftkey }, "n", apps.notebook,
        {description = "open notebook", group = "apps"}),

    -- bored
    awful.key({ superkey, shiftkey }, "b", apps.bored,
        {description = "boredom remedies", group = "apps"}),
    -- }}}

    -- Rofi shortcuts {{{
    awful.key({ superkey }, "a",
        function()
            awful.spawn.with_shell("rofi -show drun -config ~/.config/rofi/apps_config.rasi")
        end,
        {description = "launch an app", group = "apps"}),
    awful.key({ superkey, ctrlkey }, "e", 
        function() 
            awful.spawn.with_shell("rofi -show emoji -modi emoji")
        end, 
        {description = "open emoji menu", group = "apps"}),
    -- }}}

    -- Sidebar {{{
    -- Toggle sidebar
    awful.key({ superkey }, "grave", function() sidebar_toggle() end,
        {description = "show or hide sidebar", group = "awesome"}),

    -- Run
    awful.key({ superkey }, "r",
        function ()
            -- Not all sidebars have a prompt
            if sidebar_activate_prompt then
                sidebar_activate_prompt("run")
            end
        end,
        {description = "activate sidebar run prompt", group = "awesome"}),
    -- Web search
    awful.key({ superkey, shiftkey }, "w",
        function ()
            -- Not all sidebars have a prompt
            if sidebar_activate_prompt then
                sidebar_activate_prompt("web_search")
            end
        end,
        {description = "activate sidebar web search prompt", group = "awesome"}),
    -- }}}

    -- Dismiss notifications and elements that connect to the dismiss signal
    awful.key( { ctrlkey }, "Escape",
        function()
            awesome.emit_signal("elemental::dismiss")
            naughty.destroy(naughty.getById(0)) -- XXX ??? Not sure if this will work
        end,
        {description = "dismiss notification", group = "notifications"}),

    -- Menubar
    awful.key({ superkey, ctrlkey }, "b", function() menubar.show() end,
        {description = "show the menubar", group = "launcher"}),

    -- Brightness {{{
    awful.key( { }, "XF86MonBrightnessDown",
        function()
            awful.spawn("light -U 5", false)
        end,
        {description = "decrease brightness", group = "brightness"}),
    awful.key( { }, "XF86MonBrightnessUp",
        function()
            awful.spawn("light -A 5", false)
        end,
        {description = "increase brightness", group = "brightness"}),
    -- }}}

    -- Volume {{{
    awful.key( { }, "XF86AudioMute",
        function()
            helpers.volume_mute_toggle()
        end,
        {description = "toggle mute", group = "volume"}),
    awful.key( { }, "XF86AudioLowerVolume",
        function()
            helpers.volume_down()
        end,
        {description = "lower volume", group = "volume"}),
    awful.key( { }, "XF86AudioRaiseVolume",
        function()
            helpers.volume_up()
        end,
        {description = "raise volume", group = "volume"}),
    -- }}}

    -- Screenshots {{{
    awful.key( { superkey }, "Print", function() apps.screenshot("full") end,
        {description = "take screenshot", group = "screenshots"}),
    awful.key( { superkey, altkey }, "Print", function() apps.screenshot("full-copy") end,
        {description = "copy full screenshot to clipboard", group = "screenshots"}),
    awful.key( { superkey, ctrlkey }, "Print", function() apps.screenshot("selection") end,
        {description = "take area screenshot", group = "screenshots"}),
    awful.key( { superkey, ctrlkey, altkey }, "Print", function() apps.screenshot("clipboard") end,
        {description = "copy area to clipboard", group = "screenshots"}),
    awful.key( { ctrlkey, altkey }, "Print", function() apps.screenshot("browse") end,
        {description = "browse screenshots", group = "screenshots"}),
    awful.key( { ctrlkey }, "Print", function() apps.screenshot("gimp") end,
        {description = "edit most recent screenshot with gimp", group = "screenshots"}),
    -- }}}

    -- Media keys
    awful.key({ }, "XF86AudioPlay", function() awful.spawn.with_shell("playerctl play-pause || mpc toggle") end,
        {description = "pause/play", group = "media"}),
    awful.key({ }, "XF86AudioNext", function() awful.spawn.with_shell("playerctl next || mpc next") end,
        {description = "next song", group = "media"}),
    awful.key({ }, "XF86AudioPrev", function() awful.spawn.with_shell("playerctl previous || mpc cdprev") end,
        {description = "previous song", group = "media"}),


    -- Layouts {{{
    -- Max layout
    -- Single tap: Set max layout
    -- Double tap: Also disable floating for ALL visible clients in the tag
    awful.key({ superkey }, "t",
        function()
            awful.layout.set(awful.layout.suit.max)
            helpers.single_double_tap(
                nil,
                function()
                    local clients = awful.screen.focused().clients
                    for _, c in pairs(clients) do
                        c.floating = false
                    end
                end)
        end,
        {description = "set max layout", group = "tag"}),

    -- Tiling
    -- Single tap: Set tiled layout
    -- Double tap: Also disable floating for ALL visible clients in the tag
    awful.key({ superkey }, "y",
        function()
            awful.layout.set(awful.layout.suit.tile)
            helpers.single_double_tap(
                nil,
                function()
                    local clients = awful.screen.focused().clients
                    for _, c in pairs(clients) do
                        c.floating = false
                    end
                end)
        end,
        {description = "set tiled layout", group = "tag"}),
    -- }}}

    -- Dashboard
    awful.key({ superkey }, "d", function()
        if dashboard_show then
            dashboard_show()
        end
    end, {description = "dashboard", group = "custom"}),

    -- App drawer
    awful.key({ superkey, shiftkey }, "a", function()
        app_drawer_show() end,
        {description = "App drawer", group = "custom"})
)

keys.clientkeys = gears.table.join(
    -- Resize windows {{{
    awful.key({ superkey, altkey }, "Down", function (c)
        helpers.resize_dwim(client.focus, "down")
    end),
    awful.key({ superkey, altkey }, "Up", function (c)
        helpers.resize_dwim(client.focus, "up")
    end),
    awful.key({ superkey, altkey }, "Left", function (c)
        helpers.resize_dwim(client.focus, "left")
    end),
    awful.key({ superkey, altkey }, "Right", function (c)
        helpers.resize_dwim(client.focus, "right")
    end),
    awful.key({ superkey, altkey }, "j", function (c)
        helpers.resize_dwim(client.focus, "down")
    end),
    awful.key({ superkey, altkey }, "k", function (c)
        helpers.resize_dwim(client.focus, "up")
    end),
    awful.key({ superkey, altkey }, "h", function (c)
        helpers.resize_dwim(client.focus, "left")
    end),
    awful.key({ superkey, altkey }, "l", function (c)
        helpers.resize_dwim(client.focus, "right")
    end),
    -- }}}

    -- Move windows {{{
    -- by direction
    awful.key({ superkey, shiftkey }, "Down", function (c)
        helpers.move_client_dwim(c, "down")
    end),
    awful.key({ superkey, shiftkey }, "Up", function (c)
        helpers.move_client_dwim(c, "up")
    end),
    awful.key({ superkey, shiftkey }, "Left", function (c)
        helpers.move_client_dwim(c, "left")
    end),
    awful.key({ superkey, shiftkey }, "Right", function (c)
        helpers.move_client_dwim(c, "right")
    end),
    awful.key({ superkey, shiftkey }, "j", function (c)
        helpers.move_client_dwim(c, "down")
    end),
    awful.key({ superkey, shiftkey }, "k", function (c)
        helpers.move_client_dwim(c, "up")
    end),
    awful.key({ superkey, shiftkey }, "h", function (c)
        helpers.move_client_dwim(c, "left")
    end),
    awful.key({ superkey, shiftkey }, "l", function (c)
        helpers.move_client_dwim(c, "right")
    end),

    -- to next screen
    awful.key({ superkey, shiftkey }, "Tab",
        function (c)
            c:move_to_screen()
        end,
        {description = "move client to next screen", group = "client"}),
    -- }}}

    -- Views {{{
    -- Toggle fullscreen
    awful.key({ superkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    -- F for focused view
    awful.key({ superkey, ctrlkey }, "f",
        function (c)
            helpers.float_and_resize(c, screen_width * 0.7, screen_height * 0.75)
        end,
        {description = "focus view", group = "client"}),

    -- V for vertical view
    awful.key({ superkey, ctrlkey }, "v",
        function (c)
            helpers.float_and_resize(c, screen_width * 0.45, screen_height * 0.90)
        end,
        {description = "vertical view", group = "client"}),

    -- T for tiny window
    awful.key({ superkey, ctrlkey }, "t",
        function (c)
            helpers.float_and_resize(c, screen_width * 0.3, screen_height * 0.35)
        end,
        {description = "tiny view", group = "client"}),

    -- N for normal size (good for terminals)
    awful.key({ superkey, ctrlkey }, "n",
        function (c)
            helpers.float_and_resize(c, screen_width * 0.45, screen_height * 0.5)
        end,
        {description = "normal view", group = "client"}),

    -- Floating video
    awful.key({ superkey }, "i", function (c)
        enable_floating_video(c, 200)
    end, {description = "floating video view", group = "media"}),

    -- Big floating video
    awful.key({ superkey, shiftkey }, "i", function (c)
        enable_floating_video(c, 400)
    end, {description = "big floating video view", group = "media"}),
    -- }}}

    -- Closing windows {{{
    -- Close single
    awful.key({ superkey }, "q", function (c) c:kill() end,
        {description = "close", group = "client"}),

    -- Close all in tag
    awful.key({ superkey, shiftkey }, "q",
        function ()
            local clients = awful.screen.focused().clients
            for _, c in pairs(clients) do
                c:kill()
            end
        end,
        {description = "kill all visible clients for the current tag", group = "client"}
    ),
    -- }}}

    -- Toggle floating
    awful.key({ superkey }, "s",
        function(c)
            local layout_is_floating = (awful.layout.get(mouse.screen) == awful.layout.suit.floating)
            if not layout_is_floating then
                awful.client.floating.toggle()
            end
        end,
        {description = "toggle floating", group = "client"}),

    -- Set master
    awful.key({ superkey, ctrlkey }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),

    -- On top/sticky {{{
    -- On top
    awful.key({ superkey, ctrlkey }, "x", function (c) c.ontop = not c.ontop end,
        {description = "toggle keep on top", group = "client"}),
    -- Sticky
    awful.key({ superkey }, "x", function (c) c.sticky = not c.sticky end,
        {description = "toggle sticky", group = "client"}),
    -- }}}

    -- Minimizing/maximizing {{{
    -- Minimize
    awful.key({ superkey }, "v",
        function (c)
            c.minimized = true
        end,
        {description = "minimize", group = "client"}),
    -- Maximize
    awful.key({ superkey, shiftkey }, "m",
        function (c)
            c.maximized = not c.maximized
        end,
        {description = "(un)maximize", group = "client"})
    -- }}}
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local ntags = 10
for i = 1, ntags do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ superkey }, "#" .. i + 9,
            function ()
                -- Tag back and forth
                helpers.tag_back_and_forth(i)

                -- Simple tag view
                -- local tag = mouse.screen.tags[i]
                -- if tag then
                -- tag:view_only()
                -- end
            end,
            {description = "view tag", group = "tag"}),
        -- Toggle tag display.
        awful.key({ superkey, ctrlkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag", group = "tag"}),

        -- Move client to tag.
        awful.key({ superkey, shiftkey }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag", group = "tag"}),

        -- Move all visible clients to tag and focus that tag
        awful.key({ superkey, altkey }, "#" .. i + 9,
            function ()
                local tag = client.focus.screen.tags[i]
                local clients = awful.screen.focused().clients
                if tag then
                    for _, c in pairs(clients) do
                        c:move_to_tag(tag)
                    end
                    tag:view_only()
                end
            end,
            {description = "move all visible clients to tag", group = "tag"})
    )
end

-- Mouse buttons on the client (whole window, not just titlebar)
keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c end),
    awful.button({ superkey }, 1, awful.mouse.client.move),
    -- awful.button({ superkey }, 2, function (c) c:kill() end),
    awful.button({ superkey }, 3, function(c)
        client.focus = c
        awful.mouse.client.resize(c)
        -- awful.mouse.resize(c, nil, {jump_to_corner=true})
    end),
    awful.button({ superkey, altkey }, 1, function(c)
        client.focus = c
        awful.mouse.client.resize(c)
        -- awful.mouse.resize(c, nil, {jump_to_corner=true})
    end)
)

-- Mouse buttons on the tasklist
-- Use 'Any' modifier so that the same buttons can be used in the floating
-- tasklist displayed by the window switcher while the modkey is pressed
keys.tasklist_buttons = gears.table.join(
    awful.button({ 'Any' }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
            end
    end),
    -- Middle mouse button closes the window (on release)
    awful.button({ 'Any' }, 2, nil, function (c) c:kill() end),
    awful.button({ 'Any' }, 3, function (c) c.minimized = true end),
    awful.button({ 'Any' }, 4, function ()
        awful.client.focus.byidx(-1)
    end),
    awful.button({ 'Any' }, 5, function ()
        awful.client.focus.byidx(1)
    end),

    -- Side button up - toggle floating
    awful.button({ 'Any' }, 9, function(c)
        c.floating = not c.floating
    end),
    -- Side button down - toggle ontop
    awful.button({ 'Any' }, 8, function(c)
        c.ontop = not c.ontop
    end)
)

-- Mouse buttons on a tag of the taglist widget
keys.taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t)
        -- t:view_only()
        helpers.tag_back_and_forth(t.index)
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    -- awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ }, 3, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)


-- Mouse buttons on the primary titlebar of the window
keys.titlebar_buttons = gears.table.join(
    -- Left button - move
    awful.button({ }, 1, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        awful.mouse.client.move(c)
    end),
    -- Middle button - close
    awful.button({ }, 2, function ()
        local c = mouse.object_under_pointer()
        c:kill()
    end),
    -- Right button - resize
    awful.button({ }, 3, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        awful.mouse.client.resize(c)
        -- awful.mouse.resize(c, nil, {jump_to_corner=true})
    end),
    -- Side button up - toggle floating
    awful.button({ }, 9, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        --awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        c.floating = not c.floating
    end),
    -- Side button down - toggle ontop
    awful.button({ }, 8, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        c.ontop = not c.ontop
        -- Double Tap - toggle sticky
        -- local function single_tap()
        --   c.ontop = not c.ontop
        -- end
        -- local function double_tap()
        --   c.sticky = not c.sticky
        -- end
        -- helpers.single_double_tap(single_tap, double_tap)
    end)
)

-- }}}

-- Set root (desktop) keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
