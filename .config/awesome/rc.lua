-------------------------------------------------------------------------------
-- Whirange	AwesomeWM -	Not	so Awesome,	Awesome	Dot
-- Mindi @ Mindinet.org
-- GNU General Public License v3.0
-------------------------------------------------------------------------------
local gears	= require("gears")
local awful	= require("awful")
require("awful.autofocus")
local wibox	= require("wibox")
local beautiful	= require("beautiful")
local naughty =	require("naughty")
local menubar =	require("menubar")
local hotkeys_popup	= require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")

-------------------------------------------------------------------------------
-- Error Check
-------------------------------------------------------------------------------
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
					 title	= "Oops, there were	errors during startup!",
					 text = awesome.startup_errors	})
end

do
	local in_error	= false
	awesome.connect_signal("debug::error",	function (err)
		-- Make sure we don't	go into	an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset =	naughty.config.presets.critical,
						 title = "Oops, an error happened!",
						 text	= tostring(err)	})
		in_error = false
	end)
end

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------
beautiful.init(awful.util.getdir("config") .. "/themes/whirange/theme.lua")
Mindi =	{}
Mindi.Prog = {}
Mindi.Command =	{}
Mindi.Path = {}
Mindi.Bar =	{}
-- Main	Vars
Mindi.Mod =					'Mod4' -- Mod key
Mindi.Tags1 = 				{"[1] Main", "[2] Dev", "[3] Dev II", "[4] Browser", "[5] Gaming", "[6] Chat", "[7] Email"}
Mindi.Tags2 = 				{"[1] Video", "[2] Browser", "[3] Chat"}
-- Programs
Mindi.Prog.Terminal	= 		'urxvt'	-- Terminal command (Mod + Return)
Mindi.Prog.FileManager = 	'thunar' -- Filemanager (Mod	+ E)
Mindi.Prog.MusicPlayer = 	'mocp' -- Music	Player (Mod	+ M)
-- Commands
Mindi.Command.Screenshot =	awful.util.getdir("config") .. 'scripts/screenshot.sh'		-- Screenshot	Command	(Print + Click on window)
Mindi.Command.Autostart	=	awful.util.getdir("config") .. 'scripts/autorun.sh'			-- Autostart	Command
-- Paths
Mindi.Path.Icon	=		 	awful.util.getdir("config")	.. "/themes/whirange/icon/"
-- Bar
Mindi.Bar.Height = 			'16'								-- Taskbar Height
Mindi.Bar.Clock	= 			wibox.widget.textclock(" %R ")	--	Taskbar	Clock

-------------------------------------------------------------------------------
-- Layout's
-------------------------------------------------------------------------------
awful.layout.layouts = {
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.floating,
	--	awful.layout.suit.tile,
	--	awful.layout.suit.tile.left,
	--	awful.layout.suit.tile.bottom,
	--	awful.layout.suit.tile.top,
	--	awful.layout.suit.fair,
	--	awful.layout.suit.fair.horizontal,
	--	awful.layout.suit.spiral,
	--	awful.layout.suit.max,
	--	awful.layout.suit.max.fullscreen,
	--	awful.layout.suit.magnifier,
	--	awful.layout.suit.corner.nw,
	--	awful.layout.suit.corner.ne,
	--	awful.layout.suit.corner.sw,
	--	awful.layout.suit.corner.se,
}

-------------------------------------------------------------------------------
-- Helper functions
-------------------------------------------------------------------------------
local function client_menu_toggle_fn()
	local instance	= nil

	return	function ()
		if instance and instance.wibox.visible then
			instance:hide()
			instance	= nil
		else
			instance	= awful.menu.clients({ theme = { width = 250 } })
		end
	end
end

-------------------------------------------------------------------------------
-- Toolbar
-------------------------------------------------------------------------------
local taglist_buttons =	gears.table.join(
					awful.button({	}, 1, function(t) t:view_only()	end),
					awful.button({	Mindi.Mod }, 1,	function(t)
											  if	client.focus then
												  client.focus:move_to_tag(t)
											  end
										  end),
					awful.button({	}, 3, awful.tag.viewtoggle),
					awful.button({	Mindi.Mod }, 3,	function(t)
											  if	client.focus then
												  client.focus:toggle_tag(t)
											  end
										  end),
					awful.button({	}, 4, function(t) awful.tag.viewnext(t.screen) end),
					awful.button({	}, 5, function(t) awful.tag.viewprev(t.screen) end)
				)

