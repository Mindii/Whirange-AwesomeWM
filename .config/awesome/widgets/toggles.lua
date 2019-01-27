-------------------------------------------------------------------------------
-- Whirange	AwesomeWM Widget Redshift toggle
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------
local gears	= require("gears")
local awful   = require("awful")
local wibox   = require("wibox")
local beautiful	= require("beautiful")
local toggle_redshift = 'sh /home/mindi/.config/awesome/scripts/toggle redshift'
local toggle_compton = 'sh /home/mindi/.config/awesome/scripts/toggle compton'
local redshift = {}
local compton = {}
local mocp = {}

-- Redshift Setup
local icon_redshift = '<span color="' .. beautiful.widget_icon_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'
local icon_no_redshift = '<span color="' .. beautiful.widget_icon_off_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'

local redshift = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/running redshift', 11, function(widget, stdout) 
	if stdout:match("yes") then
		widget:set_markup(" " .. icon_redshift .. " ")
	else
		widget:set_markup(" " .. icon_no_redshift .. " ")
	end
end)

redshift:connect_signal("button::press", function(_,_,_,button)
    if (button == 1)     then awful.spawn(toggle_redshift)
    end
end)
-- Redshift End


-- Compton Setup
local icon_compton = '<span color="' .. beautiful.widget_icon_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'
local icon_no_compton = '<span color="' .. beautiful.widget_icon_off_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'

local compton = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/running compton', 10, function(widget, stdout) 
	if stdout:match("yes") then
		widget:set_markup(" " .. icon_compton .. " ")
	else
		widget:set_markup(" " .. icon_no_compton .. " ")
	end
end)

compton:connect_signal("button::press", function(_,_,_,button)
    if (button == 1) then 
		awful.spawn(toggle_compton)
	end
end)
-- Compton End


-- Mocp Setup
local icon_mocp = '<span color="' .. beautiful.widget_icon_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'
local icon_no_mocp = '<span color="' .. beautiful.widget_icon_off_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'

local mocp = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/mocp-notifications', 12, function(widget, stdout) 
	if stdout:match("yes") then
		widget:set_markup(" " .. icon_mocp .. " ")
	else
		widget:set_markup(" " .. icon_no_mocp .. " ")
	end
end)
-- Mocp End



-- Combine Things
return {
	{mocp, 
	bg = beautiful.taglist_bg_empty, 
	fg = beautiful.taglist_fg_empty, 
	shape = gears.shape.partially_rounded_rect,
	shape_border_color = beautiful.widget_border_color,
	shape_border_width = 1,
	widget = wibox.container.background,},
	{redshift, 
	bg = beautiful.taglist_bg_empty, 
	fg = beautiful.taglist_fg_empty,
	shape = gears.shape.partially_rounded_rect,
	shape_border_color = beautiful.widget_border_color,
	shape_border_width = 1,
	widget = wibox.container.background,},
	{compton, 
	bg = beautiful.taglist_bg_empty, 
	fg = beautiful.taglist_fg_empty,
	shape = gears.shape.partially_rounded_rect,
	shape_border_color = beautiful.widget_border_color,
	shape_border_width = 1,
	widget = wibox.container.background,},
	layout = wibox.layout.fixed.horizontal,
	spacing = 2,
}
