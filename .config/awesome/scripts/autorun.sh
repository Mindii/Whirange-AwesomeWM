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
run redshift &
run unclutter -idle 10 &
#run conky --config=/home/mindi/.config/conky/Conky.conf &
sleep 0.1
run waterfox &
