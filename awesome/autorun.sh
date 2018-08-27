#!/bin/sh

# --------------------------
# Whirange Autorun Script
# --------------------------

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run xrandr --auto --output DP-1 --primary --mode 2560x1440 --rate 143.91 --left-of DVI-D-0 &
run nitrogen --restore &