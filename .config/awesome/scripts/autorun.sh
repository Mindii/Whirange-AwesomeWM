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
run compton &
run unclutter -idle 8 &

sleep 0.1
run firefox &
