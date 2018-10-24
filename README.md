# Awesome dots WIP
These are my config files for [Awesome](https://awesomewm.org/) and other stuff.

![alt tag](https://raw.githubusercontent.com/Mindii/Whirange-AwesomeWM/master/images/1540399605_screen.png)

# Progress
- [ ] Key bindings
    - [x] Basics
    - [x] Media Keys
    - [x] Some i3wm style binds
    - [ ] ..
- [ ] Scripts
    - [x] Now Playing for [MOC](http://moc.daper.net/) notifications
    - [x] Scrobbling to last.fm & libre.fm with [mocp-scrobbler](https://aur.archlinux.org/packages/mocp-scrobbler/)
    - [x] Autostart for programs
    - [x] Now Playing paste
    - [ ] URL to mpv
- [ ] Whirange Theme
    - [x] [Awesome](https://awesomewm.org/)
    - [x] [MOC](http://moc.daper.net/)
    - [x] [Hexchat](https://hexchat.github.io/)
    - [ ] ..
- [x] Toolbar
  - [x] Basics 
  - [x] Widgets
  - [x] Fonts
- [ ] Notifications
  - [x] [MOC](http://moc.daper.net/) - Now Playing
- [ ] Custom layouts for Awesome

# Requirements
- Awesome
- Fontawesome
- MOC
- xdotool
- ffmpeg

# Crontab
0 */4 * * * /bin/bash /home/<user>/.config/awesome/scripts/weather_update update
*/15 * * * *  /bin/bash /home/<user>/.config/awesome/scripts/events_update update

# Key bindings
`Mod` Win Key

- `Print + Click` Screenshot
- `Mod + Shift + e` Exit awesome
- `Mod + Ctrl + r` Restart awesome
- `Mod + f` Fullscreen
- `Mod + Arrows` Change focused window
- `Mod + Shift + Arrows` Move focused window
- `Mod + Shift + q` Kill focused window
- `Mod + Shift + Space` Toggle float

- `Mod + Enter` Open Terminal
- `Mod + d` Open Launcher
- `Mod + e` Open File manager
- `Mod + m` Open MOC
- `Mod + z` Nowplaying string to current window

# Screenshots
![alt tag](https://raw.githubusercontent.com/Mindii/Whirange-AwesomeWM/master/images/1535628857_screen.png)
Moc + Notification
