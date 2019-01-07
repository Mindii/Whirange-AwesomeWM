-------------------------------------------------------------------------------
-- Whirange	AwesomeWM Widget Redshift toggle
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------
local gears	= require("gears")
local awful   = require("awful")
local wibox   = require("wibox")
local beautiful	= require("beautiful")
local toggle = 'sh /home/mindi/.config/awesome/scripts/toggle redshift'
local redshift = {}

local icon = '<span color="' .. beautiful.widget_icon_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'
local icon_no = '<span color="' .. beautiful.widget_icon_off_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'

local redshift = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/running redshift', 10, function(widget, stdout) 
	if stdout:match("yes") then
		widget:set_markup(" " .. icon .. " ")
	else
		widget:set_markup(" " .. icon_no .. " ")
	end
end)

redshift:connect_signal("button::press", function(_,_,_,button)
    if (button == 1)     then awful.spawn(toggle)
    end
end)

return {
	redshift, 
	bg = beautiful.taglist_bg_empty, 
	fg = beautiful.taglist_fg_empty,
	shape = gears.shape.partially_rounded_rect,
	widget = wibox.container.background, 
}
