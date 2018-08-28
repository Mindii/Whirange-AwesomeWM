-------------------------------------------------------------------------------
-- Whirange	AwesomeWM Theme
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi =	xresources.apply_dpi
local gfs =	require("gears.filesystem")
local themes_path =	gfs.get_themes_dir()
local theme	= {}

theme.font			= "lucy tewi 8"
theme.wallpaper		= themes_path.."whirange/bg.jpg"

theme.bg_normal		= "#ffffff"
theme.bg_focus		= "#ffa700"
theme.bg_urgent		= "#FFBABA"
theme.bg_minimize	=	"#444444"
theme.bg_systray	= theme.bg_normal

theme.fg_normal		= "#aaaaaa"
theme.fg_focus		= "#ffffff"
theme.fg_urgent		= "#ffffff"
theme.fg_minimize	=	"#FF6D6D"

theme.useless_gap	=	dpi(1)
theme.border_width	= dpi(2)
theme.border_normal	= "#000000"
theme.border_focus	= "#ffa700"
theme.border_marked	= "#91231c"

-- Tasklist
theme.tasklist_disable_task_name = 1
theme.tasklist_spacing = 2

-- Generate	taglist	squares:
local taglist_square_size =	dpi(3)
theme.taglist_squares_sel =	theme_assets.taglist_squares_sel(
	taglist_square_size, theme.bg_normal
)
theme.taglist_squares_unsel	= theme_assets.taglist_squares_unsel(
	taglist_square_size, theme.bg_focus
)

-- Variables set for theming notifications:
theme.notification_font	= "lucy	tewi 8"
theme.notification_bg =	"#ffa700"
theme.notification_fg =	"#ffffff"
theme.notification_width = 300
theme.notification_margin =	10

-- Variables set for theming the menu:
theme.menu_submenu_icon	= themes_path.."whirange/icon/submenu.png"
theme.menu_height =	dpi(15)
theme.menu_width  =	dpi(100)

-- Generate	Awesome	icon:
theme.awesome_icon = theme_assets.awesome_icon(
	theme.menu_height,	theme.bg_focus,	theme.fg_focus
)

-- Define the icon theme for application icons.
theme.icon_theme = nil

return theme
