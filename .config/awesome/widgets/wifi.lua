-------------------------------------------------------------------------------
-- Whirange	AwesomeWM Widget Wifi
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------
local gears	= require("gears")
local awful   = require("awful")
local wibox   = require("wibox")
local beautiful	= require("beautiful")
local wifi = {}

local icon = '<span color="' .. beautiful.widget_icon_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'

local wifi = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/wifi', 15,
	function(widget, stdout) widget:set_markup(" " .. icon .. stdout)
end)

return {
	wifi, 
	bg = beautiful.taglist_bg_empty, 
	fg = beautiful.taglist_fg_empty,
	shape = gears.shape.partially_rounded_rect,
	shape_border_color = beautiful.widget_border_color,
	shape_border_width = 1,
	widget = wibox.container.background, 
}
