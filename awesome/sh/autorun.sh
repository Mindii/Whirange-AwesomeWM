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

run nitrogen --restore &