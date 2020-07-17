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
    awful.key({ superkey }, "Tab",
        function ()
            window_switcher_show(awful.screen.focused())
        end,
        {description = "activate window switcher", group = "client"}),

    -- Focus client by index (cycle through clients)
    awful.key({ superkey }, "z",
        function ()
            awful.client.focus.byidx(1) -- TODO?
        end,
        {description = "focus next by index", group = "client"}),

    awful.key({ superkey, shiftkey }, "z",
        function ()
            awful.client.focus.byidx(-1) -- TODO? (because of above)
        end,
        {description = "focus previous by index", group = "client"}),

    -- Change size of gaps {{{
    awful.key({ superkey, shiftkey }, "minus",
        function ()
            awful.tag.incgap(4, nil)
        end,
        {description = "increment gaps size for the current tag", group = "gaps"}
    ),
    awful.key({ superkey }, "minus",
        function ()
            awful.tag.incgap(-4, nil)
        end,
        {description = "decrement gap size for the current tag", group = "gaps"}
    ),
    -- }}}

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

    -- No need for these (single screen setup)
    --awful.key({ superkey, ctrlkey }, "j", function () awful.screen.focus_relative( 1) end,
    --{description = "focus the next screen", group = "screen"}),
    --awful.key({ superkey, ctrlkey }, "k", function () awful.screen.focus_relative(-1) end,
    --{description = "focus the previous screen", group = "screen"}),
    
    -- Urgent or Undo:
    -- Jump to urgent client or (if there is no such client) go back
    -- to the last tag
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

    -- increase/decrease master clients
    awful.key({ superkey, ctrlkey }, "k",   
        function () 
            awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ superkey, ctrlkey }, "j",   
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ superkey, ctrlkey }, "Up",   
        function () 
            awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ superkey, ctrlkey }, "Down",   
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of master clients", group = "layout"}),

    -- Number of columns
    awful.key({ superkey }, "\\",   
        function () 
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ superkey, shiftkey }, "\\",   
        function () 
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}),


    --awful.key({ superkey,           }, "space", function () awful.layout.inc( 1)                end,
    --{description = "select next", group = "layout"}),
    --awful.key({ superkey, shiftkey   }, "space", function () awful.layout.inc(-1)                end,
    --{description = "select previous", group = "layout"}),

    -- App shortcuts {{{
    -- Spawn terminal
    awful.key({ superkey }, "Return", function () awful.spawn(user.terminal) end,
        {description = "open a terminal", group = "apps"}),

    -- Pomodoro timer TODO: I'd like this
    awful.key({ superkey }, "slash", function() awful.spawn.with_shell("pomodoro") end,
        {description = "pomodoro", group = "apps"}),

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
    -- TODO: might be nice
    -- -- Network dialog: nmapplet rofi frontend
    -- awful.key({ superkey }, "F11", function() awful.spawn("networks-rofi") end,
    --     {description = "spawn network dialog", group = "launcher"}),

    -- Toggle wibar(s)
    -- awful.key({ superkey }, "b", function() wibars_toggle() end,
    --     {description = "show or hide wibar(s)", group = "awesome"}),
    -- Run program (d for dmenu ;)
    awful.key({ superkey }, "a",
        function()
            awful.spawn.with_shell("rofi -show drun -config ~/.config/rofi/apps_config.rasi")
        end,
        {description = "launch an app", group = "apps"}),
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
            naughty.destroy_all_notifications()
        end,
        {description = "dismiss notification", group = "notifications"}),

    -- Menubar
    --awful.key({ superkey, ctrlkey }, "b", function() menubar.show() end,
    --{description = "show the menubar", group = "launcher"}),

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

    -- Microphone (V for voice)
    -- awful.key( { superkey }, "m",
    --     function()
    --         awful.spawn.with_shell("amixer -D pulse sset Capture toggle &> /dev/null")
    --     end,
    --     {description = "(un)mute microphone", group = "volume"}),

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

    -- Media keys TODO: we have keys for these
    -- awful.key({ superkey }, "period", function() awful.spawn.with_shell("mpc -q next") end,
    --     {description = "next song", group = "media"}),
    -- awful.key({ superkey }, "comma", function() awful.spawn.with_shell("mpc -q prev") end,
    --     {description = "previous song", group = "media"}),
    -- awful.key({ superkey }, "space", function() awful.spawn.with_shell("mpc -q toggle") end,
    --     {description = "toggle pause/play", group = "media"}),
    -- awful.key({ superkey, shiftkey }, "period", function() awful.spawn.with_shell("mpvc next") end,
    --     {description = "mpv next song", group = "media"}),
    -- awful.key({ superkey, shiftkey }, "comma", function() awful.spawn.with_shell("mpvc prev") end,
    --     {description = "mpv previous song", group = "media"}),
    -- awful.key({ superkey, shiftkey}, "space", function() awful.spawn.with_shell("mpvc toggle") end,
    --     {description = "mpv toggle pause/play", group = "media"}),


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
        -- rofi_show()
    end, {description = "dashboard", group = "custom"}),

    -- App drawer
    awful.key({ superkey, shiftkey }, "a", function()
        app_drawer_show() end,
        {description = "App drawer", group = "custom"})
)

