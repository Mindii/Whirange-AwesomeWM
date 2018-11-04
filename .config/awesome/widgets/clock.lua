-------------------------------------------------------------------------------
-- Whirange	AwesomeWM Widget clock
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------
local gears	= require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful	= require("beautiful")
local textclock = {}

function events()
	local today = os.date(" %d "):gsub(" 0"," ")
	local todayb = os.date("<b><span color='#FFA700'>" .. today .. "</span></b>")
	local Calendar = io.popen("cal -m | sed -e 's/^/       /' -e 's/$/       /'")
	local CalendarResult = Calendar:read("*a")
	Calendar:close()
	local CalendarResult = string.gsub(CalendarResult,today,todayb)
	

	local NextEvents = io.popen("cat /home/mindi/.config/awesome/scripts/db/NextEvents.txt | sed -e '1s,^,<b>,' -e '1s,$,</b>,' |  sed -e '3s,^,<b>,' -e '3s,$,</b>,' |  sed -e '5s,^,<b>,' -e '5s,$,</b>,' |  sed -e '7s,^,<b>,' -e '7s,$,</b>,' |  sed -e '9s,^,<b>,' -e '9s,$,</b>,' |  sed -e '11s,^,<b>,' -e '11s,$,</b>,'")
	local NextEventsResult = NextEvents:read("*a")
	NextEvents:close()
	
	local EndedEvents = io.popen('cat /home/mindi/.config/awesome/scripts/db/EndedEvents.txt')
	local EndedEventsResult = EndedEvents:read("*a")
	EndedEvents:close()
	return "\n" .. CalendarResult .. "----------------------------------\n\n" .. "<span color='"..beautiful.mindi_darkergray.."'>" .. EndedEventsResult .. "</span>" .. "<span color='"..beautiful.mindi_darkestgray.."'>"..NextEventsResult.."</span>\n"
end

textclock.widget = wibox.widget.textclock(" %I:%M %p ")

textclock.tooltip = awful.tooltip({
    objects = { textclock.widget },
	timeout = 60,
    timer_function = function()
		return events()
    end,
	margin_leftright = 10,
	margin_topbottom = 5,
})

return { 
	textclock, 
	bg = beautiful.taglist_bg_empty, 
	fg = beautiful.taglist_fg_empty,
	shape = gears.shape.partially_rounded_rect,
	shape_border_color = beautiful.widget_clock_border_color,
	shape_border_width = 1,
	widget = wibox.container.background, 
}
