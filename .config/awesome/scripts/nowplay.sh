#!/bin/bash
export DISPLAY=:0.0
export XAUTHORITY=/home/mindi/.Xauthority

sleep 0.5
info="$(mocp -i)"
artist=$(echo "${info}"|grep Artist:|cut -d ' ' -f2-)
song="$(echo "${info}"|grep SongTitle:|cut -d ' ' -f2-)"
#file="$(mocp -Q %file)"
file="$(echo "${info}"|grep File:|rev|cut -d '/' -f1|rev)"
cover="/$(echo "${info}"|grep File:|rev|cut -d '/' -f2-|rev|cut -d '/' -f2-)/cover.jpg"

# add and song
if [ "$song" != "" ] || [ "$artist" != "" ]; then
	if [ -e "$cover" ]; then
		echo "require('naughty').notify({ title = '${artist}', text='${song}', icon='/${cover}', icon_size='80'})" | awesome-client
	else
		echo "require('naughty').notify({ title = '${artist}', text='${song}'})" | awesome-client
	fi
else
	echo "require('naughty').notify({ title = 'Playing', text='${file}'})" | awesome-client
fi