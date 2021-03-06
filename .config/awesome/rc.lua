-------------------------------------------------------------------------------
-- Whirange	AwesomeWM - Not so Awesome, Awesome Dots
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
Mindi = {}
Mindi.Prog = {}
Mindi.Command = {}
Mindi.Path = {}
Mindi.Bar = {}
-- Main Vars
Mindi.Mod =                 'Mod4' -- Mod key
Mindi.Tags1 =               {"一", "二", "三", "四", "五", "六", "七", "八", "九"}
Mindi.Tags2 =               {"一", "二", "三", "四"}
-- Programs
Mindi.Prog.Terminal =       'urxvt'	-- Terminal command (Mod + Return)
Mindi.Prog.FileManager =    'thunar' -- Filemanager (Mod + E)
Mindi.Prog.MusicPlayer =    'mocp' -- Music	Player (Mod	+ M)
-- Commands
Mindi.Command.Screenshot =  awful.util.getdir("config") .. 'scripts/screenshot.sh' -- Screenshot Command (Print + Click on window)
Mindi.Command.Autostart =   awful.util.getdir("config") .. 'scripts/autorun.sh' -- Autostart Script
Mindi.Command.NPPaste =     awful.util.getdir("config") .. 'scripts/nowplay_paste'
Mindi.Command.Buy =         awful.util.getdir("config") .. 'scripts/text_paste buy'
Mindi.Command.Btw =         awful.util.getdir("config") .. 'scripts/text_paste btw'
-- Paths
Mindi.Path.Icon =           awful.util.getdir("config")	.. "/themes/whirange/icon/"
-- Bar
Mindi.Bar.Height1 =         '16' -- Taskbar monitor 1 height
--Mindi.Bar.Width1 =          '97%' -- Taskbar monitor 1 Width
Mindi.Bar.Height2 =         '16' -- Taskbar monitor 2 Height
--Mindi.Bar.Width2 =          '80%' -- Taskbar monitor 2 Width
Mindi.Bar.BorderWidth =     '2'
Mindi.Bar.Clock =           require("widgets.clock")	--	Taskbar	Clock
Mindi.Bar.Cpu =             require("widgets.cpu_v2")
Mindi.Bar.Mem =             require("widgets.mem")
Mindi.Bar.Hdd =             require("widgets.hdd")
Mindi.Bar.Weather =         require("widgets.weather")
Mindi.Bar.Separator =       require("widgets.separator")
-- Bar Buttons
Mindi.Bar.Toggles =         require("widgets.toggles")