local tasklist_buttons = gears.table.join(
					 awful.button({ },	1, function	(c)
											  if	c == client.focus then
												  c.minimized =	true
											  else
												  -- Without this, the following
												  -- :isvisible() makes	no sense
												  c.minimized =	false
												  if not c:isvisible() and c.first_tag then
													  c.first_tag:view_only()
												  end
												  -- This will also	un-minimize
												  -- the client, if	needed
												  client.focus = c
												  c:raise()
											  end
										  end),
					 awful.button({ },	3, client_menu_toggle_fn()),
					 awful.button({ },	4, function	()
											  awful.client.focus.byidx(1)
										  end),
					 awful.button({ },	5, function	()
											  awful.client.focus.byidx(-1)
										  end))

local function set_wallpaper(s)
	--	Wallpaper
	if	beautiful.wallpaper	then
		local	wallpaper =	beautiful.wallpaper
		if type(wallpaper) ==	"function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper	when a screen's	geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry",	set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	set_wallpaper(s)

	tags = {}
	if s == screen.primary then
		awful.tag.new(Mindi.Tags1, s, awful.layout.layouts[1])
	else
		awful.tag(Mindi.Tags2, s, awful.layout.layouts[1])
	end
		
	--	Create a promptbox for each	screen
	s.mypromptbox = awful.widget.prompt()
	--	Create an imagebox widget which	will contain an	icon indicating	which layout we're using.
	--	We need	one	layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
						   awful.button({	}, 1, function () awful.layout.inc(	1) end),
						   awful.button({	}, 3, function () awful.layout.inc(-1) end),
						   awful.button({	}, 4, function () awful.layout.inc(	1) end),
						   awful.button({	}, 5, function () awful.layout.inc(-1) end)))
	--	Create a taglist widget
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all,	taglist_buttons)

	--	Create a tasklist widget
	s.mytasklist =	awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

	--	Create the wibox
	s.mywibox = awful.wibar({ position	= "top", screen	= s, height	= Mindi.Bar.Height })

	--	Add	widgets	to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{	-- Left	widgets
			layout =	wibox.layout.fixed.horizontal,
			mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		{	-- Middle widget		
			   layout = wibox.layout.fixed.horizontal,
			  --s.mytasklist,
		},
		{	-- Right widgets
			layout =	wibox.layout.fixed.horizontal,
			Mindi.Bar.Clock,
		},
	}
end)

-------------------------------------------------------------------------------
-- Mouse Bindings
-------------------------------------------------------------------------------
root.buttons(gears.table.join(
	--awful.button({ }, 3,	function ()	mymainmenu:toggle()	end),
	awful.button({	}, 4, awful.tag.viewnext),
	awful.button({	}, 5, awful.tag.viewprev)
))

-------------------------------------------------------------------------------
-- Key Bindings
-------------------------------------------------------------------------------
globalkeys = gears.table.join(
	awful.key({						  }, "Print", 		function() os.execute(Mindi.Command.Screenshot) end),
	awful.key({ Mindi.Mod,			  }, "r",			function() awful.screen.focused().mypromptbox:run() end),
	awful.key({ Mindi.Mod,			  }, "Return", 		function() awful.spawn(Mindi.Prog.Terminal) end),
	awful.key({ Mindi.Mod,			  }, "e",			function() awful.spawn(Mindi.Prog.FileManager) end),
	awful.key({ Mindi.Mod,			  }, "d",			function() menubar.show()	end),
	--	Select with	arrows
	awful.key({ Mindi.Mod,			  }, "Up", 			function() awful.client.focus.global_bydirection("up") end),
	awful.key({ Mindi.Mod,			  }, "Down", 		function() awful.client.focus.global_bydirection("down") end),
	awful.key({ Mindi.Mod,			  }, "Left", 		function() awful.client.focus.global_bydirection("left") end),
	awful.key({ Mindi.Mod,			  }, "Right", 		function() awful.client.focus.global_bydirection("right")	end),
	--	Move with arrows
	awful.key({ Mindi.Mod,	"Shift"	  }, "Up", 			function() awful.client.swap.global_bydirection("up")	end),
	awful.key({ Mindi.Mod,	"Shift"	  }, "Down", 		function() awful.client.swap.global_bydirection("down") end),
	awful.key({ Mindi.Mod,	"Shift"	  }, "Left", 		function() awful.client.swap.global_bydirection("left") end),
	awful.key({ Mindi.Mod,	"Shift"	  }, "Right", 		function() awful.client.swap.global_bydirection("right") end),
	--	Restart	/ Quit
	awful.key({ Mindi.Mod,	"Control" }, "r", 			awesome.restart),
	awful.key({ Mindi.Mod,	"Shift"	  }, "e", 			awesome.quit),
	-- Media Keys
	awful.key({ Mindi.Mod,}, "m",						function() awful.spawn(Mindi.Prog.Terminal .. " -e " .. Mindi.Prog.MusicPlayer) end),
	awful.key({}, "XF86AudioLowerVolume",				function() awful.spawn('amixer set Master 3%-') end),
	awful.key({}, "XF86AudioRaiseVolume",				function() awful.spawn('amixer set Master 3%+') end),
	awful.key({}, "XF86AudioPlay",						function() awful.spawn('mocp --play') end),
	awful.key({}, "XF86AudioStop",						function() awful.spawn('mocp --stop') end),
	awful.key({}, "XF86AudioNext",						function() awful.spawn('mocp --next') end),
	awful.key({}, "XF86AudioPrev",						function() awful.spawn('mocp --previous') end)	
)

