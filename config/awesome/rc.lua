-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- Standard awesome library
local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
-- Widget and layout library
local wibox = require('wibox')
-- Theme handling library
local beautiful = require('beautiful')
-- Notification library
local naughty = require('naughty')
local menubar = require('menubar')
local hotkeys_popup = require('awful.hotkeys_popup')
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require('awful.hotkeys_popup.keys')

local battery_widget = require('awesome-wm-widgets.battery-widget.battery')
local net_widgets = require('net_widgets')
local micmuted_widget = require('micmuted_widget')

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = 'Oops, there were errors during startup!',
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal('debug::error', function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = 'Oops, an error happened!',
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')
beautiful.wallpaper = awful.util.get_configuration_dir() .. 'trip.jpg'

-- This is used later as the default terminal and editor to run.
terminal = '/usr/bin/alacritty'
editor = os.getenv('EDITOR') or 'vim'
editor_cmd = terminal .. ' -e ' .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = 'Mod4'

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { 'hotkeys',     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { 'manual',      terminal .. ' -e man awesome' },
    { 'edit config', editor_cmd .. ' ' .. awesome.conffile },
    { 'restart',     awesome.restart },
    { 'quit',        function() awesome.quit() end },
}

mymainmenu = awful.menu({
    items = { { 'awesome', myawesomemenu, beautiful.awesome_icon },
        { 'open terminal', terminal }
    }
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Return the micmuted widget
micmuted = micmuted_widget.worker()

-- {{{ Wibar
-- Create a textclock widget,
localtextclock = wibox.widget.textclock()
utctextclock = wibox.widget.textclock('(UTC %H:%M)', 60, 'UTC')

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                'request::activate',
                'tasklist',
                { raise = true }
            )
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == 'function' then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal('property::geometry', set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = 'top', screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
            micmuted,
            battery_widget({ show_current_level = true, notification = true }),
            net_widgets.wireless({ interface = 'wlp4s0' }),
            wibox.widget.systray(),
            localtextclock,
            utctextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

local function mute()
    awful.util.spawn('amixer set Capture toggle')
    micmuted_widget.update_mute()
end

local function move_clients_to_mouse()
    for i, c in ipairs(client.get()) do
        if c.class == nil then
            goto continue
        end
        -- naughty.notify({ title=tostring(c) })
        local classes = {
            'urxvt',
            'alacritty',
            'slack',
            'firefox',
            'qutebrowser'
        }
        local ignore_firefox_apps = {
            'open.spotify.com'
        }
        for i, class in ipairs(classes) do
            if class == string.lower(c.class) and class == 'firefox' then
                for i, app in ipairs(ignore_firefox_apps) do
                    if not (app == string.lower(c.name)) then
                        awful.client.movetoscreen(c, mouse.screen)
                    end
                end
            else
                if class == string.lower(c.class) then
                    awful.client.movetoscreen(c, mouse.screen)
                end
            end
        end
        if string.lower(c.class) == 'alacritty' then
            awful.client.setmaster(c)
        end
        if string.lower(c.class) == 'urxvt' then
            awful.client.setmaster(c)
        end
        ::continue::
    end
end

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, }, 's', hotkeys_popup.show_help,
        { description = 'show help', group = 'awesome' }),
    awful.key({ modkey, }, 'Left', awful.tag.viewprev,
        { description = 'view previous', group = 'tag' }),
    awful.key({ modkey, }, 'Right', awful.tag.viewnext,
        { description = 'view next', group = 'tag' }),
    awful.key({ modkey, }, 'Escape', awful.tag.history.restore,
        { description = 'go back', group = 'tag' }),
    -- awful.key({}, 'XF86Display', function() awful.util.spawn('autorandr -c') end),
    awful.key({}, 'XF86AudioPrev', function() awful.util.spawn('playerctl previous') end),
    awful.key({}, 'XF86AudioPlay', function() awful.util.spawn('playerctl play-pause') end),
    awful.key({}, 'XF86AudioNext', function() awful.util.spawn('playerctl next') end),
    awful.key({}, 'XF86AudioMute', function() awful.util.spawn('pamixer -t') end),
    awful.key({}, 'XF86AudioLowerVolume', function() awful.util.spawn('pamixer -d 5') end),
    awful.key({}, 'XF86AudioRaiseVolume', function() awful.util.spawn('pamixer -u -i 5') end),
    awful.key({}, 'XF86AudioMicMute', mute),
    awful.key({}, 'XF86LaunchA', move_clients_to_mouse, { description = 'F3 shuffle clients', group = 'shortcuts' }),
    -- fn+F4 on Keychron
    awful.key({}, '#248', function() awful.util.spawn('autorandr docked') end,
        { description = 'F4 autorandr docked', group = 'shortcuts' }),
    awful.key({}, 'XF86MonBrightnessUp', function() awful.util.spawn('xbacklight -inc 5') end),
    --awful.key({}, 'XF86MonBrightnessDown', function() awful.util.spawn('xbacklight -dec 5') end),
    -- fn+F5 does not always map to XF86 key properly
    awful.key({}, '#232', function() awful.util.spawn('xbacklight -dec 5') end),
    awful.key({}, 'Insert', function() awful.util.spawn('slock') end,
        { description = 'slock', group = 'shortcuts' }), -- insert key

    -- fn+F3 on Apple Keyboard
    -- awful.key({}, 'XF86LaunchA', function() awful.util.spawn('setxkbmap -layout us -variant altgr-intl') end),
    -- fn+F4 on Apple Keyboard
    -- awful.key({}, 'XF86LaunchB', mute),
    -- awful.key({}, '#169', function() awful.util.spawn('slock') end,
    --     { description = 'slock', group = 'shortcuts' }), -- eject key
    -- awful.key({}, '#191', function() awful.util.spawn(terminal) end,
    --     { description = 'F13 terminal', group = 'shortcuts' }),
    -- awful.key({}, '#192', function() awful.util.spawn('qutebrowser') end,
    --     { description = 'F14 qutebrowser', group = 'shortcuts' }),
    -- awful.key({}, '#193', function() awful.util.spawn('alacritty --class cotp -e cotp') end,
    --     { description = 'F15 cotp', group = 'shortcuts' }),
    -- awful.key({}, '#194', function() awful.util.spawn('volumecontrol') end,
    --     { description = 'F16 pavucontrol', group = 'shortcuts' }),
    -- awful.key({}, '#195', function() awful.util.spawn('spotify') end,
    --     { description = 'F17 spotify', group = 'shortcuts' }),
    -- fn+F18 on Apple Keyboard
    -- awful.key({}, '#196', function() awful.util.spawn('autorandr docked') end,
    --     { description = 'F18 autorandr docked', group = 'shortcuts' }),
    -- fn+F19 on Apple Keyboard
    -- awful.key({}, '#197', move_clients_to_mouse, { description = 'F19 shuffle clients', group = 'shortcuts' }),
    awful.key({ modkey, }, 'j',
        function()
            awful.client.focus.byidx(1)
        end,
        { description = 'focus next by index', group = 'client' }
    ),
    awful.key({ modkey, }, 'k',
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = 'focus previous by index', group = 'client' }
    ),
    awful.key({ modkey, }, 'w', function() mymainmenu:show() end,
        { description = 'show main menu', group = 'awesome' }),

    -- Layout manipulation
    awful.key({ modkey, 'Shift' }, 'j', function() awful.client.swap.byidx(1) end,
        { description = 'swap with next client by index', group = 'client' }),
    awful.key({ modkey, 'Shift' }, 'k', function() awful.client.swap.byidx(-1) end,
        { description = 'swap with previous client by index', group = 'client' }),
    awful.key({ modkey, 'Control' }, 'j', function() awful.screen.focus_relative(1) end,
        { description = 'focus the next screen', group = 'screen' }),
    awful.key({ modkey, 'Control' }, 'k', function() awful.screen.focus_relative(-1) end,
        { description = 'focus the previous screen', group = 'screen' }),
    awful.key({ modkey, }, 'u', awful.client.urgent.jumpto,
        { description = 'jump to urgent client', group = 'client' }),
    awful.key({ modkey, }, 'Tab',
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = 'go back', group = 'client' }),

    -- Standard program
    awful.key({ modkey, }, 'Return', function() awful.spawn(terminal) end,
        { description = 'open a terminal', group = 'launcher' }),
    awful.key({ modkey, 'Control' }, 'r', awesome.restart,
        { description = 'reload awesome', group = 'awesome' }),
    awful.key({ modkey, 'Shift' }, 'q', awesome.quit,
        { description = 'quit awesome', group = 'awesome' }),
    awful.key({ modkey, }, 'l', function() awful.tag.incmwfact(0.05) end,
        { description = 'increase master width factor', group = 'layout' }),
    awful.key({ modkey, }, 'h', function() awful.tag.incmwfact(-0.05) end,
        { description = 'decrease master width factor', group = 'layout' }),
    awful.key({ modkey, 'Shift' }, 'h', function() awful.tag.incnmaster(1, nil, true) end,
        { description = 'increase the number of master clients', group = 'layout' }),
    awful.key({ modkey, 'Shift' }, 'l', function() awful.tag.incnmaster(-1, nil, true) end,
        { description = 'decrease the number of master clients', group = 'layout' }),
    awful.key({ modkey, 'Control' }, 'h', function() awful.tag.incncol(1, nil, true) end,
        { description = 'increase the number of columns', group = 'layout' }),
    awful.key({ modkey, 'Control' }, 'l', function() awful.tag.incncol(-1, nil, true) end,
        { description = 'decrease the number of columns', group = 'layout' }),
    awful.key({ modkey, }, 'space', function() awful.layout.inc(1) end,
        { description = 'select next', group = 'layout' }),
    awful.key({ modkey, 'Shift' }, 'space', function() awful.layout.inc(-1) end,
        { description = 'select previous', group = 'layout' }),

    awful.key({ modkey, 'Control' }, 'n',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    'request::activate', 'key.unminimize', { raise = true }
                )
            end
        end,
        { description = 'restore minimized', group = 'client' }),

    -- Prompt
    awful.key({ modkey }, 'r', function() awful.screen.focused().mypromptbox:run() end,
        { description = 'run prompt', group = 'launcher' }),

    awful.key({ modkey }, 'x',
        function()
            awful.prompt.run {
                prompt       = 'Run Lua code: ',
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. '/history_eval'
            }
        end,
        { description = 'lua execute prompt', group = 'awesome' }),
    -- Menubar
    awful.key({ modkey }, 'p', function() menubar.show() end,
        { description = 'show the menubar', group = 'launcher' })
)