-------------------------------------------------------------------------------
-- Layout's
-------------------------------------------------------------------------------
awful.layout.layouts = {
	awful.layout.suit.spiral,
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

awful.screen.connect_for_each_screen(function(s)
	tags = {}
	-- If primary screen then add tags from Mindi.Tag1 var
	if s == screen.primary then
		-- Lets add first tag alone so that we can set it default select
		awful.tag.add(Mindi.Tags1[1], {layout = awful.layout.layouts[1], screen = s, selected = true})

		-- Loop awful.tag.add until all var tags have been used.
		Mindi.TagCount = 2
		while (Mindi.TagCount < #Mindi.Tags1+1)
		do
			awful.tag.add(Mindi.Tags1[Mindi.TagCount], {layout = awful.layout.layouts[1], screen = s})
			Mindi.TagCount = Mindi.TagCount+1
		end
	-- If some other tag add tags from Mindi.Tag2 var ( if more than 2 displays remember to change this )
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
	s.mytasklist =	awful.widget.tasklist(s, awful.widget.tasklist.filter.minimizedcurrenttags, tasklist_buttons)

	if s == screen.primary then
	--	Monitor 1 Bar :: width	= Mindi.Bar.Width1
	s.mywibox = awful.wibar({ position	= "top", screen	= s, height	= Mindi.Bar.Height1, border_width = Mindi.Bar.BorderWidth, border_color = beautiful.bg_normal })

	--	Add	widgets	to the wibox
	s.mywibox:setup {
		expand="none",
		layout = wibox.layout.align.horizontal,
		{	-- Left	widgets
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
			s.mytasklist,
		},
		{	-- Middle widgets
			layout = wibox.layout.fixed.horizontal,
			spacing = 4,
		},
		{	-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			spacing = 4,
			Mindi.Bar.Toggles,
			Mindi.Bar.Clock,
		},
     }
	else
	--	Monitor 2 Bar :: width	= Mindi.Bar.Width2
	s.mywibox2 = awful.wibar({position	= "top", screen	= s, height	= Mindi.Bar.Height2, border_width = Mindi.Bar.BorderWidth, border_color = beautiful.bg_normal })

	--	Add	widgets	to the wibox
	s.mywibox2:setup {
		expand="none",
		layout = wibox.layout.align.horizontal,
		{	-- Left	widgets
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
			s.mytasklist,
		},
		{	-- Middle widgets
			layout = wibox.layout.fixed.horizontal,
			spacing = 4,
		},
		{	-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			spacing = 4,
			Mindi.Bar.Cpu,
			Mindi.Bar.Separator,
			Mindi.Bar.Mem,
			Mindi.Bar.Separator,
			Mindi.Bar.Hdd,
			Mindi.Bar.Separator,
			Mindi.Bar.Weather,
			Mindi.Bar.Separator,
			Mindi.Bar.Toggles,
			Mindi.Bar.Clock,
		},
     }                                
	end
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
	awful.key({ 					  }, "Print",   	function() os.execute(Mindi.Command.Screenshot) end),
	awful.key({ Mindi.Mod,			  }, "Return",  	function() awful.spawn(Mindi.Prog.Terminal) end),
	awful.key({ Mindi.Mod,			  }, "e",       	function() awful.spawn(Mindi.Prog.FileManager) end),
	awful.key({ Mindi.Mod,			  }, "d",       	function() menubar.show()	end),
	--	Select with	arrows
	awful.key({ Mindi.Mod,			  }, "Up",   		function() awful.client.focus.global_bydirection("up") end),
	awful.key({ Mindi.Mod,			  }, "Down", 		function() awful.client.focus.global_bydirection("down") end),
	awful.key({ Mindi.Mod,			  }, "Left", 		function() awful.client.focus.global_bydirection("left") end),
	awful.key({ Mindi.Mod,			  }, "Right",		function() awful.client.focus.global_bydirection("right")	end),
	--	Move with arrows
	awful.key({ Mindi.Mod,	"Shift"	  }, "Up",   		function() awful.client.swap.global_bydirection("up")	end),
	awful.key({ Mindi.Mod,	"Shift"	  }, "Down", 		function() awful.client.swap.global_bydirection("down") end),
	awful.key({ Mindi.Mod,	"Shift"	  }, "Left", 		function() awful.client.swap.global_bydirection("left") end),
	awful.key({ Mindi.Mod,	"Shift"	  }, "Right",		function() awful.client.swap.global_bydirection("right") end),
	--	Restart	/ Quit
	awful.key({ Mindi.Mod,	"Control" }, "r",    		awesome.restart),
	awful.key({ Mindi.Mod,	"Shift"	  }, "e",    		awesome.quit),
	-- Media Keys
	awful.key({ Mindi.Mod,}, "m",        				function() awful.spawn(Mindi.Prog.Terminal .. " -e " .. Mindi.Prog.MusicPlayer) end),
	awful.key({ Mindi.Mod,}, "z",        				function() os.execute(Mindi.Command.NPPaste) end),
	awful.key({}, "XF86AudioLowerVolume",				function() awful.spawn('amixer set Master 3%-') end),
	awful.key({}, "XF86AudioRaiseVolume",				function() awful.spawn('amixer set Master 3%+') end),
	awful.key({}, "XF86AudioPlay",       				function() awful.spawn('mocp --play') end),
	awful.key({}, "XF86AudioStop",       				function() awful.spawn('mocp --stop') end),
	awful.key({}, "XF86AudioNext",       				function() awful.spawn('mocp --next') end),
	awful.key({}, "XF86AudioPrev",       				function() awful.spawn('mocp --previous') end),
	-- Other
	awful.key({ Mindi.Mod, "Control" }, "j",    		function() os.execute(Mindi.Command.Buy) end),
	awful.key({ Mindi.Mod, "Control" }, "b",    		function() os.execute(Mindi.Command.Btw) end)
)

clientkeys = gears.table.join(
	awful.key({ Mindi.Mod,			}, "f",     		function (c) c.fullscreen	= not c.fullscreen c:raise() end),
	awful.key({ Mindi.Mod,	"Shift"	}, "q",     		function (c) c:kill() end),
	awful.key({ Mindi.Mod,	"Shift"	}, "space", 		awful.client.floating.toggle),
	awful.key({	Mindi.Mod,			}, "Tab",   		function () for c in awful.client.iterate(function (x) return	true end) do client.focus	= c client.focus:raise() end end),
	awful.key({ Mindi.Mod,	"Shift"	}, "Tab",   		function () awful.client.focus.byidx(1) if client.focus then client.focus:raise() end end)
)

-- Bind	all	key	numbers	to tags.
for	i =	1, 9 do
	globalkeys	= gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ Mindi.Mod	}, "#" .. i	+ 9,
				  function ()
						local	screen = awful.screen.focused()
						local	tag	= screen.tags[i]
						local	current = screen.selected_tag
						if tag then
							tag:view_only()
						end
						if tag == current then
							awful.tag.history.restore()
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
	
-- Lutris / Battle.net
	{ rule_any = {
	class = {
		"battle.net.exe",
		"Lutris",
	},
}, properties = { floating = true, screen = 1, tag = "四" } },

-- Steam
	{ rule_any = {
	class = {
		"Steam",
	},
}, properties = { floating = true, screen = 1, tag = "五"} },
	
-- Chat
	{ rule_any = {
	name = {
		"chat",
		"Friends List",
	},
}, properties = { floating = false, screen = 1, tag = "六" } },

-- MPV Player
	{ rule_any = {
	class = {
		"mpv",
	},
}, properties = { floating = true, screen = 2, tag = "一", height = 720, placement = "centered"  } },
-- properties = { floating = true, screen = 2, tag = "一", height = 720, placement = "centered"  } },
-- Float Stuff
	{ rule_any = {
	class = {
		"Nitrogen",
	},
}, properties = { floating = true } },
	
-- The End	
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

-- Round window corners
client.connect_signal("manage", function (c, startup)
    -- Enable round corners with the shape api
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,4)
		--gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, 16)
    end
end)


client.connect_signal("focus", function(c) c.border_color =	beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color	= beautiful.border_normal end)

-- Autorun
awful.spawn.with_shell(Mindi.Command.Autostart)
