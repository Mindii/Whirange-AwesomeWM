#!/bin/sh

#-------------------------------------------------------------------------------
#-- Autorun for awesome
#-- Mindi @ Mindinet.org
#-- GNU General Public License v3.0
#-------------------------------------------------------------------------------

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

sleep 0.1
run nitrogen --restore &
#run unagi &
#run conky --config=/home/mindi/.config/conky/Conky.conf &
run unclutter -idle 10 &
sleep 0.1
run waterfox &