clientkeys = gears.table.join(
    awful.key({ modkey, }, 'f',
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = 'toggle fullscreen', group = 'client' }),
    awful.key({ modkey, 'Shift' }, 'c', function(c) c:kill() end,
        { description = 'close', group = 'client' }),
    awful.key({ modkey, 'Control' }, 'space',
        function(c)
            awful.client.floating.toggle(c)
            awful.titlebar.toggle(c)
            c:raise()
        end,
        { description = 'toggle floating', group = 'client' }),
    awful.key({ modkey, 'Control' }, 'Return', function(c) c:swap(awful.client.getmaster()) end,
        { description = 'move to master', group = 'client' }),
    awful.key({ modkey, }, 'o', function(c) c:move_to_screen() end,
        { description = 'move to screen', group = 'client' }),
    awful.key({ modkey, }, 't', function(c) c.ontop = not c.ontop end,
        { description = 'toggle keep on top', group = 'client' }),
    awful.key({ modkey, }, 'n',
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        { description = 'minimize', group = 'client' }),
    awful.key({ modkey, }, 'm',
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = '(un)maximize', group = 'client' }),
    awful.key({ modkey, 'Control' }, 'm',
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        { description = '(un)maximize vertically', group = 'client' }),
    awful.key({ modkey, 'Shift' }, 'm',
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        { description = '(un)maximize horizontally', group = 'client' }),

    -- calc.lua
    -- https://gist.github.com/alex-pat/b8dcd3ac3ee61c07535407b56db07f78
    awful.key({ modkey }, 'c',
        function()
            awful.prompt.run {
                prompt       = 'Calculate: ',
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = function(text)
                    awful.spawn.easy_async(
                        'python -c \"from math import * ; print(' .. text .. ')\"',
                        function(stdout, stderr, exitreason, exitcode)
                            naughty.notify({
                                text = 'Result: ' .. string.sub(stdout, 1, -2),
                                position = 'top_left',
                                timeout = 5
                            })
                        end)
                end
            }
        end,
        { description = 'inline calculator', group = 'awesome' })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = 'view tag #' .. i, group = 'tag' }),
        -- Toggle tag display.
        awful.key({ modkey, 'Control' }, '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = 'toggle tag #' .. i, group = 'tag' }),
        -- Move client to tag.
        awful.key({ modkey, 'Shift' }, '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = 'move focused client to tag #' .. i, group = 'tag' }),
        -- Toggle tag on focused client.
        awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = 'toggle focused client on tag #' .. i, group = 'tag' })
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c.class ~= 'Onboard' then
            client.focus = c
            c:raise()
        else
            c:emit_signal('request::activate', 'mouse_click', { raise = true })
        end
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                'DTA',   -- Firefox addon DownThemAll.
                'copyq', -- Includes session name in class.
                'pinentry',
            },
            class = {
                'Arandr',
                'Blueman-manager',
                'ffplay',
                'Kruler',
                'cotp',
                'MessageWin',  -- kalarm.
                'Sxiv',
                'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
                'Wpa_gui',
                'veromix',
                'xtightvncviewer',
                'zoom' },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                'Event Tester', -- xev.
                'textern',      -- with `["/usr/bin/urxvt", "-T", "textern", "-e", "vim", "+call cursor(%l,%c)"]` as external editor
            },
            role = {
                'AlarmWindow',   -- Thunderbird's calendar.
                'ConfigManager', -- Thunderbird's about:config.
                'pop-up',        -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {
            titlebars_enabled = true,
            floating = true,
        }
    },
    {
        rule_any = {
            class = {
                'cotp',
            },
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
        }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            name = {
                'textern', -- with `["/usr/bin/urxvt", "-T", "textern", "-e", "vim", "+call cursor(%l,%c)"]` as external editor
            },
            class = {
                'Arandr',
                'Blueman-manager',
                'ffplay',
                'Sxiv',
                'zoom'
            },
            type = { 'dialog' }
        },
        properties = { titlebars_enabled = true }
    },

    -- On-screen keyboard
    {
        rule_any = {
            class = {
                'Onboard',
            },
        },
        properties = {
            focusable = false,
            floating = true,
            titlebars_enabled = true
        }
    },

    -- Colorpicker keyboard
    {
        rule_any = {
            class = {
                'Gpick',
            },
        },
        properties = {
            floating = true,
            titlebars_enabled = true,
            ontop = true,
        }
    },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal('request::titlebars', function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal('request::activate', 'titlebar', { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal('request::activate', 'titlebar', { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup {
        {
            -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        {
            -- Middle
            {
                -- Title
                align  = 'center',
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        {
            -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
    if client.focus and client.focus.class ~= 'Gpick' then
        c:emit_signal('request::activate', 'mouse_enter', { raise = false })
    end
end)

client.connect_signal('focus', function(c) c.border_color = beautiful.border_focus end)
client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)
-- }}}
