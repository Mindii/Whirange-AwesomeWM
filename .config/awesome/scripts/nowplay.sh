#!/bin/bash
notify_icon_size="80"
notify_timeout="6"

sleep 0.5
info="$(mocp -i)"
artist="$(echo "${info}"|grep Artist:|cut -d ' ' -f2-)"
song="$(echo "${info}"|grep SongTitle:|cut -d ' ' -f2-)"
file="$(echo "${info}"|grep File:|rev|cut -d '/' -f1|rev)"
folder="/$(echo "${info}"|grep File:|rev|cut -d '/' -f2-|rev|cut -d '/' -f2-)"
cover_exists="$(find "${folder}/" -iname "cover.*")"

# Set Cover
if [ ! -e "${cover_exists}" ]; then
	cover_exists="$(find "${folder}/" -iname "folder.*")"
	if [ ! -e "${cover_exists}" ]; then
		cover_exists=""${HOME}"/.config/awesome/themes/whirange/icon/test.png"
	fi
fi

# If there is no tag's and cover then show only file name
if [ "$song" != "" ] && [ "$artist" != "" ] && [ -e "${cover_exists}" ]; then
		echo "require('naughty').notify({ title='${artist}', text='${song}', icon='${cover_exists}', icon_size='${notify_icon_size}', timeout=${notify_timeout}})" | awesome-client
else
	echo "require('naughty').notify({ title = 'Playing', text='${file}', timeout=${notify_timeout}})" | awesome-client
fi