#!/bin/bash

# This script starts wifi-menu to select a wifi network and works around
# problems where sometimes the connection fails because the interface is already
# up or wpa_supplicant does not "work", for some unknown reason.
# Reads $WLAN_INTERFACE, which is supposed to provide the wifi interface to use. If not set,
# the interface will be guessed.

set -e

# Try to guess WLAN interface
if [[ ! $WLAN_INTERFACE ]]; then
	WLAN_INTERFACE=$(ifconfig | grep wl | tail | cut -f 1 -d ':')
	echo "No WLAN interface defined in \$WLAN_INTERFACE. I think it is ${WLAN_INTERFACE}."
fi

sudo ip link set dev $WLAN_INTERFACE down
sudo pkill -9 wpa_supplicant
sudo systemctl start wpa_supplicant
sudo wifi-menu
