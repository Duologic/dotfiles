-------------------------------------------------
-- Battery Widget for Awesome Window Manager
-- Shows the battery status using the ACPI tool
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/battery-widget

-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local gfs = require("gears.filesystem")
local dpi = require('beautiful').xresources.apply_dpi

local PATH_TO_ICONS = "/usr/share/icons/Arc/status/symbolic/"
local HOME = os.getenv("HOME")

local icon_widget = wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(_, 0, 0, 3)
}

local level_widget = wibox.widget {
    font = font,
    widget = wibox.widget.textbox
}

local micmuted_widget = wibox.widget {
    icon_widget,
    level_widget,
    layout = wibox.layout.fixed.horizontal,
}

function micmuted_widget.worker(args)
    local args = args or {}

    local margin_left = args.margin_left or 0
    local margin_right = args.margin_right or 0

    if not gfs.dir_readable(PATH_TO_ICONS) then
        naughty.notify{
            title = "Mic Muted Widget",
            text = "Folder with icons doesn't exist: " .. PATH_TO_ICONS,
            preset = naughty.config.presets.critical
        }
    end

    watch("amixer get Capture", 10,
    function(widget, stdout, stderr, exitreason, exitcode)
        for s in stdout:gmatch("[^\r\n]+") do
            local status = string.match(s, 'off')
            if status == 'off' then mutedIcon = "microphone-sensitivity-muted-symbolic"
            else mutedIcon = "microphone-sensitivity-high-symbolic"
            end
            -- naughty.notify { title = status, text = mutedIcon }
        end

        widget.icon:set_image(PATH_TO_ICONS .. mutedIcon .. ".svg")

    end,
    icon_widget)

    return wibox.container.margin(micmuted_widget, margin_left, margin_right)
end

function micmuted_widget.update_mute()
    local f = io.popen("amixer get Capture")

    -- if the cmd cannot be found
    if f == nil then
        return false
    end

    local stdout = f:read("*a")
    f:close()

    for s in stdout:gmatch("[^\r\n]+") do
        local status = string.match(s, 'off')
        if status == 'off' then mutedIcon = "microphone-sensitivity-muted-symbolic"
        else mutedIcon = "microphone-sensitivity-high-symbolic"
        end
    end

    icon_widget.icon:set_image(PATH_TO_ICONS .. mutedIcon .. ".svg")
end

return setmetatable(micmuted_widget, { __call = function(_, ...) return micmuted_widget end })
