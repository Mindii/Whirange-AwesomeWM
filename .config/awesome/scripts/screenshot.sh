#!/bin/sh

# --------------------------
# Whirange Screenshot Script
# --------------------------

mscreen="/home/$USER/Pictures/Screenshots/$(date +%Y)/$(date +%m)/$(date +%d)"

if [ ! -d "$mscreen/" ]; then
	mkdir -p $mscreen/
fi

sleep 0.2

scrot -s $mscreen'/%s_screen.png'