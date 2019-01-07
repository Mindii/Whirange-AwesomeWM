# Awesome dots WIP
These are my config files for [Awesome](https://awesomewm.org/) and other stuff.

![alt tag](https://raw.githubusercontent.com/Mindii/Whirange-AwesomeWM/master/images/1540401194_screen.png)
<br>Clean<br>
![alt tag](https://raw.githubusercontent.com/Mindii/Whirange-AwesomeWM/master/images/1540401277_screen.png)
<br>Calender + Events tooltip from clock<br>
![alt tag](https://raw.githubusercontent.com/Mindii/Whirange-AwesomeWM/master/images/1540401388_screen.png)
<br>Moc Notification<br>

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
- [Awesome](https://www.archlinux.org/packages/community/x86_64/awesome/)
- [Redshift](https://www.archlinux.org/packages/community/x86_64/redshift/)
- [Compton](https://www.archlinux.org/packages/community/x86_64/compton/)
- [MOC](http://moc.daper.net/)
- [xdotool](https://www.archlinux.org/packages/community/x86_64/xdotool/)
- [ffmpeg](https://www.archlinux.org/packages/extra/x86_64/ffmpeg/)
- [Zsh](https://www.archlinux.org/packages/extra/x86_64/zsh/)
- [Oh My Zsh](https://aur.archlinux.org/packages/oh-my-zsh-git/)

- [Tewi](https://aur.archlinux.org/packages/bdf-tewi-git/)
- [Fontawesome](https://www.archlinux.org/packages/community/any/awesome-terminal-fonts/)
- [Han Sans](https://www.archlinux.org/packages/community/any/adobe-source-han-sans-jp-fonts/)

# Crontab
0 */4 * * * /bin/bash /home/USER/.config/awesome/scripts/weather_update update<br>
*/15 * * * *  /bin/bash /home/USER/.config/awesome/scripts/events_update update

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
