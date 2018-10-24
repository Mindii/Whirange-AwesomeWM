-------------------------------------------------------------------------------
-- Whirange	AwesomeWM Widget HDD
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------
local gears	= require("gears")
local awful   = require("awful")
local wibox   = require("wibox")
local beautiful	= require("beautiful")

local icon = '<span color="' .. beautiful.widget_icon_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'

-- hdd1
local hdd1widget = wibox.widget {
	align = 'center',
	widget = wibox.widget.textbox,
}
local hdd1 = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/hdd hdd1', 15,
	function(widget, stdout) 
		hdd1widget:set_markup(" " .. icon .. stdout)
end)

-- hdd2
local hdd2widget = wibox.widget {
	align = 'center',
	widget = wibox.widget.textbox,
}
local hdd2 = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/hdd hdd2', 15,
	function(widget, stdout) 
		hdd2widget:set_markup(" " .. icon .. stdout)
end)

-- hdd3
local hdd3widget = wibox.widget {
	align = 'center',
	widget = wibox.widget.textbox,
}
local hdd3 = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/hdd hdd3', 15,
	function(widget, stdout) 
		hdd3widget:set_markup(" " .. icon .. stdout)
end)

return {
	{hdd1widget, 
	bg = beautiful.taglist_bg_empty, 
	fg = beautiful.taglist_fg_empty, 
	shape = gears.shape.partially_rounded_rect,
	shape_border_color = beautiful.widget_border_color,
	shape_border_width = 1,
	widget = wibox.container.background,},
	{hdd2widget, 
	bg = beautiful.taglist_bg_empty, 
	fg = beautiful.taglist_fg_empty,
	shape = gears.shape.partially_rounded_rect,
	shape_border_color = beautiful.widget_border_color,
	shape_border_width = 1,
	widget = wibox.container.background,},
	{hdd3widget, 
	bg = beautiful.taglist_bg_empty, 
	fg = beautiful.taglist_fg_empty,
	shape = gears.shape.partially_rounded_rect,
	shape_border_color = beautiful.widget_border_color,
	shape_border_width = 1,
	widget = wibox.container.background,},
	layout = wibox.layout.fixed.horizontal,
	spacing = 2,
}
