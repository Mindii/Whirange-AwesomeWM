-------------------------------------------------------------------------------
-- Whirange	AwesomeWM Theme
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------
local theme_assets 					= require("beautiful.theme_assets")
local xresources 					= require("beautiful.xresources")
local dpi 							= xresources.apply_dpi
local gfs 							= require("gears.filesystem")
local themes_path 					= gfs.get_themes_dir()
local theme							= {}

-- Whirange Colors --
theme.mindi_white 					= "#ffffff"
theme.mindi_black					= "#000000"
theme.mindi_orange 					= "#ffa700"
theme.mindi_lightgray				= "#f3f3f3"
theme.mindi_darkergray				= "#e4e4e4"
theme.mindi_darkestgray				= "#aaaaaa"
theme.mindi_urgent					= "#ffbaba"
theme.mindi_white_transparent		= "#ffffff99"

-- Widgets
theme.widget_border_color 			= theme.mindi_white
theme.widget_clock_border_color 	= theme.mindi_darkergray
theme.widget_separator_color	 	= theme.mindi_darkergray
theme.widget_icon_color				= theme.mindi_orange
theme.widget_icon_off_color			= theme.mindi_lightgray
theme.widget_progress_bg_color		= theme.mindi_white
theme.widget_progress_border_color	= theme.mindi_darkergray
theme.widget_progress_icon_color	= theme.mindi_darkergray
theme.widget_icon_size				= dpi(8)

-- Defaults --
theme.font							= "lucy tewi 7"
theme.wallpaper						= themes_path.."whirange/bg.jpg"

theme.bg_normal						= theme.mindi_white
theme.bg_focus						= theme.mindi_orange
theme.bg_urgent						= theme.mindi_urgent
theme.bg_minimize					= theme.mindi_lightgray
theme.bg_systray					= theme.mindi_white
theme.fg_normal						= theme.mindi_black
theme.fg_focus						= theme.mindi_white
theme.fg_urgent						= theme.mindi_white
theme.fg_minimize					= theme.mindi_white

theme.useless_gap					= dpi(12)
theme.border_width					= dpi(1)
theme.border_normal					= theme.mindi_black
theme.border_focus					= theme.mindi_orange
theme.border_marked					= theme.mindi_urgent

theme.tooltip_fg 					= theme.mindi_darkestgray
theme.tooltip_bg 					= theme.mindi_white
theme.tooltip_border_color 			= theme.mindi_black
theme.tooltip_border_width 			= 1

-- Tag list --
theme.taglist_font 					= "lucy tewi 7"

-- BG
theme.taglist_bg_empty 				= theme.mindi_white
theme.taglist_bg_occupied 			= theme.mindi_lightgray
theme.taglist_bg_focus 				= theme.mindi_orange
theme.taglist_bg_urgent 			= theme.mindi_urgent
-- FG
theme.taglist_fg_empty 				= theme.mindi_darkestgray
theme.taglist_fg_occupied 			= theme.mindi_black
theme.taglist_fg_focus 				= theme.mindi_white
theme.taglist_fg_urgent 			= theme.mindi_black

-- Tasklist --
theme.tasklist_disable_task_name 	= 1
theme.tasklist_spacing 				= 2

-- Notifications --
theme.notification_bg 				= theme.mindi_white
theme.notification_fg 				= theme.mindi_orange
theme.notification_border_color 	= theme.mindi_black
theme.notification_width 			= 300
theme.notification_margin 			= 10

-- Menus --
theme.menu_submenu_icon 			= themes_path.."whirange/icon/submenu.png"
theme.menu_height 					= dpi(12)
theme.menu_width  					= dpi(100)

-- Icons --
theme.awesome_icon = theme_assets.awesome_icon(
	theme.menu_height,	theme.bg_focus,	theme.fg_focus
)

theme.icon_theme = nil

return theme
