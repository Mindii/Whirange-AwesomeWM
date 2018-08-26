#!/bin/sh
mscreen="/home/mindi/Pictures/Screenshots/$(date +%d.%m.%Y)"

if [ ! -d "$mscreen/" ]; then
	mkdir -p $mscreen/
fi

sleep 0.2

scrot -s $mscreen'/%s_screen.png'
