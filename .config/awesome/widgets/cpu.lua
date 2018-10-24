-------------------------------------------------------------------------------
-- Whirange	AwesomeWM Widget Cpu
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------
local gears	= require("gears")
local awful   = require("awful")
local wibox   = require("wibox")
local beautiful	= require("beautiful")

local icon = '<span color="' .. beautiful.widget_progress_icon_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'

local cpu_1m = wibox.widget {
	max_value     = 16,
	forced_height = 4,
	forced_width  = 100,
	border_width  = 1,
	border_color  = beautiful.widget_border_color,
	widget        = wibox.widget.progressbar,
	background_color = beautiful.taglist_bg_empty, 
	color = beautiful.mindi_orange,
}

local cpu_1m_text = wibox.widget {
	align = 'center',
	widget = wibox.widget.textbox,
}

local cpu1 = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/cpu 1m', 15, 
	function(widget, stdout)
		local cpu_val1 = tonumber(stdout)
		cpu_1m:set_value(cpu_val1)
end)

local cpu_val = awful.widget.watch('sh /home/mindi/.config/awesome/scripts/cpu usage', 15, 
	function(widget, stdout)
		local cpu_val1 = stdout
		cpu_1m_text:set_markup(" <span color='"..beautiful.taglist_fg_empty.."'>"..cpu_val1.."</span>")
end)


return {
	cpu_1m,
	cpu_1m_text,
	widget = wibox.container.background,
	layout = wibox.layout.stack
}
