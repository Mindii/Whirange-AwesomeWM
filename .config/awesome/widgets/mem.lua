-------------------------------------------------------------------------------
-- Whirange	AwesomeWM Widget MEM
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------
local gears	= require("gears")
local awful   = require("awful")
local wibox   = require("wibox")
local beautiful	= require("beautiful")

local icon = '<span color="' .. beautiful.widget_progress_icon_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'

local memory = wibox.widget {
	max_value     = 100,
	forced_height = 4,
	forced_width  = 100,
	border_width  = 1,
	border_color  = beautiful.widget_border_color,
	widget        = wibox.widget.progressbar,
	background_color = beautiful.taglist_bg_empty, 
	color = beautiful.taglist_bg_focus,
}

local memory_text = wibox.widget {
	align = 'center',
	widget        = wibox.widget.textbox,
}

local mem_percent = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/mem percent', 30, 
	function(widget, stdout)
		local value = tonumber(stdout)
		memory:set_value(value)
end)

local mem_usage = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/mem usage', 30, 
	function(widget, stdout)
		local value = stdout
		memory_text:set_markup("<span color='".. beautiful.taglist_fg_empty .."'>".. value .."</span>")
end)


return {
	memory,
	memory_text,
	fg = beautiful.taglist_bg_focus,
	widget = wibox.container.background,
	layout = wibox.layout.stack
}
