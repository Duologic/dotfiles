#!/bin/bash
#set -euo pipefail

sudo systemctl stop bluetooth
sudo rfkill block bluetooth
sudo modprobe -r btusb
sleep 2

sudo modprobe btusb
sudo rfkill unblock bluetooth
sudo systemctl start bluetooth
sleep 2

bluetoothctl agent KeyboardOnly
bluetoothctl default-agent
bluetoothctl power on
bluetoothctl pair 80:4A:14:71:52:99
bluetoothctl connect 80:4A:14:71:52:99
