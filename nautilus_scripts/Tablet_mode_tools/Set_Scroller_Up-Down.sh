#!/bin/bash
# NAUTILUS SCRIPT
# for Ubuntu 16.04

#102: Home
#103: Up
#104: Prior
#105: Left
#106: Right
#107: End
#108: Down
#109: Next

setter () {
  sudo setkeycodes e006 103
  sudo setkeycodes e007 108
}
export -f setter

gnome-terminal --execute bash -c 'setter; bash'
