for l in $(ls /sys/bus/usb/devices/*/power/wakeup); do echo enabled > $l; done
