-------------------------------------------------------------------------------
-- Whirange	AwesomeWM Widget Redshift toggle
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------
local wibox   = require("wibox")
local beautiful	= require("beautiful")
local Separator_markup = '<span color="' .. beautiful.widget_separator_color .. '" font="fontawesome ' .. beautiful.widget_icon_size .. '"></span>'

local Separator = wibox.widget{
    markup = Separator_markup,
    widget = wibox.widget.textbox
}

return Separator