clientkeys = gears.table.join(
	awful.key({ Mindi.Mod,			}, "f", 			function (c) c.fullscreen	= not c.fullscreen c:raise() end),
	awful.key({ Mindi.Mod,	"Shift"	}, "q", 			function (c) c:kill() end),
	awful.key({ Mindi.Mod,	"Shift"	}, "space",			awful.client.floating.toggle),
	awful.key({	Mindi.Mod,			}, "Tab", 			function () for c	in awful.client.iterate(function (x) return	true end) do client.focus	= c client.focus:raise() end end),
	awful.key({ Mindi.Mod,	"Shift"	}, "Tab", 			function () awful.client.focus.byidx(1) if client.focus then client.focus:raise() end end)	 
)

-- Bind	all	key	numbers	to tags.
for	i =	1, 9 do
	globalkeys	= gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ Mindi.Mod	}, "#" .. i	+ 9,
				  function ()
						local	screen = awful.screen.focused()
						local	tag	= screen.tags[i]
						if tag then
						   tag:view_only()
						end
				  end,
				  {description = "view tag #"..i, group	= "tag"}),
		-- Toggle	tag	display.
		awful.key({ Mindi.Mod, "Control" }, "#" .. i + 9,
				  function ()
					  local screen	= awful.screen.focused()
					  local tag = screen.tags[i]
					  if tag then
						 awful.tag.viewtoggle(tag)
					  end
				  end,
				  {description = "toggle tag #"	.. i, group	= "tag"}),
		-- Move client to	tag.
		awful.key({ Mindi.Mod, "Shift" },	"#"	.. i + 9,
				  function ()
					  if client.focus then
						  local tag =	client.focus.screen.tags[i]
						  if tag then
							  client.focus:move_to_tag(tag)
						  end
					 end
				  end,
				  {description = "move focused client to tag #"..i,	group =	"tag"}),
		-- Toggle	tag	on focused client.
		awful.key({ Mindi.Mod, "Control",	"Shift"	}, "#" .. i	+ 9,
				  function ()
					  if client.focus then
						  local tag =	client.focus.screen.tags[i]
						  if tag then
							  client.focus:toggle_tag(tag)
						  end
					  end
				  end,
				  {description = "toggle focused client	on tag #" .. i,	group =	"tag"})
	)
end

clientbuttons =	gears.table.join(
	awful.button({	}, 1, function (c) client.focus	= c; c:raise() end),
	awful.button({	Mindi.Mod }, 1,	awful.mouse.client.move),
	awful.button({	Mindi.Mod }, 3,	awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)

-------------------------------------------------------------------------------
-- Rules
-------------------------------------------------------------------------------
-- Rules to	apply to new clients (through the "manage" signal).
awful.rules.rules =	{
	{ rule	= {	},
	  properties =	{ border_width = beautiful.border_width,
					 border_color = beautiful.border_normal,
					 focus	= awful.client.focus.filter,
					 raise	= true,
					 keys = clientkeys,
					 buttons =	clientbuttons,
					 screen = awful.screen.preferred,
					 placement	= awful.placement.no_overlap+awful.placement.no_offscreen
	 }
	},
	--	Floating clients.
	{ rule_any	= {
		instance = {
		  "RuleName",
		},
		class	= {
		  "RuleName"
		},
		name = {
		  "RuleName",
		},
		role = {
		  "pop-up",
		}
	  }, properties = { floating =	true }},
}

-- Signal function to execute when a new client	appears.
client.connect_signal("manage",	function (c)
	if	awesome.startup	and
	  not c.size_hints.user_position
	  and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end)

-- Enable sloppy focus,	so that	focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	if	awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
		and awful.client.focus.filter(c) then
		client.focus = c
	end
end)

client.connect_signal("focus", function(c) c.border_color =	beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color	= beautiful.border_normal end)

-- Autorun
awful.spawn.with_shell(Mindi.Command.Autostart)