keys.clientkeys = gears.table.join(
    -- Move windows {{{
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
    -- }}}

    -- Single tap: Center client 
    -- Double tap: Center client + Floating + Resize
    -- TODO: should open calculator
    -- awful.key({ superkey }, "c", function (c)
    --     awful.placement.centered(c, {honor_workarea = true, honor_padding = true})
    --     helpers.single_double_tap(
    --         nil,
    --         function ()
    --             helpers.float_and_resize(c, screen_width * 0.65, screen_height * 0.9)
    --         end)
    -- end),

    -- Relative move client
    -- TODO: ??? helpful but...
    -- awful.key({ superkey, shiftkey, ctrlkey }, "j", function (c)
    --     c:relative_move(0,  dpi(20), 0, 0)
    -- end),
    -- awful.key({ superkey, shiftkey, ctrlkey }, "k", function (c)
    --     c:relative_move(0, dpi(-20), 0, 0)
    -- end),
    -- awful.key({ superkey, shiftkey, ctrlkey }, "h", function (c)
    --     c:relative_move(dpi(-20), 0, 0, 0)
    -- end),
    -- awful.key({ superkey, shiftkey, ctrlkey }, "l", function (c)
    --     c:relative_move(dpi( 20), 0, 0, 0)
    -- end),
    -- awful.key({ superkey, shiftkey, ctrlkey }, "Down", function (c)
    --     c:relative_move(0,  dpi(20), 0, 0)
    -- end),
    -- awful.key({ superkey, shiftkey, ctrlkey }, "Up", function (c)
    --     c:relative_move(0, dpi(-20), 0, 0)
    -- end),
    -- awful.key({ superkey, shiftkey, ctrlkey }, "Left", function (c)
    --     c:relative_move(dpi(-20), 0, 0, 0)
    -- end),
    -- awful.key({ superkey, shiftkey, ctrlkey }, "Right", function (c)
    --     c:relative_move(dpi( 20), 0, 0, 0)
    -- end),

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
        {description = "focus mode", group = "client"}),

    -- V for vertical view
    awful.key({ superkey, ctrlkey }, "v",
        function (c)
            helpers.float_and_resize(c, screen_width * 0.45, screen_height * 0.90)
        end,
        {description = "focus mode", group = "client"}),

    -- T for tiny window
    awful.key({ superkey, ctrlkey }, "t",
        function (c)
            helpers.float_and_resize(c, screen_width * 0.3, screen_height * 0.35)
        end,
        {description = "tiny mode", group = "client"}),

    -- N for normal size (good for terminals)
    awful.key({ superkey, ctrlkey  }, "n",
        function (c)
            helpers.float_and_resize(c, screen_width * 0.45, screen_height * 0.5)
        end,
        {description = "normal mode", group = "client"}),

    -- Closing windows {{{
    -- Close single
    awful.key({ superkey }, "q", function (c) c:kill() end,
        {description = "close", group = "client"}),

    -- Close all in tag
    awful.key({ superkey, altkey }, "q",
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

    -- On top
    awful.key({ superkey, ctrlkey }, "x", function (c) c.ontop = not c.ontop end,
        {description = "toggle keep on top", group = "client"}),
    -- Sticky
    awful.key({ superkey }, "x", function (c) c.sticky = not c.sticky end,
        {description = "toggle sticky", group = "client"}),

    -- Minimizing/maximizing {{{
    -- Minimize
    awful.key({ superkey }, "v",
        function (c)
            c.minimized = true
        end,
        {description = "minimize", group = "client"}),
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
            {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ superkey, ctrlkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),

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
            {description = "move focused client to tag #"..i, group = "tag"}),

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
            {description = "move all visible clients to tag #"..i, group = "tag"}),

        -- Toggle tag on focused client.
        awful.key({ superkey, ctrlkey, shiftkey }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"})
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

-- TODO: pending keybinds
-- Super+Control+Mod1+p exec systemctl poweroff
-- Super+Control+Mod1+r exec systemctl reboot
-- Super+Control+Mod1+s exec systemctl suspend
-- Super+Control+Mod1+b exec systemctl hibernate
-- 
-- # Media player controls
-- XF86AudioPlay exec mpc toggle || playerctl play-pause
-- XF86AudioNext exec mpc next || playerctl next
-- XF86AudioPrev exec mpc cdprev || playerctl previous
-- 
-- # start rofi
-- Super+Control+e exec rofi -show emoji -modi emoji
-- Super+Control+w exec rofi -show window
-- Super+c exec rofi -show calc -no-sort
-- 
-- # move focused workspace to outputs
-- Super+Control+h move workspace to left
-- Super+Control+j move workspace to down
-- Super+Control+k move workspace to up
-- Super+Control+l move workspace to right
-- 
-- # (arrow keys for moving workspace)
-- Super+Control+Left move workspace to left
-- Super+Control+Down move workspace to down
-- Super+Control+Up move workspace to up
-- Super+Control+Right move workspace to right
-- 
-- # focus outputs
-- Super+Mod1+h focus output left
-- Super+Mod1+j focus output down
-- Super+Mod1+k focus output up
-- Super+Mod1+l focus output right
-- 
-- # (arrow keys for workspace)
-- Super+Mod1+Left focus output left
-- Super+Mod1+Down focus output down
-- Super+Mod1+Up focus output up
-- Super+Mod1+Right focus output right
-- 
-- # floating video mode
-- Super+i fullscreen disable; floating enable; sticky enable; border pixel 4; resize set 356 200; move position 1548 px 16 px; inhibit_idle open
-- Super+Shift+i fullscreen disable; floating enable; sticky enable; border pixel 4; resize set 711 400; move position 1193 px 16 px; inhibit_idle open
-- 
-- # change container layout (stacked, tabbed, toggle split)
-- Super+t layout tabbed
-- Super+y layout toggle split
-- Super+u layout stacking
-- 
-- # app shortcuts
-- Super+m exec $HOME/.config/sway/gaming_mode.sh
-- 
-- # video capture
-- Super+Shift+Print exec sh $HOME/.config/sway/videocapture.sh
-- 
-- # mako notifications
-- Super+Space exec makoctl invoke
-- 
-- # start mivy
-- Super+d exec mivy
